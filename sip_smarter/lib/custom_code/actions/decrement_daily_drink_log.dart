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

double _asDouble(dynamic v) {
  if (v == null) return 0.0;
  if (v is num) return v.toDouble();
  return 0.0;
}

int _asInt(dynamic v) {
  if (v == null) return 0;
  if (v is num) return v.toInt();
  return 0;
}

Future<bool> decrementDailyDrinkLog(
  BuildContext context,
  double mlToSubtract,
  double costToSubtract,
  int caloriesToSubtract, // ✅ NEW
) async {
  final uid = currentUserUid;
  if (uid.isEmpty) return false;

  final firestore = FirebaseFirestore.instance;

  // Defensive: never subtract negatives (treat as 0)
  final double mlSub =
      (mlToSubtract.isFinite && mlToSubtract > 0) ? mlToSubtract : 0.0;
  final double costSub =
      (costToSubtract.isFinite && costToSubtract > 0) ? costToSubtract : 0.0;
  final int calSub = (caloriesToSubtract > 0) ? caloriesToSubtract : 0;

  final now = DateTime.now();
  final dayStart = _localDayStart(now);
  final dayKey = _yyyyMMdd(dayStart);
  final dailyDocId = '${uid}_$dayKey';

  final dailyRef = firestore.collection('dailyDrinkLog').doc(dailyDocId);

  try {
    await firestore.runTransaction((tx) async {
      final snap = await tx.get(dailyRef);
      if (!snap.exists) {
        // Nothing to decrement
        return;
      }

      final data = snap.data() as Map<String, dynamic>? ?? {};
      final currentMl = _asDouble(data['totalMl']);
      final currentCost = _asDouble(data['totalCost']);
      final currentCalories = _asInt(data['dailyCalories']); // ✅ NEW

      final newMl = currentMl - mlSub;
      final newCost = currentCost - costSub;
      final newCalories = currentCalories - calSub;

      final clampedMl = newMl < 0 ? 0.0 : newMl;
      final clampedCost = newCost < 0 ? 0.0 : newCost;
      final clampedCalories = newCalories < 0 ? 0 : newCalories;

      // Mark removed if ALL totals are now zero
      final removedFlag =
          (clampedMl <= 0.0) && (clampedCost <= 0.0) && (clampedCalories <= 0);

      tx.update(dailyRef, {
        'totalMl': clampedMl,
        'totalCost': clampedCost,
        'dailyCalories': clampedCalories, // ✅ NEW
        'dailyRemoved': removedFlag,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });

    return true;
  } catch (e) {
    debugPrint('[decrementDailyDrinkLog][ERROR] $e');
    return false;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
