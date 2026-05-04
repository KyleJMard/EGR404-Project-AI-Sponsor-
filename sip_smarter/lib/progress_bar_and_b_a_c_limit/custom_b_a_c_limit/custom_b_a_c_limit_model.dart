import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'custom_b_a_c_limit_widget.dart' show CustomBACLimitWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomBACLimitModel extends FlutterFlowModel<CustomBACLimitWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for BACLimit widget.
  FocusNode? bACLimitFocusNode;
  TextEditingController? bACLimitTextController;
  String? Function(BuildContext, String?)? bACLimitTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    bACLimitFocusNode?.dispose();
    bACLimitTextController?.dispose();
  }
}
