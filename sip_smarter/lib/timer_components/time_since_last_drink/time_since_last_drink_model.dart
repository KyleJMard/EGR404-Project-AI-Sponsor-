import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'time_since_last_drink_widget.dart' show TimeSinceLastDrinkWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class TimeSinceLastDrinkModel
    extends FlutterFlowModel<TimeSinceLastDrinkWidget> {
  ///  Local state fields for this component.

  String timerText = '00:00:00';

  int? loopCount = 86400;

  int? timeSinceLastDrinkInMs;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
