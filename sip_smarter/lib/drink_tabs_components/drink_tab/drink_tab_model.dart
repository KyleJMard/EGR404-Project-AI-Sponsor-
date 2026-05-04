import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/drink_customization_components/drink/drink_widget.dart';
import '/drink_tabs_components/close_tab_confirmation/close_tab_confirmation_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'drink_tab_widget.dart' show DrinkTabWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DrinkTabModel extends FlutterFlowModel<DrinkTabWidget> {
  ///  Local state fields for this component.

  bool tabVisible = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
