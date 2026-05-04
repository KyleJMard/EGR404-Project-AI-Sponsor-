import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/timer_components/time_since_last_drink/time_since_last_drink_widget.dart';
import '/timer_components/time_until_sober/time_until_sober_widget.dart';
import 'dart:ui';
import 'timers_widget.dart' show TimersWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TimersModel extends FlutterFlowModel<TimersWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for TimeSinceLastDrink component.
  late TimeSinceLastDrinkModel timeSinceLastDrinkModel;
  // Model for timeUntilSober component.
  late TimeUntilSoberModel timeUntilSoberModel;

  @override
  void initState(BuildContext context) {
    timeSinceLastDrinkModel =
        createModel(context, () => TimeSinceLastDrinkModel());
    timeUntilSoberModel = createModel(context, () => TimeUntilSoberModel());
  }

  @override
  void dispose() {
    timeSinceLastDrinkModel.dispose();
    timeUntilSoberModel.dispose();
  }
}
