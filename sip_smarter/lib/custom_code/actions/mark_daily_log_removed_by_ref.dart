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

Future<bool> markDailyLogRemovedByRef(
  BuildContext context,
  DocumentReference dailyLogRef,
) async {
  try {
    debugPrint('[markDailyLogRemovedByRef] Updating: ${dailyLogRef.path}');
    await dailyLogRef.update({
      'dailyRemoved': true,
      'removed_time': FieldValue.serverTimestamp(),
      // debug marker so you can search in Firestore:
      'debug_removed_marker': DateTime.now().millisecondsSinceEpoch,
    });
    debugPrint('[markDailyLogRemovedByRef] SUCCESS');
    return true;
  } catch (e) {
    debugPrint('[markDailyLogRemovedByRef] ERROR: $e');
    return false;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
