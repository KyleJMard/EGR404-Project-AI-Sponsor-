import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/drink_days_list_copy_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'calendar_widget.dart' show CalendarWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CalendarModel extends FlutterFlowModel<CalendarWidget> {
  ///  Local state fields for this component.

  String? year;

  String? month;

  String? day;

  String dateKey = 'empy';

  List<String> drinkDateKeys = [];
  void addToDrinkDateKeys(String item) => drinkDateKeys.add(item);
  void removeFromDrinkDateKeys(String item) => drinkDateKeys.remove(item);
  void removeAtIndexFromDrinkDateKeys(int index) =>
      drinkDateKeys.removeAt(index);
  void insertAtIndexInDrinkDateKeys(int index, String item) =>
      drinkDateKeys.insert(index, item);
  void updateDrinkDateKeysAtIndex(int index, Function(String) updateFn) =>
      drinkDateKeys[index] = updateFn(drinkDateKeys[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in calendar widget.
  List<DrinkTotalsRecord>? drinkTotals;
  // Stores action output result for [Firestore Query - Query a collection] action in Container widget.
  List<DrinkTotalsRecord>? drinks;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
