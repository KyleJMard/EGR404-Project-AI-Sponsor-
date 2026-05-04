import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'delete_drinks_model.dart';
export 'delete_drinks_model.dart';

class DeleteDrinksWidget extends StatefulWidget {
  const DeleteDrinksWidget({
    super.key,
    required this.drinkTotals,
  });

  final DrinkTotalsRecord? drinkTotals;

  @override
  State<DeleteDrinksWidget> createState() => _DeleteDrinksWidgetState();
}

class _DeleteDrinksWidgetState extends State<DeleteDrinksWidget> {
  late DeleteDrinksModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeleteDrinksModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.count = 1.0;
      safeSetState(() {});
    });

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
        width: 672.3,
        height: 337.43,
        constraints: BoxConstraints(
          maxWidth: 400.0,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).primary,
            width: 2.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'How many would you like to delete?',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.merriweather(
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).info,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 349.1,
                  decoration: BoxDecoration(),
                  child: Container(
                    width: double.infinity,
                    child: Slider(
                      activeColor: FlutterFlowTheme.of(context).success,
                      inactiveColor: FlutterFlowTheme.of(context).accent3,
                      min: 0.0,
                      max: 100.0,
                      value: _model.sliderValue ??= 1.0,
                      label: _model.sliderValue?.toStringAsFixed(1),
                      divisions: 100,
                      onChanged: (newValue) async {
                        newValue = double.parse(newValue.toStringAsFixed(1));
                        safeSetState(() => _model.sliderValue = newValue);
                        _model.count = _model.sliderValue;
                        safeSetState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 120.0,
              height: 55.0,
              decoration: BoxDecoration(),
              child: FFButtonWidget(
                onPressed: () async {
                  await actions.decrementDrinkTotal(
                    context,
                    widget!.drinkTotals!.reference.id,
                    functions.doubleToInt(_model.count!),
                  );
                  _model.totGramsUndone = await actions.getTotalAlcoholGrams();
                  _model.totalMlUndo = await actions.getTotalMl(
                    context,
                  );
                  FFAppState().totalMl = _model.totalMlUndo!;
                  FFAppState().currentBAC = functions.calculateBac(
                      _model.totGramsUndone!,
                      valueOrDefault(currentUserDocument?.weightLbs, 0) > 0
                          ? functions.lbsToKg(valueOrDefault(
                              currentUserDocument?.weightLbs, 0))!
                          : valueOrDefault(currentUserDocument?.weightKg, 0),
                      valueOrDefault(currentUserDocument?.gender, ''),
                      functions.elapseSinceFirstDrinkMs(valueOrDefault(
                          currentUserDocument?.firstDrinkTimestampMs, 0))!);
                  FFAppState().ratioMl =
                      functions.progressRatio(_model.totalMlUndo!, '250');
                  FFAppState().update(() {});

                  safeSetState(() {});
                },
                text: 'Confirm',
                options: FFButtonOptions(
                  height: 49.91,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).secondaryText,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.merriweather(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: Colors.white,
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            Text(
              'Or',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.merriweather(
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    fontSize: 20.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
            Container(
              width: 120.0,
              height: 55.0,
              decoration: BoxDecoration(),
              child: FFButtonWidget(
                onPressed: () async {
                  await widget!.drinkTotals!.reference.delete();
                },
                text: 'Delete All',
                options: FFButtonOptions(
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).secondaryText,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.merriweather(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: Colors.white,
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ].divide(SizedBox(height: 25.0)),
        ),
      ),
    );
  }
}
