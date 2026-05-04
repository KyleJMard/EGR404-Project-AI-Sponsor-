import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/progress_bar_and_b_a_c_limit/custom_volume_input/custom_volume_input_widget.dart';
import '/progress_bar_and_b_a_c_limit/volume_progress_meter/volume_progress_meter_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'volume_limit_widget.dart' show VolumeLimitWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VolumeLimitModel extends FlutterFlowModel<VolumeLimitWidget> {
  ///  Local state fields for this page.

  String bacLabel = '0.000';

  double bac = 0.0;

  bool offButton = false;

  bool turnOff = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in VolumeLimit widget.
  List<DrinkTotalsRecord>? drinkTotals2;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered = false;
  // Model for VolumeProgressMeter component.
  late VolumeProgressMeterModel volumeProgressMeterModel;

  @override
  void initState(BuildContext context) {
    volumeProgressMeterModel =
        createModel(context, () => VolumeProgressMeterModel());
  }

  @override
  void dispose() {
    volumeProgressMeterModel.dispose();
  }
}
