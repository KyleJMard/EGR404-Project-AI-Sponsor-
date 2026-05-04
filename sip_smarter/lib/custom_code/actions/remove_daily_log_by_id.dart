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

Future<bool> removeDailyLogById(
  BuildContext context,
  String dailyLogId,
) async {
  if (dailyLogId.isEmpty) return false;

  try {
    await FirebaseFirestore.instance
        .collection('dailyLogs')
        .doc(dailyLogId)
        .update({
      'dailyRemoved': true,
      'removed_time': FieldValue.serverTimestamp(),
    });

    return true;
  } catch (e) {
    debugPrint('[removeDailyLogById][ERROR] $e');
    return false;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
