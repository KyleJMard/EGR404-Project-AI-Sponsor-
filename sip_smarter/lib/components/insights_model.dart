import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'insights_widget.dart' show InsightsWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InsightsModel extends FlutterFlowModel<InsightsWidget> {
  ///  Local state fields for this component.

  String? aiSummary;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (getUserDrinkTotals)] action in Insights widget.
  ApiCallResponse? apiResult38l;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
