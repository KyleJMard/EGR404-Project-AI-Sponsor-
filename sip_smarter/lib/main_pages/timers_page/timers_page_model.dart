import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/timer_components/time_since_last_drink/time_since_last_drink_widget.dart';
import 'timers_page_widget.dart' show TimersPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TimersPageModel extends FlutterFlowModel<TimersPageWidget> {
  ///  Local state fields for this page.

  String? timeSinceLastDrinkText = '';

  int loopCount = 666;

  int? timeSinceLastDrinkInMs;

  double? totalAlcGrams;

  int? elapsedTime;

  double? currentBAC;

  String? timeSoberText;

  int? weight;

  ///  State fields for stateful widgets in this page.

  // Model for TimeSinceLastDrink component.
  late TimeSinceLastDrinkModel timeSinceLastDrinkModel;

  @override
  void initState(BuildContext context) {
    timeSinceLastDrinkModel =
        createModel(context, () => TimeSinceLastDrinkModel());
  }

  @override
  void dispose() {
    timeSinceLastDrinkModel.dispose();
  }
}
