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

Future<bool> markDailyLogRemovedById(
  BuildContext context,
  String dailyLogDocId,
) async {
  if (dailyLogDocId.isEmpty) {
    debugPrint('[markDailyLogRemovedById] ERROR: empty doc id');
    return false;
  }

  try {
    final ref =
        FirebaseFirestore.instance.collection('dailyLogs').doc(dailyLogDocId);

    debugPrint('[markDailyLogRemovedById] Updating: dailyLogs/$dailyLogDocId');

    await ref.update({
      'dailyRemoved': true,
      'removed_time': FieldValue.serverTimestamp(),
      'debug_removed_marker': DateTime.now().millisecondsSinceEpoch,
    });

    debugPrint('[markDailyLogRemovedById] SUCCESS');
    return true;
  } catch (e) {
    debugPrint('[markDailyLogRemovedById] ERROR: $e');
    return false;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
