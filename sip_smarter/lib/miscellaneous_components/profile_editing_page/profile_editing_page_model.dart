import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/drink_customization_components/deletion_confirmation/deletion_confirmation_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/miscellaneous_components/account_deletion/account_deletion_widget.dart';
import 'dart:ui';
import '/flutter_flow/revenue_cat_util.dart' as revenue_cat;
import '/index.dart';
import 'profile_editing_page_widget.dart' show ProfileEditingPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileEditingPageModel
    extends FlutterFlowModel<ProfileEditingPageWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for weightField widget.
  FocusNode? weightFieldFocusNode;
  TextEditingController? weightFieldTextController;
  String? Function(BuildContext, String?)? weightFieldTextControllerValidator;
  // State field(s) for WeightDropDown widget.
  String? weightDropDownValue;
  FormFieldController<String>? weightDropDownValueController;
  // Stores action output result for [RevenueCat - Purchase] action in Button widget.
  bool? premium1;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    weightFieldFocusNode?.dispose();
    weightFieldTextController?.dispose();
  }
}
