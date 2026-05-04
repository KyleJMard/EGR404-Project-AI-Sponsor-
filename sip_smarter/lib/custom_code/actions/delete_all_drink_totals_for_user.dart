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

Future<int> deleteAllDrinkTotalsForUser(BuildContext context) async {
  final uid = currentUserUid;
  if (uid.isEmpty) {
    debugPrint('[deleteAllDrinkTotalsForUser] No user');
    return 0;
  }

  final firestore = FirebaseFirestore.instance;

  final totalsCol = firestore.collection('drinkTotals');
  final dailyCol = firestore.collection('dailyDrinkLog');
  final monthlyCol = firestore.collection('monthlyDrinkLog');
  final yearlyCol = firestore.collection('yearlyDrinkLog');

  // IMPORTANT: your dailyDrinkLog uses uid as a DocumentReference
  final userRef = firestore.collection('users').doc(uid);

  int deletedCount = 0;

  try {
    // Firestore batch limit is 500 writes; keep headroom
    const int batchSize = 400;

    // =====================================================
    // 1) DELETE drinkTotals (counts toward return value)
    // =====================================================
    while (true) {
      final snap = await totalsCol
          .where('ownerUid', isEqualTo: uid)
          .limit(batchSize)
          .get();

      if (snap.docs.isEmpty) break;

      final batch = firestore.batch();
      for (final doc in snap.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      deletedCount += snap.docs.length;
    }

    // =====================================================
    // 2) DELETE dailyDrinkLog
    // =====================================================
    while (true) {
      final snap = await dailyCol
          .where('uid', isEqualTo: userRef)
          .limit(batchSize)
          .get();

      if (snap.docs.isEmpty) break;

      final batch = firestore.batch();
      for (final doc in snap.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }

    // =====================================================
    // 3) DELETE monthlyDrinkLog (uid is String per your schema)
    // =====================================================
    while (true) {
      final snap =
          await monthlyCol.where('uid', isEqualTo: uid).limit(batchSize).get();

      if (snap.docs.isEmpty) break;

      final batch = firestore.batch();
      for (final doc in snap.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }

    // =====================================================
    // 4) DELETE yearlyDrinkLog (uid is String per your schema)
    // =====================================================
    while (true) {
      final snap =
          await yearlyCol.where('uid', isEqualTo: uid).limit(batchSize).get();

      if (snap.docs.isEmpty) break;

      final batch = firestore.batch();
      for (final doc in snap.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }

    debugPrint(
        '[deleteAllDrinkTotalsForUser] Deleted $deletedCount drinkTotals docs (daily/monthly/yearly logs also cleared)');
    return deletedCount;
  } catch (e, st) {
    debugPrint('[deleteAllDrinkTotalsForUser][ERROR] $e');
    debugPrint('$st');
    return deletedCount;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
