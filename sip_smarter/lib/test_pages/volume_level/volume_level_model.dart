import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/progress_bar_and_b_a_c_limit/custom_volume_input/custom_volume_input_widget.dart';
import '/progress_bar_and_b_a_c_limit/volume_progress_meter/volume_progress_meter_widget.dart';
import 'dart:ui';
import 'volume_level_widget.dart' show VolumeLevelWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VolumeLevelModel extends FlutterFlowModel<VolumeLevelWidget> {
  ///  State fields for stateful widgets in this page.

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
