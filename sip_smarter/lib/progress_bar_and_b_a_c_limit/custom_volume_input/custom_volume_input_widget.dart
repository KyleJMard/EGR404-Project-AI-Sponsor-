import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'custom_volume_input_model.dart';
export 'custom_volume_input_model.dart';

class CustomVolumeInputWidget extends StatefulWidget {
  const CustomVolumeInputWidget({super.key});

  @override
  State<CustomVolumeInputWidget> createState() =>
      _CustomVolumeInputWidgetState();
}

class _CustomVolumeInputWidgetState extends State<CustomVolumeInputWidget> {
  late CustomVolumeInputModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomVolumeInputModel());

    _model.volumeLimitTextController ??= TextEditingController();
    _model.volumeLimitFocusNode ??= FocusNode();

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
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Material(
              color: Colors.transparent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                width: 332.4,
                height: 149.64,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      color: Color(0x33000000),
                      offset: Offset(
                        0.0,
                        2.0,
                      ),
                      spreadRadius: 2.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(12.0),
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 200.0,
                          child: TextFormField(
                            controller: _model.volumeLimitTextController,
                            focusNode: _model.volumeLimitFocusNode,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.volumeLimitTextController',
                              Duration(milliseconds: 2000),
                              () async {
                                if (_model.dropDownValue == 'mL') {
                                  await currentUserReference!
                                      .update(createUsersRecordData(
                                    volumeLimit:
                                        _model.volumeLimitTextController.text,
                                  ));
                                  safeSetState(() {});
                                } else if (_model.dropDownValue == 'ounces') {
                                  await currentUserReference!
                                      .update(createUsersRecordData(
                                    volumeLimit: functions
                                        .ouncesToMl(double.tryParse(_model
                                            .volumeLimitTextController.text))
                                        .toString(),
                                  ));
                                  safeSetState(() {});
                                } else if (_model.dropDownValue == 'cups') {
                                  await currentUserReference!
                                      .update(createUsersRecordData(
                                    volumeLimit: functions
                                        .cupsToMl(double.tryParse(_model
                                            .volumeLimitTextController.text))
                                        .toString(),
                                  ));
                                  safeSetState(() {});
                                } else {
                                  return;
                                }
                              },
                            ),
                            autofocus: false,
                            enabled: true,
                            textInputAction: TextInputAction.next,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: 'Limit',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                              alignLabelWithHint: true,
                              hintText: '0.0',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).info,
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
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
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
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).info,
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            maxLength: 4,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            cursorColor:
                                FlutterFlowTheme.of(context).primaryText,
                            enableInteractiveSelection: true,
                            validator: _model.volumeLimitTextControllerValidator
                                .asValidator(context),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 25.0),
                          child: FlutterFlowDropDown<String>(
                            controller: _model.dropDownValueController ??=
                                FormFieldController<String>(null),
                            options: [
                              'mL',
                              'ounces',
                              'cups',
                              'dollars',
                              'calories'
                            ],
                            onChanged: (val) async {
                              safeSetState(() => _model.dropDownValue = val);
                              if (_model.dropDownValue == 'mL') {
                                await currentUserReference!
                                    .update(createUsersRecordData(
                                  volumeLimit:
                                      _model.volumeLimitTextController.text,
                                ));
                                FFAppState().limitType = _model.dropDownValue!;
                                safeSetState(() {});
                                safeSetState(() {});
                              } else if (_model.dropDownValue == 'ounces') {
                                await currentUserReference!
                                    .update(createUsersRecordData(
                                  volumeLimit: functions
                                      .ouncesToMl(double.tryParse(_model
                                          .volumeLimitTextController.text))
                                      .toString(),
                                ));
                                FFAppState().limitType = _model.dropDownValue!;
                                safeSetState(() {});
                                safeSetState(() {});
                              } else if (_model.dropDownValue == 'cups') {
                                await currentUserReference!
                                    .update(createUsersRecordData(
                                  volumeLimit: functions
                                      .cupsToMl(double.tryParse(_model
                                          .volumeLimitTextController.text))
                                      .toString(),
                                ));
                                FFAppState().limitType = _model.dropDownValue!;
                                safeSetState(() {});
                                safeSetState(() {});
                              } else {
                                await currentUserReference!
                                    .update(createUsersRecordData(
                                  volumeLimit:
                                      _model.volumeLimitTextController.text,
                                ));
                                FFAppState().limitType = _model.dropDownValue!;
                                safeSetState(() {});
                                safeSetState(() {});
                              }
                            },
                            width: 105.23,
                            height: 46.4,
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
                              color: FlutterFlowTheme.of(context).info,
                              size: 24.0,
                            ),
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            elevation: 2.0,
                            borderColor: Colors.black,
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
