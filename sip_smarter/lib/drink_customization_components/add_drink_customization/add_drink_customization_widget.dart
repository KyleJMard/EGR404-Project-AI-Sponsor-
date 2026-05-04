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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_drink_customization_model.dart';
export 'add_drink_customization_model.dart';

class AddDrinkCustomizationWidget extends StatefulWidget {
  const AddDrinkCustomizationWidget({
    super.key,
    this.preset,
    this.defaultDrinkName,
    this.defaultDrinkSize,
    this.defaultDrinkSizeType,
    this.defaultDrinkAbv,
    double? drinkPrice,
    this.passedName,
    this.passedSize,
    this.passedSizeType,
    this.passedABV,
    this.passedPrice,
    this.passedCount,
    this.drinkTotals,
    this.passedCalories,
  }) : this.drinkPrice = drinkPrice ?? 0.00;

  final String? preset;
  final String? defaultDrinkName;
  final double? defaultDrinkSize;
  final String? defaultDrinkSizeType;
  final double? defaultDrinkAbv;
  final double drinkPrice;
  final String? passedName;
  final String? passedSize;
  final String? passedSizeType;
  final String? passedABV;
  final String? passedPrice;
  final String? passedCount;
  final DrinkTotalsRecord? drinkTotals;
  final int? passedCalories;

  @override
  State<AddDrinkCustomizationWidget> createState() =>
      _AddDrinkCustomizationWidgetState();
}

class _AddDrinkCustomizationWidgetState
    extends State<AddDrinkCustomizationWidget> {
  late AddDrinkCustomizationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddDrinkCustomizationModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        Future(() async {
          _model.initAvailablePresets = await actions.getAvailableDrinkPresets(
            context,
          );
          _model.availablePresets =
              _model.initAvailablePresets!.toList().cast<DrinkPresetsRecord>();
          _model.availablePresetNames = functions
              .getDrinkPresetListNames(_model.initAvailablePresets?.toList())
              .toList()
              .cast<String>();
          _model.drinkSize =
              double.tryParse(_model.drinkSizeTextController.text);
          safeSetState(() {});
          if (!((widget!.defaultDrinkName != null &&
                  widget!.defaultDrinkName != '') ||
              (widget!.defaultDrinkSize != null) ||
              (widget!.defaultDrinkSizeType != null &&
                  widget!.defaultDrinkSizeType != '') ||
              (widget!.defaultDrinkAbv != null))) {
            _model.activePreset = functions.getDrinkPreset(
                _model.availablePresets.toList(), widget!.preset!);
            _model.activeDrinkSizeType = _model.activePreset!.drinkSizeType;
            _model.activePresetName = _model.activePreset?.drinkName;
          }
        }),
        Future(() async {
          if (widget!.defaultDrinkSizeType != null &&
              widget!.defaultDrinkSizeType != '') {
            _model.activeDrinkSizeType = widget!.defaultDrinkSizeType!;
          }
        }),
        Future(() async {
          if ((widget!.defaultDrinkName != null &&
                  widget!.defaultDrinkName != '') &&
              _model.availablePresetNames.contains(widget!.defaultDrinkName)) {
            _model.activePresetName = widget!.defaultDrinkName;
          }
        }),
        Future(() async {
          await Future.delayed(
            Duration(
              milliseconds: 100,
            ),
          );
          _model.usedDefaultValues = true;
        }),
        Future(() async {
          if (widget!.drinkTotals != null) {
            _model.price = widget!.drinkTotals?.cost?.toString();
            _model.drinkSizeType = 'mL';
            _model.drinkName = widget!.drinkTotals?.name;
            _model.drinkABV = widget!.drinkTotals?.abv;
            _model.count = widget!.drinkTotals!.count.toDouble();
            _model.size2 = widget!.drinkTotals!.sizeMl;
            _model.drinkCalories = widget!.drinkTotals?.unitCalories;
          } else {
            return;
          }
        }),
        Future(() async {
          if (widget!.passedName != null && widget!.passedName != '') {
            _model.drinkName = widget!.passedName;
            _model.drinkSizeType = widget!.passedSizeType;
            _model.drinkABV = functions.stringToDouble(widget!.passedABV);
            _model.price = '0.00';
            _model.count = 1.0;
            _model.size2 = functions.stringToDouble(widget!.passedSize)!;
            _model.drinkCalories = widget!.passedCalories;
          }
        }),
      ]);
      safeSetState(() {});
    });

    _model.drinkNameTextController ??= TextEditingController();
    _model.drinkNameFocusNode ??= FocusNode();

    _model.drinkSizeTextController ??= TextEditingController();
    _model.drinkSizeFocusNode ??= FocusNode();

    _model.drinkABVTextController ??= TextEditingController();
    _model.drinkABVFocusNode ??= FocusNode();

    _model.drinkPriceTextController ??= TextEditingController();
    _model.drinkPriceFocusNode ??= FocusNode();

    _model.countTextController1 ??= TextEditingController();
    _model.countFocusNode1 ??= FocusNode();

    _model.countTextController2 ??= TextEditingController();
    _model.countFocusNode2 ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: 672.3,
        height: double.infinity,
        constraints: BoxConstraints(
          maxWidth: 400.0,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(24.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Color(0xFFFFB100),
            width: 3.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              40.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Edit and Save',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.merriweather(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).accent1,
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(1.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderRadius: 8.0,
                    borderWidth: 0.0,
                    buttonSize: 40.0,
                    icon: Icon(
                      Icons.arrow_back_sharp,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    showLoadingIndicator: true,
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FlutterFlowDropDown<String>(
                      controller: _model.dropDownValueController ??=
                          FormFieldController<String>(
                        _model.dropDownValue ??= _model.activePresetName,
                      ),
                      options: _model.availablePresetNames,
                      onChanged: (val) async {
                        safeSetState(() => _model.dropDownValue = val);
                        _model.activePreset = functions.getDrinkPreset(
                            _model.availablePresets.toList(),
                            _model.dropDownValue!);
                        safeSetState(() {});
                        _model.price = _model.activePreset?.price?.toString();
                        _model.drinkSizeType =
                            _model.activePreset?.drinkSizeType;
                        _model.drinkName = _model.activePreset?.drinkName;
                        _model.drinkABV = _model.activePreset?.drinkAbv;
                        _model.size2 = _model.activePreset!.drinkSize;
                        _model.drinkCalories = _model.activePreset?.calories;
                        _model.tabName = _model.activePreset!.drinkTab;
                        safeSetState(() {});
                      },
                      width: 190.0,
                      height: 40.0,
                      searchHintTextStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                font: GoogleFonts.merriweatherSans(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).accent1,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                      searchTextStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                      textStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.merriweatherSans(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).accent1,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                      hintText: 'Drink Preset...',
                      searchHintText: 'Search...',
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      elevation: 2.0,
                      borderColor: Colors.transparent,
                      borderWidth: 0.0,
                      borderRadius: 8.0,
                      margin:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                      hidesUnderline: true,
                      isOverButton: false,
                      isSearchable: true,
                      isMultiSelect: false,
                    ),
                    FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 40.0,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      icon: Icon(
                        Icons.delete,
                        color: FlutterFlowTheme.of(context).tertiary,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        if (_model.activePreset != null) {
                          if (_model.activePreset?.user ==
                              currentUserReference) {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Removing'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                            await _model.activePreset!.reference.delete();
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Updating available presets'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                            _model.trashPresetAvailableDrinks =
                                await actions.getAvailableDrinkPresets(
                              context,
                            );
                            _model.availablePresetNames = functions
                                .getDrinkPresetListNames(
                                    _model.savePresetAvailableDrinks?.toList())
                                .toList()
                                .cast<String>();
                            _model.availablePresets = _model
                                .savePresetAvailableDrinks!
                                .toList()
                                .cast<DrinkPresetsRecord>();
                            _model.activePresetName = null;
                            safeSetState(() {});
                            safeSetState(() {
                              _model.dropDownValueController?.reset();
                              _model.dropDownValue = null;
                            });
                            _model.activePreset = null;
                            safeSetState(() {});
                            safeSetState(() {
                              _model.drinkNameTextController?.clear();
                              _model.drinkSizeTextController?.clear();
                              _model.drinkABVTextController?.clear();
                            });
                            _model.activeDrinkSizeType = valueOrDefault<String>(
                              '',
                              'oz',
                            );
                            _model.price = '0.00';
                            _model.size2 = 0.0;
                            _model.drinkABV = 0.0;
                            _model.count = 1.0;
                            _model.drinkName = '\"Drink Name\"';
                            _model.drinkSizeType = 'mL';
                            safeSetState(() {});
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Cannot delete global preset'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } else {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('No preset chosen'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext),
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        }

                        safeSetState(() {});
                      },
                    ),
                  ].divide(SizedBox(width: 5.0)),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: DrinkCustomizationAIWidget(),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  },
                  text: 'Ask AI',
                  options: FFButtonOptions(
                    height: 40.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.merriweather(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).tertiary,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ].divide(SizedBox(width: 20.0)),
            ),
            Divider(
              thickness: 1.0,
              color: FlutterFlowTheme.of(context).primary,
            ),
            Form(
              key: _model.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Drink Name: ${valueOrDefault<String>(
                          _model.drinkName,
                          '\"Drink Name\"',
                        )}',
                        style: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              font: GoogleFonts.merriweather(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 300.0,
                            child: TextFormField(
                              controller: _model.drinkNameTextController,
                              focusNode: _model.drinkNameFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.drinkNameTextController',
                                Duration(milliseconds: 2000),
                                () async {
                                  _model.drinkName =
                                      _model.drinkNameTextController.text;
                                  safeSetState(() {});
                                },
                              ),
                              autofocus: false,
                              enabled: true,
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.merriweatherSans(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                hintText: 'New name...',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.merriweatherSans(
                                        fontWeight: FontWeight.w100,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .customColor6,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w100,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.merriweatherSans(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).accent1,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              maxLength: 35,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              enableInteractiveSelection: true,
                              validator: _model.drinkNameTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Drink Size: ${valueOrDefault<String>(
                          _model.size2.toString(),
                          '0.00',
                        )} ${_model.drinkSizeType}',
                        style: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              font: GoogleFonts.merriweather(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 190.0,
                            child: TextFormField(
                              controller: _model.drinkSizeTextController,
                              focusNode: _model.drinkSizeFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.drinkSizeTextController',
                                Duration(milliseconds: 2000),
                                () async {
                                  _model.size2 = double.parse(
                                      _model.drinkSizeTextController.text);
                                  safeSetState(() {});
                                  if ((_model.size2 > 10000.0) &&
                                      (_model.drinkSizeType == 'mL')) {
                                    _model.size2 = 0.0;
                                    safeSetState(() {});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Invalid Drink Size (Must be less than 10000)',
                                          style: TextStyle(
                                            color: Color(0xFFFF0000),
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor: Colors.black,
                                      ),
                                    );
                                  } else {
                                    if ((_model.size2 > 1000.0) &&
                                        (_model.drinkSizeType == 'oz')) {
                                      _model.size2 = 0.0;
                                      safeSetState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Invalid Drink Size (Must Be Less Than 1000)',
                                            style: TextStyle(
                                              color: Color(0xFFFF0000),
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor: Colors.black,
                                        ),
                                      );
                                    } else {
                                      if ((_model.size2 > 1000.0) &&
                                          (_model.drinkSizeType == 'Cups')) {
                                        _model.size2 = 0.0;
                                        safeSetState(() {});
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Invalid Drink Size  (Must Be Less Than 1000)',
                                              style: TextStyle(
                                                color: Color(0xFFFF0000),
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor: Colors.black,
                                          ),
                                        );
                                      } else {
                                        return;
                                      }
                                    }
                                  }
                                },
                              ),
                              autofocus: false,
                              enabled: true,
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.merriweatherSans(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                hintText: 'New size...',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.merriweatherSans(
                                        fontWeight: FontWeight.w100,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .customColor6,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w100,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.merriweatherSans(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).accent1,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              enableInteractiveSelection: true,
                              validator: _model.drinkSizeTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, -1.0),
                            child: FlutterFlowDropDown<String>(
                              controller:
                                  _model.drinkSizeTypeValueController ??=
                                      FormFieldController<String>(null),
                              options: ['mL', 'oz', 'Cups'],
                              onChanged: (val) async {
                                safeSetState(
                                    () => _model.drinkSizeTypeValue = val);
                                _model.drinkSizeType =
                                    _model.drinkSizeTypeValue;
                                safeSetState(() {});
                              },
                              width: 100.0,
                              height: 40.0,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).accent1,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              hintText: 'select...',
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: FlutterFlowTheme.of(context).tertiary,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: Colors.transparent,
                              borderWidth: 0.0,
                              borderRadius: 8.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 0.0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: false,
                              isMultiSelect: false,
                            ),
                          ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Drink ABV: ${_model.drinkABV?.toString()}%',
                        style: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              font: GoogleFonts.merriweather(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 300.0,
                            child: TextFormField(
                              controller: _model.drinkABVTextController,
                              focusNode: _model.drinkABVFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.drinkABVTextController',
                                Duration(milliseconds: 2000),
                                () async {
                                  _model.drinkABV = double.tryParse(
                                      _model.drinkABVTextController.text);
                                  safeSetState(() {});
                                  if (_model.drinkABV! > 200.0) {
                                    _model.drinkABV = 0.0;
                                    safeSetState(() {});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Invalid ABV',
                                          style: TextStyle(
                                            color: Color(0xFFFF0000),
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor: Colors.black,
                                      ),
                                    );
                                  } else {
                                    return;
                                  }
                                },
                              ),
                              autofocus: false,
                              enabled: true,
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.merriweatherSans(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                hintText: 'New ABV...',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.merriweatherSans(
                                        fontWeight: FontWeight.w100,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .customColor6,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w100,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.merriweatherSans(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).accent1,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              enableInteractiveSelection: true,
                              validator: _model.drinkABVTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price: \$${valueOrDefault<String>(
                          _model.price,
                          '0.00',
                        )}',
                        style: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              font: GoogleFonts.merriweather(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 300.0,
                            child: TextFormField(
                              controller: _model.drinkPriceTextController,
                              focusNode: _model.drinkPriceFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.drinkPriceTextController',
                                Duration(milliseconds: 2000),
                                () async {
                                  _model.price =
                                      _model.drinkPriceTextController.text;
                                  safeSetState(() {});
                                },
                              ),
                              autofocus: false,
                              enabled: true,
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.merriweatherSans(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                hintText: 'New price...',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.merriweatherSans(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .customColor6,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.merriweatherSans(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).accent1,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              maxLength: 5,
                              buildCounter: (context,
                                      {required currentLength,
                                      required isFocused,
                                      maxLength}) =>
                                  null,
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              enableInteractiveSelection: true,
                              validator: _model
                                  .drinkPriceTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Calories: ${valueOrDefault<String>(
                          _model.drinkCalories?.toString(),
                          '0',
                        )}',
                        style: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              font: GoogleFonts.merriweather(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 300.0,
                            child: TextFormField(
                              controller: _model.countTextController1,
                              focusNode: _model.countFocusNode1,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.countTextController1',
                                Duration(milliseconds: 2000),
                                () async {
                                  _model.count =
                                      _model.drinkCalories!.toDouble();
                                  safeSetState(() {});
                                },
                              ),
                              autofocus: false,
                              enabled: true,
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.merriweatherSans(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                hintText: 'New quantity...',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.merriweatherSans(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .customColor6,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.merriweatherSans(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).accent1,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              maxLength: 4,
                              buildCounter: (context,
                                      {required currentLength,
                                      required isFocused,
                                      maxLength}) =>
                                  null,
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              enableInteractiveSelection: true,
                              validator: _model.countTextController1Validator
                                  .asValidator(context),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]'))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quantity: ${functions.doubleToInt(_model.count).toString()}',
                        style: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              font: GoogleFonts.merriweather(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 300.0,
                            child: TextFormField(
                              controller: _model.countTextController2,
                              focusNode: _model.countFocusNode2,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.countTextController2',
                                Duration(milliseconds: 2000),
                                () async {
                                  _model.count = double.parse(
                                      _model.countTextController2.text);
                                  safeSetState(() {});
                                },
                              ),
                              autofocus: false,
                              enabled: true,
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.merriweatherSans(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                hintText: 'New quantity...',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.merriweatherSans(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .customColor6,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.merriweatherSans(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).accent1,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              maxLength: 4,
                              buildCounter: (context,
                                      {required currentLength,
                                      required isFocused,
                                      maxLength}) =>
                                  null,
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              enableInteractiveSelection: true,
                              validator: _model.countTextController2Validator
                                  .asValidator(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Slider(
                    activeColor: FlutterFlowTheme.of(context).primary,
                    inactiveColor: FlutterFlowTheme.of(context).alternate,
                    min: 0.0,
                    max: 30.0,
                    value: _model.sliderValue ??= 1.0,
                    divisions: 30,
                    onChanged: (newValue) async {
                      newValue = double.parse(newValue.toStringAsFixed(0));
                      safeSetState(() => _model.sliderValue = newValue);
                      _model.count = _model.sliderValue!;
                      safeSetState(() {});
                    },
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Tab',
                        style: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              font: GoogleFonts.merriweather(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          StreamBuilder<List<DrinkTabsRecord>>(
                            stream: queryDrinkTabsRecord(
                              queryBuilder: (drinkTabsRecord) => drinkTabsRecord
                                  .where(
                                    'ownerUid',
                                    isEqualTo: currentUserReference?.id,
                                  )
                                  .where(
                                    'archived',
                                    isEqualTo: false,
                                  )
                                  .orderBy('createdAt'),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: SpinKitFadingCube(
                                      color: Color(0xFFFBC02D),
                                      size: 50.0,
                                    ),
                                  ),
                                );
                              }
                              List<DrinkTabsRecord> tabListDrinkTabsRecordList =
                                  snapshot.data!;

                              return FlutterFlowDropDown<String>(
                                controller: _model.tabListValueController ??=
                                    FormFieldController<String>(null),
                                options: tabListDrinkTabsRecordList
                                    .map((e) => e.name)
                                    .toList(),
                                onChanged: (val) async {
                                  safeSetState(() => _model.tabListValue = val);
                                  _model.tabName = _model.tabListValue!;
                                  safeSetState(() {});
                                },
                                width: 200.0,
                                height: 40.0,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                hintText: 'Select...',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                elevation: 2.0,
                                borderColor: Colors.transparent,
                                borderWidth: 0.0,
                                borderRadius: 8.0,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 12.0, 0.0),
                                hidesUnderline: true,
                                isOverButton: false,
                                isSearchable: false,
                                isMultiSelect: false,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          if (_model.formKey.currentState == null ||
                              !_model.formKey.currentState!.validate()) {
                            return;
                          }
                          if (functions.doesPresetExist(
                              _model.availablePresets.toList(),
                              _model.drinkNameTextController.text)) {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text(
                                      'Preset already exists with that name'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            await DrinkPresetsRecord.collection
                                .doc()
                                .set(createDrinkPresetsRecordData(
                                  drinkName: _model.drinkName,
                                  drinkSize: _model.size2,
                                  drinkAbv: _model.drinkABV,
                                  user: currentUserReference,
                                  drinkSizeType: _model.drinkSizeType,
                                  price: valueOrDefault<double>(
                                    functions.stringToDouble(
                                        _model.drinkPriceTextController.text),
                                    0.00,
                                  ),
                                  count: functions.doubleToInt(_model.count),
                                  calories: _model.drinkCalories,
                                  drinkTab: _model.tabName,
                                ));
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Preset Saved'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                            _model.savePresetAvailableDrinks =
                                await actions.getAvailableDrinkPresets(
                              context,
                            );
                            _model.availablePresetNames = functions
                                .getDrinkPresetListNames(
                                    _model.savePresetAvailableDrinks?.toList())
                                .toList()
                                .cast<String>();
                            _model.availablePresets = _model
                                .savePresetAvailableDrinks!
                                .toList()
                                .cast<DrinkPresetsRecord>();
                            _model.activePresetName =
                                _model.drinkNameTextController.text;
                            safeSetState(() {});
                            safeSetState(() {
                              _model.dropDownValueController?.reset();
                              _model.dropDownValue = null;
                            });
                          }

                          safeSetState(() {});
                        },
                        text: 'Save Preset',
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                font: GoogleFonts.merriweather(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).tertiary,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          if (_model.formKey.currentState == null ||
                              !_model.formKey.currentState!.validate()) {
                            return;
                          }
                          await actions.addDrink(
                            context,
                            functions.toLowerCase(_model.drinkName!),
                            _model.drinkName!,
                            () {
                              if (_model.drinkSizeType == 'Cups') {
                                return functions.cupsToMl(_model.size2);
                              } else if (_model.drinkSizeType == 'oz') {
                                return functions.ouncesToMl(_model.size2);
                              } else {
                                return functions.toInt(_model.size2);
                              }
                            }(),
                            'mL',
                            _model.drinkABV,
                            functions.doubleToInt(_model.count),
                            _model.price,
                            _model.tabName,
                            _model.drinkCalories,
                          );
                          _model.totalMlOther = await actions.getTotalMl(
                            context,
                          );
                          FFAppState().totalMl = _model.totalMlOther!;
                          _model.updatePage(() {});
                          Navigator.pop(context);

                          safeSetState(() {});
                        },
                        text: 'Add Drink',
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                font: GoogleFonts.merriweather(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).tertiary,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ].divide(SizedBox(width: 0.0)),
                  ),
                ].divide(SizedBox(height: 5.0)),
              ),
            ),
          ].divide(SizedBox(height: 10.0)).addToEnd(SizedBox(height: 20.0)),
        ),
      ),
    );
  }
}
