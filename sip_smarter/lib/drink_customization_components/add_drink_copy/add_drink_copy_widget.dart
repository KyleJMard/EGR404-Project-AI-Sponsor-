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
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_drink_copy_model.dart';
export 'add_drink_copy_model.dart';

class AddDrinkCopyWidget extends StatefulWidget {
  const AddDrinkCopyWidget({
    super.key,
    bool? backgroundBlur,
  }) : this.backgroundBlur = backgroundBlur ?? true;

  final bool backgroundBlur;

  @override
  State<AddDrinkCopyWidget> createState() => _AddDrinkCopyWidgetState();
}

class _AddDrinkCopyWidgetState extends State<AddDrinkCopyWidget> {
  late AddDrinkCopyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddDrinkCopyModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: 649.2,
        height: 744.4,
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
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Stack(
                alignment: AlignmentDirectional(0.0, 0.0),
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 5.0, 0.0, 0.0),
                          child: Text(
                            'Add Drinks',
                            textAlign: TextAlign.center,
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
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: FlutterFlowTheme.of(context).info,
                          size: 35.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FlutterFlowDropDown<String>(
              controller: _model.dropDownValueController1 ??=
                  FormFieldController<String>(null),
              options: [
                'Shot (1.5 fl oz)',
                'Beer (12 fl oz)',
                'Wine (5 fl oz)'
              ],
              onChanged: (val) async {
                safeSetState(() => _model.dropDownValue1 = val);
                _model.drinkSelection = _model.dropDownValue1;
                _model.showDetails = true;
                safeSetState(() {});
                if (_model.drinkSelection == 'Shot (1.5 fl oz)') {
                  _model.drinkName = 'Shot';
                  _model.drinkABV = 40.0;
                  _model.drinkVolume = 1.5;
                  _model.drinkCalories = 100;
                  _model.drinkSizeType = 'oz';
                  safeSetState(() {});
                  _model.intVolume = () {
                    if (_model.drinkSizeType == 'oz') {
                      return functions.ouncesToMl(_model.drinkVolume);
                    } else if (_model.drinkSizeType == 'Cups') {
                      return functions.cupsToMl(_model.drinkVolume);
                    } else {
                      return functions.doubleToInt(_model.drinkVolume!);
                    }
                  }();
                  safeSetState(() {});
                } else {
                  if (_model.drinkSelection == 'Beer (12 fl oz)') {
                    _model.drinkName = 'Beer';
                    _model.drinkABV = 5.0;
                    _model.drinkVolume = 12.0;
                    _model.drinkCalories = 150;
                    _model.drinkSizeType = 'oz';
                    safeSetState(() {});
                    _model.intVolume = () {
                      if (_model.drinkSizeType == 'oz') {
                        return functions.ouncesToMl(_model.drinkVolume);
                      } else if (_model.drinkSizeType == 'Cups') {
                        return functions.cupsToMl(_model.drinkVolume);
                      } else {
                        return functions.doubleToInt(_model.drinkVolume!);
                      }
                    }();
                    safeSetState(() {});
                  } else {
                    if (_model.drinkSelection == 'Wine (5 fl oz)') {
                      _model.drinkName = 'Wine';
                      _model.drinkABV = 12.0;
                      _model.drinkVolume = 5.0;
                      _model.drinkCalories = 150;
                      _model.drinkSizeType = 'oz';
                      safeSetState(() {});
                      _model.intVolume = () {
                        if (_model.drinkSizeType == 'oz') {
                          return functions.ouncesToMl(_model.drinkVolume);
                        } else if (_model.drinkSizeType == 'Cups') {
                          return functions.cupsToMl(_model.drinkVolume);
                        } else {
                          return functions.doubleToInt(_model.drinkVolume!);
                        }
                      }();
                      safeSetState(() {});
                    } else {
                      return;
                    }
                  }
                }
              },
              width: 200.0,
              height: 40.0,
              textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
              hintText: 'Select...',
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: FlutterFlowTheme.of(context).alternate,
                size: 24.0,
              ),
              fillColor: FlutterFlowTheme.of(context).accent3,
              elevation: 2.0,
              borderColor: Colors.transparent,
              borderWidth: 0.0,
              borderRadius: 8.0,
              margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
              hidesUnderline: true,
              isOverButton: false,
              isSearchable: false,
              isMultiSelect: false,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  children: [
                    if (_model.drinkSelection == 'Shot (1.5 fl oz)')
                      Container(
                        width: 125.0,
                        height: 125.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.asset(
                              Theme.of(context).brightness == Brightness.dark
                                  ? 'assets/images/ChatGPT_Image_Dec_30,_2025,_04_06_00_AM.png'
                                  : 'assets/images/ChatGPT_Image_Dec_30,_2025,_04_04_40_AM.png',
                            ).image,
                          ),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                    if (_model.drinkSelection == 'Beer (12 fl oz)')
                      Container(
                        width: 125.0,
                        height: 125.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.asset(
                              Theme.of(context).brightness == Brightness.dark
                                  ? 'assets/images/ChatGPT_Image_Dec_30,_2025,_04_00_56_AM.png'
                                  : 'assets/images/ChatGPT_Image_Dec_30,_2025,_03_58_37_AM.png',
                            ).image,
                          ),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                    if (_model.drinkSelection == 'Wine (5 fl oz)')
                      Material(
                        color: Colors.transparent,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Container(
                          width: 125.0,
                          height: 125.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.asset(
                                Theme.of(context).brightness == Brightness.dark
                                    ? 'assets/images/ChatGPT_Image_Dec_30,_2025,_04_11_04_AM.png'
                                    : 'assets/images/ChatGPT_Image_Dec_30,_2025,_04_07_31_AM.png',
                              ).image,
                            ),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            if (_model.showDetails)
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    valueOrDefault<String>(
                      () {
                        if (_model.drinkSizeType == 'Cups') {
                          return functions
                              .ouncesToCups(_model.drinkVolume!)
                              .toString();
                        } else if (_model.drinkSizeType == 'mL') {
                          return functions
                              .ouncesToMl(_model.drinkVolume)
                              .toString();
                        } else {
                          return _model.drinkVolume?.toString();
                        }
                      }(),
                      '0',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.merriweather(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).info,
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                  FlutterFlowDropDown<String>(
                    controller: _model.dropDownValueController2 ??=
                        FormFieldController<String>(
                      _model.dropDownValue2 ??= _model.drinkSizeType,
                    ),
                    options: ['oz', 'mL', 'Cups'],
                    onChanged: (val) async {
                      safeSetState(() => _model.dropDownValue2 = val);
                      _model.drinkSizeType = _model.dropDownValue2!;
                      safeSetState(() {});
                    },
                    width: 90.08,
                    height: 40.0,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).info,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: FlutterFlowTheme.of(context).alternate,
                      size: 24.0,
                    ),
                    fillColor: FlutterFlowTheme.of(context).accent3,
                    elevation: 2.0,
                    borderColor: Colors.transparent,
                    borderWidth: 0.0,
                    borderRadius: 8.0,
                    margin:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    hidesUnderline: true,
                    isOverButton: false,
                    isSearchable: false,
                    isMultiSelect: false,
                  ),
                ].divide(SizedBox(width: 5.0)),
              ),
            if (_model.showDetails)
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${valueOrDefault<String>(
                      _model.drinkABV?.toString(),
                      'ABV',
                    )}% ABV',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.merriweather(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).info,
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ],
              ),
            if (_model.showDetails)
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Approximate Calories: ${valueOrDefault<String>(
                      _model.drinkCalories?.toString(),
                      '0',
                    )}',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.merriweather(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).info,
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ],
              ),
            if (_model.showDetails)
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      if (_model.drinkCount > 1) {
                        _model.drinkCount = _model.drinkCount + -1;
                        safeSetState(() {});
                      } else {
                        return;
                      }
                    },
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).accent3,
                        shape: BoxShape.circle,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: FaIcon(
                          FontAwesomeIcons.minus,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    _model.drinkCount.toString(),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.merriweather(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).info,
                          fontSize: 20.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).accent3,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        _model.drinkCount = _model.drinkCount + 1;
                        safeSetState(() {});
                      },
                      child: Icon(
                        Icons.add,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 25.0)),
              ),
            if (_model.showDetails)
              FFButtonWidget(
                onPressed: () async {
                  await actions.addDrink(
                    context,
                    functions.toLowerCase(_model.drinkName!),
                    _model.drinkName!,
                    _model.intVolume,
                    'mL',
                    _model.drinkABV,
                    _model.drinkCount,
                    '0.00',
                    'null',
                    _model.drinkCalories,
                  );
                  _model.tmL = await actions.getTotalMl(
                    context,
                  );
                  FFAppState().totalMl = _model.tmL!;
                  _model.updatePage(() {});
                  Navigator.pop(context);

                  safeSetState(() {});
                },
                text: 'Add Drinks',
                options: FFButtonOptions(
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).accent3,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).info,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Text(
                'Customize and More',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      font: GoogleFonts.merriweather(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).accent1,
                      fontSize: 20.0,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).titleMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleMedium.fontStyle,
                    ),
              ),
            ),
            Material(
              color: Colors.transparent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: AddDrinkCustomizationWidget(),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: Image.asset(
                      Theme.of(context).brightness == Brightness.dark
                          ? 'assets/images/AIGenImageForAddDrinks.png'
                          : 'assets/images/ChatGPT_Image_Dec_24,_2025,_12_55_43_AM.png',
                      width: 155.3,
                      height: 151.8,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: DataSheetWidget(),
                    );
                  },
                ).then((value) => safeSetState(() {}));
              },
              child: Container(
                width: 250.0,
                height: 67.38,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryText,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Text(
                    'Data Sheet',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.merriweather(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          fontSize: 24.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
              ),
            ),
          ].divide(SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
