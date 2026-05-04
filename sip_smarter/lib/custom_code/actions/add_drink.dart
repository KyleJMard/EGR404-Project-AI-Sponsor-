// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

DateTime _localDayStart(DateTime t) => DateTime(t.year, t.month, t.day);
DateTime _localMonthStart(DateTime t) => DateTime(t.year, t.month, 1);
DateTime _localYearStart(DateTime t) => DateTime(t.year, 1, 1);

String _yyyyMMdd(DateTime t) {
  final y = t.year.toString().padLeft(4, '0');
  final m = t.month.toString().padLeft(2, '0');
  final d = t.day.toString().padLeft(2, '0');
  return '$y$m$d';
}

String _yyyyMM(DateTime t) {
  final y = t.year.toString().padLeft(4, '0');
  final m = t.month.toString().padLeft(2, '0');
  return '$y$m';
}

String _yyyy(DateTime t) => t.year.toString().padLeft(4, '0');

double _standardDrinksFromMlAndAbv(double beverageMl, double abvPercent) {
  if (beverageMl <= 0 || abvPercent <= 0) return 0.0;
  final ethanolMl = beverageMl * (abvPercent / 100.0);
  return ethanolMl / 17.74;
}

String _slug(String s) => s
    .trim()
    .toLowerCase()
    .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
    .replaceAll(RegExp(r'_+'), '_')
    .replaceAll(RegExp(r'^_|_$'), '');

double _parseMoney(String? s) {
  if (s == null) return 0.0;
  final cleaned = s.trim().replaceAll(RegExp(r'[^0-9\.\-]'), '');
  final v = double.tryParse(cleaned);
  if (v == null || !v.isFinite || v < 0) return 0.0;
  return v;
}

int _toCents(double v) => (v * 100.0).round();

String _normalizeDrinkType(String? drinkType) {
  final t = (drinkType ?? '').trim();
  if (t == 'oz') return 'oz';
  if (t == 'Cups') return 'Cups';
  if (t == 'mL') return 'mL';
  return 'mL';
}

int _convertToMlInt(int rawSize, String drinkTypeNormalized) {
  if (rawSize <= 0) return 0;

  if (drinkTypeNormalized == 'oz') {
    final ml = rawSize * 29.5735295625;
    return ml.round();
  }
  if (drinkTypeNormalized == 'Cups') {
    final ml = rawSize * 236.5882365;
    return ml.round();
  }
  return rawSize;
}

Future<int?> addDrink(
  BuildContext context,
  String drinkKey,
  String name,
  int? sizeMl,
  String? drinkType, // "mL", "Cups", or "oz"
  double? abv,
  int? count,
  String? unitCostText,
  String? tabName,
  int? calories, // ✅ NEW PARAMETER (per-unit calories)
) async {
  final uid = currentUserUid;
  if (uid.isEmpty) {
    debugPrint('addDrink: no user');
    return null;
  }

  final firestore = FirebaseFirestore.instance;

  final safeKey = _slug(drinkKey);

  final String tabNameSafeDisplay =
      (tabName != null && tabName.trim().isNotEmpty)
          ? tabName.trim()
          : 'Default';
  final String tabKey = _slug(tabNameSafeDisplay);

  int incrementAmount = 1;
  if (count != null && count > 0) incrementAmount = count;

  final double unitCost = _parseMoney(unitCostText);
  final int unitCostCents = _toCents(unitCost);

  // Calories: treat null/negative as 0
  final int unitCalories = (calories != null && calories > 0) ? calories : 0;

  final userRef = firestore.collection('users').doc(uid);
  final logsRef = firestore.collection('drinks');
  final dailyBaseRef = firestore.collection('dailyDrinkLog');
  final monthlyBaseRef = firestore.collection('monthlyDrinkLog');
  final yearlyBaseRef = firestore.collection('yearlyDrinkLog');

  int? newCount;
  String? usedDocId;

  try {
    await firestore.runTransaction((tx) async {
      final now = DateTime.now();
      final nowMs = now.millisecondsSinceEpoch;

      final dayStart = _localDayStart(now);
      final dayEnd = dayStart.add(const Duration(days: 1));
      final dayKey = _yyyyMMdd(dayStart);

      // Day-scoped drinkTotals doc
      final docId = '${uid}_${dayKey}_${tabKey}_${safeKey}_$unitCostCents';
      usedDocId = docId;

      final totalsRef = firestore.collection('drinkTotals').doc(docId);

      final dailyDocId = '${uid}_$dayKey';
      final dailyRef = dailyBaseRef.doc(dailyDocId);

      final monthStart = _localMonthStart(dayStart);
      final monthKey = _yyyyMM(monthStart);
      final monthlyDocId = '${uid}_$monthKey';
      final monthlyRef = monthlyBaseRef.doc(monthlyDocId);

      final yearStart = _localYearStart(dayStart);
      final yearKey = _yyyy(yearStart);
      final yearlyDocId = '${uid}_$yearKey';
      final yearlyRef = yearlyBaseRef.doc(yearlyDocId);

      final String drinkTypeNorm = _normalizeDrinkType(drinkType);

      final int rawSize = sizeMl ?? 0;
      final int storedSizeMl = _convertToMlInt(rawSize, drinkTypeNorm);
      final bool hasValidSize = storedSizeMl > 0;

      final double mlDelta = (storedSizeMl * incrementAmount).toDouble();

      int sdDeltaInt = 0;
      final double abvUsed = (abv ?? 0.0);
      if (abvUsed > 0 && mlDelta > 0) {
        sdDeltaInt = _standardDrinksFromMlAndAbv(mlDelta, abvUsed).round();
      }

      final double costDelta = unitCost * incrementAmount;

      // ✅ Calories delta for this add
      final int caloriesDelta = unitCalories * incrementAmount;

      final userSnap = await tx.get(userRef);
      final userData = userSnap.data() as Map<String, dynamic>?;
      final existingFirstMs =
          (userData?['firstDrinkTimestampMs'] as num?)?.toInt();
      final bool shouldSetFirst =
          existingFirstMs == null || existingFirstMs <= 0;

      final snap = await tx.get(totalsRef);

      if (!snap.exists) {
        tx.set(totalsRef, {
          'docId': docId,
          'ownerUid': uid,
          'drinkKey': safeKey,
          'name': name,

          'tabName': tabNameSafeDisplay,
          'tabKey': tabKey,

          'drinkType': drinkTypeNorm,
          if (hasValidSize) 'size_ml': storedSizeMl,
          if (abv != null) 'abv': abv,

          'unit_cost': unitCost,

          // ✅ Store per-unit calories (so you have it on the doc)
          'unit_calories': unitCalories,
          // ✅ Accumulative calories for this drinkTotals doc
          'calories': caloriesDelta,

          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'lastAddedAt': FieldValue.serverTimestamp(),
          'lastDrinkTimestampMs': nowMs,

          'removed': false,
          'count': incrementAmount,

          'total_ml_consumed': mlDelta,
          'cost': costDelta,

          'dayKey': dayKey,
          'dayStart': dayStart,
          'dayEnd': dayEnd,
          'date': dayStart,
        });

        newCount = incrementAmount;
      } else {
        final data = snap.data() as Map<String, dynamic>? ?? {};
        final current = (data['count'] as num?)?.toInt() ?? 0;
        final next = current + incrementAmount;

        final updateData = <String, dynamic>{
          'updatedAt': FieldValue.serverTimestamp(),
          'lastAddedAt': FieldValue.serverTimestamp(),
          'lastDrinkTimestampMs': nowMs,
          'removed': false,
          'count': next,
          'total_ml_consumed': FieldValue.increment(mlDelta),
          'cost': FieldValue.increment(costDelta),
          'unit_cost': unitCost,
          'tabName': tabNameSafeDisplay,
          'tabKey': tabKey,
          'drinkType': drinkTypeNorm,
        };

        if (abv != null) updateData['abv'] = abv;
        if (hasValidSize) updateData['size_ml'] = storedSizeMl;

        // ✅ Keep per-unit calories updated and increment total calories
        updateData['unit_calories'] = unitCalories;
        if (caloriesDelta != 0) {
          updateData['calories'] = FieldValue.increment(caloriesDelta);
        }

        tx.update(totalsRef, updateData);
        newCount = next;
      }

      // dailyDrinkLog
      final dailyUpsert = <String, dynamic>{
        'uid': userRef,
        'dayStart': dayStart,
        'dayEnd': dayEnd,
        'monthKey': monthKey,
        'dailyRemoved': false,
        'updatedAt': FieldValue.serverTimestamp(),
        'totalMl': FieldValue.increment(mlDelta),
        'totalCost': FieldValue.increment(costDelta),

        // ✅ NEW: daily calories aggregate
        if (caloriesDelta != 0)
          'dailyCalories': FieldValue.increment(caloriesDelta),
      };

      if (sdDeltaInt != 0) {
        dailyUpsert['totalStandardDrinks'] = FieldValue.increment(sdDeltaInt);
      }

      tx.set(dailyRef, dailyUpsert, SetOptions(merge: true));

      // month/year index docs
      tx.set(
        monthlyRef,
        {
          'uid': uid,
          'monthKey': monthKey,
          'yearKey': yearKey,
          'monthStart': monthStart,
          'monthlyRemoved': false,
        },
        SetOptions(merge: true),
      );

      tx.set(
        yearlyRef,
        {
          'uid': uid,
          'yearKey': yearKey,
          'yearStart': yearStart,
          'yearlyRemoved': false,
        },
        SetOptions(merge: true),
      );

      final userUpdate = <String, dynamic>{
        'lastDrinkTimestampMs': nowMs,
        'lastDrinkAt': FieldValue.serverTimestamp(),
      };
      if (shouldSetFirst) {
        userUpdate['firstDrinkTimestampMs'] = nowMs;
        userUpdate['firstDrinkAt'] = FieldValue.serverTimestamp();
      }
      tx.set(userRef, userUpdate, SetOptions(merge: true));

      // raw log row (optional but useful: store unit calories on the raw event)
      final logRef = logsRef.doc();
      tx.set(logRef, {
        'user': uid,
        'name': name,
        'drinkType': drinkTypeNorm,
        if (hasValidSize) 'size_ml': storedSizeMl,
        'tabName': tabNameSafeDisplay,
        'tabKey': tabKey,
        if (abv != null) 'abv': abv,
        'drinkKey': safeKey,
        'totalsDocId': docId,

        // ✅ store calories on the log event too (per-unit)
        'unit_calories': unitCalories,

        'currentTime': FieldValue.serverTimestamp(),
        'currentTimeMs': nowMs,
        'removed': false,
        'unit_cost': unitCost,
      });
    });

    debugPrint('addDrink → $usedDocId = $newCount');
    return newCount;
  } catch (e, st) {
    debugPrint('[addDrink][ERROR] $e');
    debugPrint('$st');
    return null;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
