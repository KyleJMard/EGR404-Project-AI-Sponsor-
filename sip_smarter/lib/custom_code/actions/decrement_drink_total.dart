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

String _yyyyMMdd(DateTime t) {
  final y = t.year.toString().padLeft(4, '0');
  final m = t.month.toString().padLeft(2, '0');
  final d = t.day.toString().padLeft(2, '0');
  return '$y$m$d';
}

/// US standard drink: 14g ethanol.
/// Ethanol density ≈ 0.789 g/mL => 14g ≈ 17.74 mL ethanol.
double _standardDrinksFromMlAndAbv(double beverageMl, double abvPercent) {
  if (beverageMl <= 0 || abvPercent <= 0) return 0.0;
  final ethanolMl = beverageMl * (abvPercent / 100.0);
  return ethanolMl / 17.74;
}

/// Remove N units from a drinkTotals doc, and keep dailyDrinkLog in sync:
/// - drinkTotals: count, removed, total_ml_consumed, cost, calories
/// - dailyDrinkLog: totalMl, totalStandardDrinks, totalCost, dailyCalories
/// Also preserves your timer-reset behavior (reset to now if drinks remain, else zero).
Future<int?> decrementDrinkTotal(
  BuildContext context,
  String totalsDocId,
  int deleteCount,
) async {
  final uid = currentUserUid;
  if (uid.isEmpty) return null;

  final firestore = FirebaseFirestore.instance;
  final totalsCol = firestore.collection('drinkTotals');
  final totalsRef = totalsCol.doc(totalsDocId);
  final userRef = firestore.collection('users').doc(uid);
  final dailyBaseRef = firestore.collection('dailyDrinkLog');

  int? nextCount;
  bool removedNow = false;

  try {
    await firestore.runTransaction((tx) async {
      final snap = await tx.get(totalsRef);
      if (!snap.exists) {
        nextCount = 0;
        return;
      }

      final data = snap.data() as Map<String, dynamic>? ?? {};

      final owner = data['ownerUid'] as String? ?? '';
      if (owner != uid) {
        nextCount = (data['count'] as num?)?.toInt() ?? 0;
        return;
      }

      final current = (data['count'] as num?)?.toInt() ?? 0;
      if (current <= 0) {
        nextCount = 0;
        return;
      }

      // Normalize deleteCount
      int n = deleteCount;
      if (n <= 0) {
        nextCount = current; // no-op
        return;
      }
      if (n > current) n = current;

      // ---- Per-unit info ----
      final int sizeMl = (data['size_ml'] as num?)?.toInt() ?? 0;
      final double abvUsed = (data['abv'] as num?)?.toDouble() ?? 0.0;

      // Cost: prefer unit_cost; fallback to cost/count if unit_cost is missing
      final double storedUnitCost =
          (data['unit_cost'] as num?)?.toDouble() ?? 0.0;
      final double storedCost = (data['cost'] as num?)?.toDouble() ?? 0.0;

      double unitCostUsed = storedUnitCost;
      if (unitCostUsed <= 0 && storedCost > 0 && current > 0) {
        unitCostUsed = storedCost / current;
      }
      if (!unitCostUsed.isFinite || unitCostUsed < 0) unitCostUsed = 0.0;

      // Calories: prefer unit_calories; fallback to calories/count if missing
      final int storedUnitCalories =
          (data['unit_calories'] as num?)?.toInt() ?? 0;
      final int storedCaloriesTotal = (data['calories'] as num?)?.toInt() ?? 0;

      int unitCaloriesUsed = storedUnitCalories;
      if (unitCaloriesUsed <= 0 && storedCaloriesTotal > 0 && current > 0) {
        unitCaloriesUsed = (storedCaloriesTotal / current).round();
      }
      if (unitCaloriesUsed < 0) unitCaloriesUsed = 0;

      // ---- Deltas for N units ----
      final double mlDelta = (sizeMl * n).toDouble();

      int sdDeltaInt = 0;
      if (abvUsed > 0 && sizeMl > 0 && n > 0) {
        sdDeltaInt = _standardDrinksFromMlAndAbv(mlDelta, abvUsed).round();
      }

      final double costDelta = unitCostUsed * n;
      final int caloriesDelta = unitCaloriesUsed * n;

      // ---- Determine daily bucket ----
      String dayKey = (data['dayKey'] as String?) ?? '';

      DateTime? dayStart;
      DateTime? dayEnd;

      final dynamic dayStartField = data['dayStart'];
      final dynamic dayEndField = data['dayEnd'];

      if (dayStartField is Timestamp) dayStart = dayStartField.toDate();
      if (dayStartField is DateTime) dayStart = dayStartField;

      if (dayEndField is Timestamp) dayEnd = dayEndField.toDate();
      if (dayEndField is DateTime) dayEnd = dayEndField;

      if (dayKey.isEmpty) {
        DateTime basis;

        if (dayStart != null) {
          basis = dayStart!;
        } else {
          final dynamic dateField = data['date'];
          final dynamic createdAtField = data['createdAt'];
          final dynamic lastAddedAtField = data['lastAddedAt'];

          DateTime? candidate;

          if (dateField is Timestamp) candidate = dateField.toDate();
          if (dateField is DateTime) candidate = dateField;

          candidate ??=
              (createdAtField is Timestamp) ? createdAtField.toDate() : null;
          candidate ??= (createdAtField is DateTime) ? createdAtField : null;

          candidate ??= (lastAddedAtField is Timestamp)
              ? lastAddedAtField.toDate()
              : null;
          candidate ??=
              (lastAddedAtField is DateTime) ? lastAddedAtField : null;

          basis = candidate ?? DateTime.now();
        }

        dayStart = _localDayStart(basis);
        dayEnd = dayStart!.add(const Duration(days: 1));
        dayKey = _yyyyMMdd(dayStart!);

        tx.set(
          totalsRef,
          {
            'dayKey': dayKey,
            'dayStart': dayStart,
            'dayEnd': dayEnd,
            'date': dayStart,
          },
          SetOptions(merge: true),
        );
      } else {
        dayStart ??= DateTime.now();
        dayEnd ??= dayStart!.add(const Duration(days: 1));
      }

      final dailyDocId = '${uid}_$dayKey';
      final dailyRef = dailyBaseRef.doc(dailyDocId);

      // ---- Update drinkTotals ----
      final nowMs = DateTime.now().millisecondsSinceEpoch;

      if (n >= current) {
        removedNow = true;
        nextCount = 0;

        tx.update(totalsRef, {
          'count': 0,
          'removed': true,
          'updatedAt': FieldValue.serverTimestamp(),
          'lastDrinkTimestampMs': nowMs,
          'total_ml_consumed': 0.0,
          'cost': 0.0,
          'calories': 0, // ✅ NEW
        });
      } else {
        nextCount = current - n;

        final update = <String, dynamic>{
          'count': nextCount,
          'removed': false,
          'updatedAt': FieldValue.serverTimestamp(),
          'lastDrinkTimestampMs': nowMs,
        };

        if (mlDelta != 0)
          update['total_ml_consumed'] = FieldValue.increment(-mlDelta);
        if (costDelta != 0) update['cost'] = FieldValue.increment(-costDelta);
        if (caloriesDelta != 0)
          update['calories'] = FieldValue.increment(-caloriesDelta); // ✅ NEW

        tx.update(totalsRef, update);
      }

      // ---- Decrement daily aggregate ----
      final dailyUpdate = <String, dynamic>{
        'uid': userRef, // schema: Doc Reference (users)
        if (dayStart != null) 'dayStart': dayStart,
        if (dayEnd != null) 'dayEnd': dayEnd,
        'dailyRemoved': false,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (mlDelta != 0) dailyUpdate['totalMl'] = FieldValue.increment(-mlDelta);
      if (sdDeltaInt != 0) {
        dailyUpdate['totalStandardDrinks'] = FieldValue.increment(-sdDeltaInt);
      }
      if (costDelta != 0)
        dailyUpdate['totalCost'] = FieldValue.increment(-costDelta);
      if (caloriesDelta != 0) {
        dailyUpdate['dailyCalories'] =
            FieldValue.increment(-caloriesDelta); // ✅ NEW
      }

      tx.set(dailyRef, dailyUpdate, SetOptions(merge: true));
    });

    if (nextCount == null) return null;

    // 2) Timer logic (preserved)
    if (removedNow) {
      final remaining = await totalsCol
          .where('ownerUid', isEqualTo: uid)
          .where('removed', isEqualTo: false)
          .limit(50)
          .get();

      bool hasAnyActive = false;
      for (final d in remaining.docs) {
        final c = (d.data()['count'] as num?)?.toInt() ?? 0;
        if (c > 0) {
          hasAnyActive = true;
          break;
        }
      }

      if (!hasAnyActive) {
        await userRef.set({
          'firstDrinkTimestampMs': 0,
          'lastDrinkTimestampMs': 0,
          'firstDrinkAt': null,
          'lastDrinkAt': null,
        }, SetOptions(merge: true));
      } else {
        final nowMs = DateTime.now().millisecondsSinceEpoch;
        await userRef.set({
          'firstDrinkTimestampMs': nowMs,
          'lastDrinkTimestampMs': nowMs,
          'firstDrinkAt': FieldValue.serverTimestamp(),
          'lastDrinkAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
    }

    return nextCount;
  } catch (e, st) {
    debugPrint('[decrementDrinkTotal][ERROR] $e');
    debugPrint('$st');
    return null;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
