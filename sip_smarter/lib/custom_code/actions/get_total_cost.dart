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

Future<double?> getTotalCost(BuildContext context) async {
  final uid = currentUserUid;
  if (uid.isEmpty) return null;

  final col = FirebaseFirestore.instance.collection('drinkTotals');

  final cutoffMs =
      DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch;

  double totalCost = 0.0;

  try {
    final snap = await col
        .where('ownerUid', isEqualTo: uid)
        .where('removed', isEqualTo: false)
        .where('lastDrinkTimestampMs', isGreaterThanOrEqualTo: cutoffMs)
        .get();

    for (final d in snap.docs) {
      final data = d.data() as Map<String, dynamic>;

      final count = (data['count'] as num?)?.toDouble() ?? 0.0;
      final cost = (data['cost'] as num?)?.toDouble() ?? 0.0;

      totalCost += count * cost;
    }

    return totalCost;
  } on FirebaseException catch (e) {
    if (e.code == 'failed-precondition' ||
        e.message?.contains('index') == true) {
      // fallback
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

          final count = (data['count'] as num?)?.toDouble() ?? 0.0;
          final cost = (data['cost'] as num?)?.toDouble() ?? 0.0;

          totalCost += count * cost;
        }

        last = snap.docs.last;
        if (snap.docs.length < pageSize) break;
      }

      return totalCost;
    }

    return null;
  } catch (_) {
    return null;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
