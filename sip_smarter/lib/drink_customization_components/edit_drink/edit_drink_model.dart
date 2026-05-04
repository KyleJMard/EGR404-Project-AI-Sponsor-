import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/drink_customization_components/delete_drinks/delete_drinks_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'edit_drink_widget.dart' show EditDrinkWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditDrinkModel extends FlutterFlowModel<EditDrinkWidget> {
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

  String? count;

  List<String> drinkTabs = [];
  void addToDrinkTabs(String item) => drinkTabs.add(item);
  void removeFromDrinkTabs(String item) => drinkTabs.remove(item);
  void removeAtIndexFromDrinkTabs(int index) => drinkTabs.removeAt(index);
  void insertAtIndexInDrinkTabs(int index, String item) =>
      drinkTabs.insert(index, item);
  void updateDrinkTabsAtIndex(int index, Function(String) updateFn) =>
      drinkTabs[index] = updateFn(drinkTabs[index]);

  String tabNameInitial = 'Unknown';

  double? drinkSize;

  int intCount = 0;

  String drinkSizeUnit = 'mL';

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for DrinkName widget.
  FocusNode? drinkNameFocusNode;
  TextEditingController? drinkNameTextController;
  String? Function(BuildContext, String?)? drinkNameTextControllerValidator;
  String? _drinkNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Drink Name is required';
    }

    if (val.length < 1) {
      return 'Requires at least 1 characters.';
    }
    if (val.length > 20) {
      return 'Maximum 20 characters allowed, currently ${val.length}.';
    }

    return null;
  }

  // State field(s) for DrinkSize widget.
  FocusNode? drinkSizeFocusNode;
  TextEditingController? drinkSizeTextController;
  String? Function(BuildContext, String?)? drinkSizeTextControllerValidator;
  String? _drinkSizeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Drink Size is required';
    }

    return null;
  }

  // State field(s) for DrinkSizeType widget.
  String? drinkSizeTypeValue;
  FormFieldController<String>? drinkSizeTypeValueController;
  // State field(s) for DrinkABV widget.
  FocusNode? drinkABVFocusNode;
  TextEditingController? drinkABVTextController;
  String? Function(BuildContext, String?)? drinkABVTextControllerValidator;
  String? _drinkABVTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Drink ABV is required';
    }

    return null;
  }

  // State field(s) for DrinkCount widget.
  FocusNode? drinkCountFocusNode1;
  TextEditingController? drinkCountTextController1;
  String? Function(BuildContext, String?)? drinkCountTextController1Validator;
  // State field(s) for DrinkCount widget.
  FocusNode? drinkCountFocusNode2;
  TextEditingController? drinkCountTextController2;
  String? Function(BuildContext, String?)? drinkCountTextController2Validator;
  // State field(s) for DrinkCount widget.
  FocusNode? drinkCountFocusNode3;
  TextEditingController? drinkCountTextController3;
  String? Function(BuildContext, String?)? drinkCountTextController3Validator;
  // State field(s) for personTabs widget.
  String? personTabsValue;
  FormFieldController<String>? personTabsValueController;
  // Stores action output result for [Custom Action - getTotalMlToday] action in Button widget.
  double? mlToday;
  // Stores action output result for [Custom Action - getTotalMl] action in Button widget.
  double? totalMlOther;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<DrinkPresetsRecord>? drinkPresets;

  @override
  void initState(BuildContext context) {
    drinkNameTextControllerValidator = _drinkNameTextControllerValidator;
    drinkSizeTextControllerValidator = _drinkSizeTextControllerValidator;
    drinkABVTextControllerValidator = _drinkABVTextControllerValidator;
  }

  @override
  void dispose() {
    drinkNameFocusNode?.dispose();
    drinkNameTextController?.dispose();

    drinkSizeFocusNode?.dispose();
    drinkSizeTextController?.dispose();

    drinkABVFocusNode?.dispose();
    drinkABVTextController?.dispose();

    drinkCountFocusNode1?.dispose();
    drinkCountTextController1?.dispose();

    drinkCountFocusNode2?.dispose();
    drinkCountTextController2?.dispose();

    drinkCountFocusNode3?.dispose();
    drinkCountTextController3?.dispose();
  }
}
