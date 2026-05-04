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

// Additional Imports (set these in FF → Custom Action → Additional Imports)
//

import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

Future<double?> getTotalMl(BuildContext context) async {
  final uid = currentUserUid;
  if (uid.isEmpty) {
    debugPrint('[getTotalMl] No user signed in');
    return null;
  }

  final col = FirebaseFirestore.instance.collection('drinkTotals');

  // Include only drinks added within the last 14 hours
  final cutoffMs =
      DateTime.now().subtract(const Duration(hours: 24)).millisecondsSinceEpoch;

  double totalMl = 0.0;

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
      final count = (data['count'] as num?)?.toDouble() ?? 0.0;
      final sizeMl = (data['size_ml'] as num?)?.toDouble() ?? 0.0;
      totalMl += count * sizeMl;
    }

    debugPrint('[getTotalMl] Total (last 14h) = $totalMl mL');
    return totalMl;
  } on FirebaseException catch (e, st) {
    // -----------------------------
    // Fallback (works without index)
    // -----------------------------
    debugPrint('[getTotalMl] FirebaseException: ${e.code} ${e.message}');
    debugPrint('$st');

    // If the only problem is missing index / precondition, fallback locally.
    // (This is slower if you have many docs, but it will work immediately.)
    if (e.code == 'failed-precondition' ||
        e.message?.contains('index') == true) {
      totalMl = 0.0;

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
          if (lastMs < cutoffMs) continue; // only last 14 hours

          final count = (data['count'] as num?)?.toDouble() ?? 0.0;
          final sizeMl = (data['size_ml'] as num?)?.toDouble() ?? 0.0;
          totalMl += count * sizeMl;
        }

        last = snap.docs.last;
        if (snap.docs.length < pageSize) break;
      }

      debugPrint('[getTotalMl] Total (last 14h, fallback) = $totalMl mL');
      return totalMl;
    }

    // Other FirebaseException: treat as failure
    return null;
  } catch (e, st) {
    debugPrint('[getTotalMl][ERROR] $e');
    debugPrint('$st');
    return null;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
