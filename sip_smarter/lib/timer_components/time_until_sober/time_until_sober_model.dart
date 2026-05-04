import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'time_until_sober_widget.dart' show TimeUntilSoberWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class TimeUntilSoberModel extends FlutterFlowModel<TimeUntilSoberWidget> {
  ///  Local state fields for this component.

  double? totalAlcGrams;

  int? elapsedTime;

  double? currentBAC;

  int? loopCount = 86400;

  String timerSoberText = '00:00:00';

  int? weight;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getTotalAlcoholGrams] action in timeUntilSober widget.
  double? totalGrams1;
  // Stores action output result for [Custom Action - getTotalAlcoholGrams] action in timeUntilSober widget.
  double? totalGrams2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
