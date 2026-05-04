import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'delete_drinks_widget.dart' show DeleteDrinksWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DeleteDrinksModel extends FlutterFlowModel<DeleteDrinksWidget> {
  ///  Local state fields for this component.

  double? count;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Slider widget.
  double? sliderValue;
  // Stores action output result for [Custom Action - getTotalAlcoholGrams] action in Button widget.
  double? totGramsUndone;
  // Stores action output result for [Custom Action - getTotalMl] action in Button widget.
  double? totalMlUndo;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
