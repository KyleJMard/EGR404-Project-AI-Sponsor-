import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/progress_bar_and_b_a_c_limit/custom_volume_input/custom_volume_input_widget.dart';
import '/progress_bar_and_b_a_c_limit/volume_progress_meter/volume_progress_meter_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'volume_limit_model.dart';
export 'volume_limit_model.dart';

class VolumeLimitWidget extends StatefulWidget {
  const VolumeLimitWidget({super.key});

  static String routeName = 'VolumeLimit';
  static String routePath = '/volumeLimit';

  @override
  State<VolumeLimitWidget> createState() => _VolumeLimitWidgetState();
}

class _VolumeLimitWidgetState extends State<VolumeLimitWidget> {
  late VolumeLimitModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VolumeLimitModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.drinkTotals2 = await queryDrinkTotalsRecordOnce(
        queryBuilder: (drinkTotalsRecord) => drinkTotalsRecord
            .where(
              'ownerUid',
              isEqualTo: currentUserReference?.id,
            )
            .where(
              'removed',
              isEqualTo: false,
            ),
      );
      _model.bac = functions.calculateBacFromDrinks(
          _model.drinkTotals2!.toList(),
          valueOrDefault(currentUserDocument?.weightLbs, 0) > 0
              ? functions
                  .lbsToKg(valueOrDefault(currentUserDocument?.weightLbs, 0))!
              : valueOrDefault(currentUserDocument?.weightKg, 0),
          valueOrDefault(currentUserDocument?.gender, ''));
      safeSetState(() {});
      _model.bacLabel = functions.bacProgressLabel(_model.bac, '0.000')!;
      safeSetState(() {});
      await Future.wait([
        Future(() async {
          while (FFAppState().currentBAC >= 0.0) {
            _model.bac = functions.calculateBacFromDrinks(
                _model.drinkTotals2!.toList(),
                valueOrDefault(currentUserDocument?.weightLbs, 0) > 0
                    ? functions.lbsToKg(
                        valueOrDefault(currentUserDocument?.weightLbs, 0))!
                    : valueOrDefault(currentUserDocument?.weightKg, 0),
                valueOrDefault(currentUserDocument?.gender, ''));
            safeSetState(() {});
            _model.bacLabel = functions.bacProgressLabel(_model.bac, '0.000')!;
            safeSetState(() {});
            await Future.delayed(
              Duration(
                milliseconds: 1000,
              ),
            );
          }
        }),
      ]);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MouseRegion(
              opaque: false,
              cursor: SystemMouseCursors.click ?? MouseCursor.defer,
              child: wrapWithModel(
                model: _model.volumeProgressMeterModel,
                updateCallback: () => safeSetState(() {}),
                child: VolumeProgressMeterWidget(),
              ),
              onEnter: ((event) async {
                safeSetState(() => _model.mouseRegionHovered = true);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${() {
                        if (FFAppState().limitType == 'dollars') {
                          return FFAppState().totalCost.toString();
                        } else if (FFAppState().limitType == 'calories') {
                          return FFAppState().totalCalories.toString();
                        } else {
                          return FFAppState().totalMl.toString();
                        }
                      }()} ${() {
                        if (FFAppState().limitType == 'dollars') {
                          return FFAppState().limitType;
                        } else if (FFAppState().limitType == 'calories') {
                          return FFAppState().limitType;
                        } else {
                          return 'mL';
                        }
                      }()}',
                      style: TextStyle(
                        color: FlutterFlowTheme.of(context).info,
                        fontWeight: FontWeight.w600,
                        fontSize: 25.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    duration: Duration(milliseconds: 4000),
                    backgroundColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                  ),
                );
              }),
              onExit: ((event) async {
                safeSetState(() => _model.mouseRegionHovered = false);
              }),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 25.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your preferred consumption limit:  ',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.merriweatherSans(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).info,
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AuthUserStreamWidget(
                        builder: (context) => Text(
                          '${valueOrDefault(currentUserDocument?.volumeLimit, '')} ',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.merriweatherSans(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                      Text(
                        () {
                          if (FFAppState().limitType == 'dollars') {
                            return FFAppState().limitType;
                          } else if (FFAppState().limitType == 'calories') {
                            return FFAppState().limitType;
                          } else {
                            return 'mL';
                          }
                        }(),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.merriweatherSans(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).info,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              elevation: 10.0,
              shape: const CircleBorder(),
              child: Container(
                width: 72.99,
                height: 72.99,
                decoration: BoxDecoration(
                  color: Color(0xFFEEDEDE),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                  ),
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
                        return GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: CustomVolumeInputWidget(),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  },
                  child: Icon(
                    Icons.settings_sharp,
                    color: Colors.black,
                    size: 55.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
