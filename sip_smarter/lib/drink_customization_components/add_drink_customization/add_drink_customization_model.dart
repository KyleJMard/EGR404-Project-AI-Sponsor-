import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/drink_customization_components/drink_customization_a_i/drink_customization_a_i_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'add_drink_customization_widget.dart' show AddDrinkCustomizationWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddDrinkCustomizationModel
    extends FlutterFlowModel<AddDrinkCustomizationWidget> {
  ///  Local state fields for this component.

  DrinkPresetsRecord? activePreset;

  List<DrinkPresetsRecord> availablePresets = [];
  void addToAvailablePresets(DrinkPresetsRecord item) =>
      availablePresets.add(item);
  void removeFromAvailablePresets(DrinkPresetsRecord item) =>
      availablePresets.remove(item);
  void removeAtIndexFromAvailablePresets(int index) =>
      availablePresets.removeAt(index);
  void insertAtIndexInAvailablePresets(int index, DrinkPresetsRecord item) =>
      availablePresets.insert(index, item);
  void updateAvailablePresetsAtIndex(
          int index, Function(DrinkPresetsRecord) updateFn) =>
      availablePresets[index] = updateFn(availablePresets[index]);

  String activeDrinkSizeType = 'oz';

  bool usedDefaultValues = false;

  List<String> availablePresetNames = [];
  void addToAvailablePresetNames(String item) => availablePresetNames.add(item);
  void removeFromAvailablePresetNames(String item) =>
      availablePresetNames.remove(item);
  void removeAtIndexFromAvailablePresetNames(int index) =>
      availablePresetNames.removeAt(index);
  void insertAtIndexInAvailablePresetNames(int index, String item) =>
      availablePresetNames.insert(index, item);
  void updateAvailablePresetNamesAtIndex(
          int index, Function(String) updateFn) =>
      availablePresetNames[index] = updateFn(availablePresetNames[index]);

  String? activePresetName;

  DocumentReference? activePresetReference;

  double? drinkSize;

  String? price;

  String? drinkSizeType = 'mL';

  String? drinkName = '\"Drink Name\"';

  double? drinkABV = 0.0;

  double count = 1.0;

  double size2 = 0.0;

  String tabName = 'Tab1';

  int? drinkCalories;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Custom Action - getAvailableDrinkPresets] action in addDrinkCustomization widget.
  List<DrinkPresetsRecord>? initAvailablePresets;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Custom Action - getAvailableDrinkPresets] action in IconButton widget.
  List<DrinkPresetsRecord>? trashPresetAvailableDrinks;
  // State field(s) for DrinkName widget.
  FocusNode? drinkNameFocusNode;
  TextEditingController? drinkNameTextController;
  String? Function(BuildContext, String?)? drinkNameTextControllerValidator;
  // State field(s) for DrinkSize widget.
  FocusNode? drinkSizeFocusNode;
  TextEditingController? drinkSizeTextController;
  String? Function(BuildContext, String?)? drinkSizeTextControllerValidator;
  // State field(s) for DrinkSizeType widget.
  String? drinkSizeTypeValue;
  FormFieldController<String>? drinkSizeTypeValueController;
  // State field(s) for DrinkABV widget.
  FocusNode? drinkABVFocusNode;
  TextEditingController? drinkABVTextController;
  String? Function(BuildContext, String?)? drinkABVTextControllerValidator;
  // State field(s) for DrinkPrice widget.
  FocusNode? drinkPriceFocusNode;
  TextEditingController? drinkPriceTextController;
  String? Function(BuildContext, String?)? drinkPriceTextControllerValidator;
  // State field(s) for Count widget.
  FocusNode? countFocusNode1;
  TextEditingController? countTextController1;
  String? Function(BuildContext, String?)? countTextController1Validator;
  // State field(s) for Count widget.
  FocusNode? countFocusNode2;
  TextEditingController? countTextController2;
  String? Function(BuildContext, String?)? countTextController2Validator;
  // State field(s) for Slider widget.
  double? sliderValue;
  // State field(s) for TabList widget.
  String? tabListValue;
  FormFieldController<String>? tabListValueController;
  // Stores action output result for [Custom Action - getAvailableDrinkPresets] action in Button widget.
  List<DrinkPresetsRecord>? savePresetAvailableDrinks;
  // Stores action output result for [Custom Action - getTotalMl] action in Button widget.
  double? totalMlOther;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    drinkNameFocusNode?.dispose();
    drinkNameTextController?.dispose();

    drinkSizeFocusNode?.dispose();
    drinkSizeTextController?.dispose();

    drinkABVFocusNode?.dispose();
    drinkABVTextController?.dispose();

    drinkPriceFocusNode?.dispose();
    drinkPriceTextController?.dispose();

    countFocusNode1?.dispose();
    countTextController1?.dispose();

    countFocusNode2?.dispose();
    countTextController2?.dispose();
  }
}
