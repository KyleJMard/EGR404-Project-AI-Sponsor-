import functions_framework
from google.cloud import firestore
from flask import request, jsonify
from openai import OpenAI
import os
import math

# ---------- Setup ----------
db = firestore.Client()

OPENAI_API_KEY = os.environ.get("OPENAI_API_KEY")
if not OPENAI_API_KEY:
    raise RuntimeError("OPENAI_API_KEY is not set")

client = OpenAI(api_key=OPENAI_API_KEY)

# ---------- Knowledge Base ----------
knowledge = [
    "Drinking more than 14 drinks per week increases long-term health risks.",
    "Alcohol calories contribute significantly to weight gain.",
    "Spacing drinks over time reduces intoxication and health impact.",
    "Frequent drinking patterns can indicate habit formation.",
    "Weekend binge drinking is associated with higher health risks.",
    "Gradually reducing alcohol intake is more sustainable than stopping abruptly."
]

embedded_knowledge = []

# ---------- Initialize embeddings ----------
def init_embeddings():
    global embedded_knowledge

    if embedded_knowledge:
        return

    try:
        for text in knowledge:
            emb = client.embeddings.create(
                model="text-embedding-3-small",
                input=text
            )
            embedded_knowledge.append({
                "text": text,
                "embedding": emb.data[0].embedding
            })
    except Exception as e:
        print("Embedding error:", str(e))
        embedded_knowledge = []

# ---------- Cosine similarity ----------
def cosine_similarity(a, b):
    try:
        dot = sum(x * y for x, y in zip(a, b))
        norm_a = math.sqrt(sum(x * x for x in a))
        norm_b = math.sqrt(sum(x * x for x in b))

        if norm_a == 0 or norm_b == 0:
            return 0

        return dot / (norm_a * norm_b)
    except:
        return 0

# ---------- Retrieve context ----------
def retrieve_context(summary_text):
    if not embedded_knowledge:
        return []

    try:
        query_emb = client.embeddings.create(
            model="text-embedding-3-small",
            input=summary_text
        ).data[0].embedding

        scored = [
            (cosine_similarity(query_emb, item["embedding"]), item["text"])
            for item in embedded_knowledge
        ]

        scored.sort(reverse=True)
        return [text for _, text in scored[:3]]

    except Exception as e:
        print("RAG retrieval error:", str(e))
        return []

# ---------- Main Function ----------
@functions_framework.http
def generate_insight(request):
    try:
        # ---------- Parse request ----------
        data = request.get_json(silent=True) or {}

        uid = str(data.get("uid", "")).strip()
        if not uid:
            return jsonify({"error": "Missing uid"}), 400

        print("UID RECEIVED:", uid)

        # ---------- Fetch data ----------
        docs = db.collection("drinkTotals") \
                 .where("ownerUid", "==", uid) \
                 .where("removed", "==", False) \
                 .stream()

        total_drinks = 0
        total_calories = 0
        total_cost = 0

        for doc in docs:
            d = doc.to_dict()
            total_drinks += d.get("count", 0)
            total_calories += d.get("calories", 0)
            total_cost += d.get("cost", 0)

        # ---------- Build summary ----------
        summary_text = f"""
        The user consumed {total_drinks} drinks,
        totaling {total_calories} calories,
        and spent ${total_cost}.
        """

        # ---------- RAG ----------
        init_embeddings()
        context = retrieve_context(summary_text)

        if not context:
            context = ["No additional guidance available."]

        # ---------- OpenAI ----------
        response = client.responses.create(
            model="gpt-4o-mini",
            input=f"""
            User drinking summary:
            {summary_text}

            Relevant guidance:
            {context}

            Provide:
            - One insight
            - One actionable recommendation

            Format:
            - Plain text only
            - No markdown, no symbols, no line breaks
            - Max 2 sentences
            """
        )

        # ---------- Extract output ----------
        if hasattr(response, "output_text") and response.output_text:
            raw = response.output_text
        else:
            raw = response.output[0].content[0].text

        ai_summary = raw.replace("*", "").replace("\n", " ").strip()

        # ---------- Return ----------
        return jsonify({
            "ai_summary": ai_summary,
            "totals": {
                "drinks": total_drinks,
                "calories": total_calories,
                "cost": total_cost
            }
        })

    except Exception as e:
        print("FUNCTION ERROR:", str(e))
        return jsonify({"error": str(e)}), 500
