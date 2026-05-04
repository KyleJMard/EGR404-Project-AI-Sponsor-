import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'custom_volume_input_widget.dart' show CustomVolumeInputWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomVolumeInputModel extends FlutterFlowModel<CustomVolumeInputWidget> {
  ///  Local state fields for this component.

  double? mL;

  double? ounces;

  double? cups;

  ///  State fields for stateful widgets in this component.

  // State field(s) for VolumeLimit widget.
  FocusNode? volumeLimitFocusNode;
  TextEditingController? volumeLimitTextController;
  String? Function(BuildContext, String?)? volumeLimitTextControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    volumeLimitFocusNode?.dispose();
    volumeLimitTextController?.dispose();
  }
}
