import '/drink_customization_components/add_drink_customization/add_drink_customization_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/miscellaneous_components/data_sheet/data_sheet_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'add_drink_copy_widget.dart' show AddDrinkCopyWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddDrinkCopyModel extends FlutterFlowModel<AddDrinkCopyWidget> {
  ///  Local state fields for this component.

  int countShot = 1;

  int? countBeer;

  int? countWine;

  String? drinkSelection;

  String? drinkName;

  double? drinkABV;

  double? drinkVolume;

  int drinkCount = 1;

  String drinkSizeType = 'oz';

  int? drinkCalories;

  int? intVolume;

  bool showDetails = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // Stores action output result for [Custom Action - getTotalMl] action in Button widget.
  double? tmL;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
