import '/backend/backend.dart';
import '/drink_customization_components/edit_drink/edit_drink_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'drink_widget.dart' show DrinkWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DrinkModel extends FlutterFlowModel<DrinkWidget> {
  ///  Local state fields for this component.

  DailyDrinkLogRecord? drinkLogs;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
