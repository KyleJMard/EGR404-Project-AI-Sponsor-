import '/auth/firebase_auth/auth_util.dart';
import '/backend/ai_agents/ai_agent.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'progress_page_copy_widget.dart' show ProgressPageCopyWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProgressPageCopyModel extends FlutterFlowModel<ProgressPageCopyWidget> {
  ///  Local state fields for this page.

  double totalMLWeek = 0.0;

  double avgMLPerDay = 0.0;

  int safeDaysCount = 0;

  int safeStreak = 0;

  DateTime? currentWeekStart;

  DateTime? currentMonthStart;

  DateTime? currentYearStart;

  String? weeklyMessage;

  bool showUSD = false;

  List<DailyDrinkLogRecord> dailyLogs = [];
  void addToDailyLogs(DailyDrinkLogRecord item) => dailyLogs.add(item);
  void removeFromDailyLogs(DailyDrinkLogRecord item) => dailyLogs.remove(item);
  void removeAtIndexFromDailyLogs(int index) => dailyLogs.removeAt(index);
  void insertAtIndexInDailyLogs(int index, DailyDrinkLogRecord item) =>
      dailyLogs.insert(index, item);
  void updateDailyLogsAtIndex(
          int index, Function(DailyDrinkLogRecord) updateFn) =>
      dailyLogs[index] = updateFn(dailyLogs[index]);

  int rowIndex = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [AI Agent - Send Message to WhatThatMuchCanFill] action in ProgressPageCopy widget.
  String? whatThatCanFill;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
