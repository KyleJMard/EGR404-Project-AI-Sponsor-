import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/progress_bar_and_b_a_c_limit/custom_b_a_c_limit/custom_b_a_c_limit_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'bac_monitor_widget.dart' show BacMonitorWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BacMonitorModel extends FlutterFlowModel<BacMonitorWidget> {
  ///  Local state fields for this component.

  String bacLabel = '0.000';

  double? bac = 0.0;

  bool vis = true;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - getTotalAlcoholGrams] action in bacMonitor widget.
  double? totalGrams6;
  // Stores action output result for [Custom Action - getTotalAlcoholGrams] action in bacMonitor widget.
  double? totalGrams7;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
