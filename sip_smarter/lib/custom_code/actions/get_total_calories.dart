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

Future<int?> getTotalCalories(BuildContext context) async {
  final uid = currentUserUid;
  if (uid.isEmpty) {
    debugPrint('[getTotalCalories] No user signed in');
    return null;
  }

  final col = FirebaseFirestore.instance.collection('drinkTotals');

  // Include only drinks added within the last 24 hours
  final cutoffMs =
      DateTime.now().subtract(const Duration(hours: 24)).millisecondsSinceEpoch;

  int totalCalories = 0;

  try {
    // -----------------------------
    // Preferred (fast) query
    // -----------------------------
    final snap = await col
        .where('ownerUid', isEqualTo: uid)
        .where('removed', isEqualTo: false)
        .where('lastDrinkTimestampMs', isGreaterThanOrEqualTo: cutoffMs)
        .orderBy('lastDrinkTimestampMs', descending: true)
        .get();

    for (final d in snap.docs) {
      final data = d.data() as Map<String, dynamic>;

      final calories = (data['calories'] as num?)?.toInt() ?? 0;

      totalCalories += calories;
    }

    debugPrint('[getTotalCalories] Total (last 24h) = $totalCalories cal');
    return totalCalories;
  } on FirebaseException catch (e, st) {
    // -----------------------------
    // Fallback (works without index)
    // -----------------------------
    debugPrint('[getTotalCalories] FirebaseException: ${e.code} ${e.message}');
    debugPrint('$st');

    if (e.code == 'failed-precondition' ||
        e.message?.contains('index') == true) {
      totalCalories = 0;

      const pageSize = 500;
      DocumentSnapshot<Map<String, dynamic>>? last;

      while (true) {
        Query<Map<String, dynamic>> q = col
            .where('ownerUid', isEqualTo: uid)
            .where('removed', isEqualTo: false)
            .limit(pageSize);

        if (last != null) q = q.startAfterDocument(last);

        final snap = await q.get();
        if (snap.docs.isEmpty) break;

        for (final d in snap.docs) {
          final data = d.data();

          final lastMs = (data['lastDrinkTimestampMs'] as num?)?.toInt() ?? 0;
          if (lastMs < cutoffMs) continue;

          final calories = (data['calories'] as num?)?.toInt() ?? 0;

          totalCalories += calories;
        }

        last = snap.docs.last;
        if (snap.docs.length < pageSize) break;
      }

      debugPrint(
          '[getTotalCalories] Total (last 24h, fallback) = $totalCalories cal');
      return totalCalories;
    }

    return null;
  } catch (e, st) {
    debugPrint('[getTotalCalories][ERROR] $e');
    debugPrint('$st');
    return null;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
