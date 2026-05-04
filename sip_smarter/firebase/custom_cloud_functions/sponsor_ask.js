/**
 * Firebase Cloud Function: sponsorAsk
 *
 * Expects:
 *  - Authorization: Bearer <Firebase ID Token>
 *  - JSON body:
 *      {
 *        "prompt": "How am I doing this week?",
 *        "mode": "supportive" | "cautious" | "firm" (optional),
 *        "tzOffsetMinutes": -300 (optional; e.g., EST=-300, PST=-480)
 *      }
 *
 * Returns (JSON):
 *  {
 *    "message": "...",
 *    "insights": ["..."],
 *    "questions": ["..."],
 *    "suggested_actions": [{ "type": "...", "detail": "..." }],
 *    "numbers_used": { ... },
 *    "stats": { ... }   // computed totals you can also display
 *  }
 */

const functions = require("firebase-functions");
const admin = require("firebase-admin");

if (!admin.apps.length) admin.initializeApp();

const db = admin.firestore();

function requireEnv(name) {
  const v = process.env[name];
  if (!v) throw new Error(`Missing env var: ${name}`);
  return v;
}

function getBearerToken(req) {
  const auth = req.headers.authorization || "";
  const m = auth.match(/^Bearer (.+)$/i);
  return m ? m[1] : null;
}

// ----- Time helpers (timezone offset based; avoids extra deps) -----
// tzOffsetMinutes: e.g. -300 means local = UTC-5
function nowMs() {
  return Date.now();
}

function toLocalMs(utcMs, tzOffsetMinutes) {
  return utcMs + tzOffsetMinutes * 60 * 1000;
}
function toUtcMs(localMs, tzOffsetMinutes) {
  return localMs - tzOffsetMinutes * 60 * 1000;
}

function startOfLocalDayUtcMs(utcMs, tzOffsetMinutes) {
  const local = new Date(toLocalMs(utcMs, tzOffsetMinutes));
  local.setHours(0, 0, 0, 0);
  return toUtcMs(local.getTime(), tzOffsetMinutes);
}

// Week definition: Monday 00:00 local → next Monday 00:00 local
function startOfLocalWeekUtcMs(utcMs, tzOffsetMinutes) {
  const local = new Date(toLocalMs(utcMs, tzOffsetMinutes));
  // JS: Sunday=0, Monday=1, ... Saturday=6
  const day = local.getDay();
  const mondayIndex = 1;
  const diffToMonday = (day - mondayIndex + 7) % 7; // 0 if Monday
  local.setDate(local.getDate() - diffToMonday);
  local.setHours(0, 0, 0, 0);
  return toUtcMs(local.getTime(), tzOffsetMinutes);
}

function startOfLocalMonthUtcMs(utcMs, tzOffsetMinutes) {
  const local = new Date(toLocalMs(utcMs, tzOffsetMinutes));
  local.setDate(1);
  local.setHours(0, 0, 0, 0);
  return toUtcMs(local.getTime(), tzOffsetMinutes);
}

function startOfLocalYearUtcMs(utcMs, tzOffsetMinutes) {
  const local = new Date(toLocalMs(utcMs, tzOffsetMinutes));
  local.setMonth(0, 1); // Jan 1
  local.setHours(0, 0, 0, 0);
  return toUtcMs(local.getTime(), tzOffsetMinutes);
}

function endUtcMsFromStartLocal(startUtcMs, days) {
  return startUtcMs + days * 24 * 60 * 60 * 1000;
}

// Aggregate dailyDrinkLog docs in [startUtc, endUtc)
async function aggregateDailyLogs(userRef, startUtcMs, endUtcMs) {
  const startTs = admin.firestore.Timestamp.fromMillis(startUtcMs);
  const endTs = admin.firestore.Timestamp.fromMillis(endUtcMs);

  // NOTE: We do NOT filter dailyRemoved == false in the query
  // because missing field would exclude docs. Instead we skip in code.
  const snap = await db
    .collection("dailyDrinkLog")
    .where("uid", "==", userRef)
    .where("dayStart", ">=", startTs)
    .where("dayStart", "<", endTs)
    .get();

  let totalMl = 0;
  let totalStd = 0;
  let totalCost = 0;
  let daysActive = 0;

  for (const doc of snap.docs) {
    const d = doc.data() || {};
    if (d.dailyRemoved === true) continue;

    const ml = typeof d.totalMl === "number" ? d.totalMl : 0;
    const std =
      typeof d.totalStandardDrinks === "number" ? d.totalStandardDrinks : 0;
    const cost = typeof d.totalCost === "number" ? d.totalCost : 0;

    // "Active day" means user logged >0 consumption
    if (ml > 0 || std > 0) daysActive += 1;

    totalMl += ml;
    totalStd += std;
    totalCost += cost;
  }

  return {
    docCount: snap.size,
    daysActive,
    totalMl: Number(totalMl.toFixed(2)),
    totalStandardDrinks: Math.round(totalStd),
    totalCost: Number(totalCost.toFixed(2)),
  };
}

// OpenAI call: Responses API with strict JSON schema
async function callOpenAISponsor({ prompt, mode, stats }) {
  const apiKey = requireEnv("OPENAI_API_KEY");

  const system = [
    "You are SipSmart's AI Sponsor: supportive, non-judgmental, and practical.",
    "Your job is to help the user curb alcohol consumption and reflect on habits.",
    "You may reference the provided stats (week/month/year) but do not invent numbers.",
    "Avoid medical claims. Do not give definitive 'safe to drink X' instructions.",
    "Encourage safety (e.g., do not drive) when relevant.",
    "If user asks for limits, suggest harm-reduction and goal-based guidance, not medical certainty.",
    "Return only valid JSON that matches the schema exactly.",
  ].join(" ");

  const schema = {
    type: "object",
    additionalProperties: false,
    properties: {
      message: { type: "string" },
      insights: {
        type: "array",
        items: { type: "string" },
        maxItems: 5,
      },
      questions: {
        type: "array",
        items: { type: "string" },
        maxItems: 3,
      },
      suggested_actions: {
        type: "array",
        items: {
          type: "object",
          additionalProperties: false,
          properties: {
            type: {
              type: "string",
              enum: [
                "pause",
                "hydrate",
                "eat",
                "set_limit",
                "plan",
                "reflect",
                "stop_for_night",
              ],
            },
            detail: { type: "string" },
          },
          required: ["type", "detail"],
        },
        maxItems: 4,
      },
      numbers_used: {
        type: "object",
        additionalProperties: false,
        properties: {
          week_standard_drinks: { type: "number" },
          month_standard_drinks: { type: "number" },
          year_standard_drinks: { type: "number" },
          week_ml: { type: "number" },
          month_ml: { type: "number" },
          year_ml: { type: "number" },
        },
        required: [
          "week_standard_drinks",
          "month_standard_drinks",
          "year_standard_drinks",
          "week_ml",
          "month_ml",
          "year_ml",
        ],
      },
    },
    required: [
      "message",
      "insights",
      "questions",
      "suggested_actions",
      "numbers_used",
    ],
  };

  const body = {
    model: "gpt-4.1-mini",
    input: [
      { role: "system", content: system },
      {
        role: "user",
        content:
          `Mode: ${mode}\n` +
          `User prompt: ${prompt}\n\n` +
          `Stats (authoritative): ${JSON.stringify(stats)}`,
      },
    ],
    response_format: {
      type: "json_schema",
      json_schema: {
        name: "SipSmartSponsorResponse",
        strict: true,
        schema,
      },
    },
  };

  const resp = await fetch("https://api.openai.com/v1/responses", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${apiKey}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify(body),
  });

  if (!resp.ok) {
    const txt = await resp.text();
    throw new Error(`OpenAI error ${resp.status}: ${txt}`);
  }

  const data = await resp.json();

  // Responses API returns structured output; the parsed JSON is typically in output_text,
  // but with json_schema it should be valid JSON somewhere in the output.
  // We'll extract the first JSON-looking text block safely.
  const outputText = (data.output_text || "").trim();
  if (!outputText) {
    throw new Error("OpenAI returned empty output_text.");
  }

  let parsed;
  try {
    parsed = JSON.parse(outputText);
  } catch (e) {
    throw new Error(`Failed to parse OpenAI JSON: ${outputText}`);
  }

  return parsed;
}

exports.sponsorAsk = functions.https.onRequest(async (req, res) => {
  // Basic CORS (adjust origin if you want to restrict)
  res.set("Access-Control-Allow-Origin", "*");
  res.set("Access-Control-Allow-Methods", "POST, OPTIONS");
  res.set("Access-Control-Allow-Headers", "Content-Type, Authorization");

  if (req.method === "OPTIONS") return res.status(204).send("");
  if (req.method !== "POST") return res.status(405).json({ error: "Use POST" });

  try {
    const token = getBearerToken(req);
    if (!token)
      return res
        .status(401)
        .json({ error: "Missing Authorization Bearer token" });

    const decoded = await admin.auth().verifyIdToken(token);
    const uid = decoded.uid;
    const userRef = db.collection("users").doc(uid);

    const prompt = (
      req.body && req.body.prompt ? String(req.body.prompt) : ""
    ).trim();
    if (!prompt) return res.status(400).json({ error: "Missing prompt" });

    const mode = (
      req.body && req.body.mode ? String(req.body.mode) : "supportive"
    ).trim();

    // tzOffsetMinutes: recommended to pass from client (device timezone offset)
    // JS Date.getTimezoneOffset() returns minutes to add to local to get UTC (opposite sign),
    // so in FlutterFlow compute carefully. Here we expect: local = UTC + offsetMinutes
    // Example: EST (UTC-5) => offsetMinutes = -300
    const tzOffsetMinutes =
      req.body && Number.isFinite(req.body.tzOffsetMinutes)
        ? Number(req.body.tzOffsetMinutes)
        : 0;

    const now = nowMs();

    const todayStartUtc = startOfLocalDayUtcMs(now, tzOffsetMinutes);
    const weekStartUtc = startOfLocalWeekUtcMs(now, tzOffsetMinutes);
    const monthStartUtc = startOfLocalMonthUtcMs(now, tzOffsetMinutes);
    const yearStartUtc = startOfLocalYearUtcMs(now, tzOffsetMinutes);
    const tomorrowStartUtc = todayStartUtc + 24 * 60 * 60 * 1000;

    const today = await aggregateDailyLogs(
      userRef,
      todayStartUtc,
      tomorrowStartUtc,
    );
    const week = await aggregateDailyLogs(
      userRef,
      weekStartUtc,
      tomorrowStartUtc,
    );
    const month = await aggregateDailyLogs(
      userRef,
      monthStartUtc,
      tomorrowStartUtc,
    );
    const year = await aggregateDailyLogs(
      userRef,
      yearStartUtc,
      tomorrowStartUtc,
    );

    const stats = {
      rangesUtcMs: {
        todayStartUtc,
        weekStartUtc,
        monthStartUtc,
        yearStartUtc,
        endUtc: tomorrowStartUtc,
      },
      today,
      week,
      month,
      year,
    };

    const sponsor = await callOpenAISponsor({ prompt, mode, stats });

    // Include the stats so your UI can show “used data” cards if you want.
    return res.status(200).json({
      ...sponsor,
      stats,
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: String(err.message || err) });
  }
});
