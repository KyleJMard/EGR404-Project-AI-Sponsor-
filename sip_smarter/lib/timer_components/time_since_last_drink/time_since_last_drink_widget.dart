import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'time_since_last_drink_model.dart';
export 'time_since_last_drink_model.dart';

/// I want a custom timer that counts up.
///
/// I should be able to feed it input that can control when and how it counts
/// up.
class TimeSinceLastDrinkWidget extends StatefulWidget {
  const TimeSinceLastDrinkWidget({super.key});

  @override
  State<TimeSinceLastDrinkWidget> createState() =>
      _TimeSinceLastDrinkWidgetState();
}

class _TimeSinceLastDrinkWidgetState extends State<TimeSinceLastDrinkWidget>
    with TickerProviderStateMixin {
  late TimeSinceLastDrinkModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TimeSinceLastDrinkModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.timeSinceLastDrinkInMs = functions.timeSinceLastDrinkMs(
          valueOrDefault(currentUserDocument?.lastDrinkTimestampMs, 0));
      safeSetState(() {});
      _model.timerText = functions.timeSinceLastDrinkFormatted(
          valueOrDefault(currentUserDocument?.lastDrinkTimestampMs, 0))!;
      safeSetState(() {});
      await Future.wait([
        Future(() async {
          if (_model.timeSinceLastDrinkInMs! >= 36000000) {
            _model.timerText = '00:00:00';
            safeSetState(() {});
          } else {
            while (FFAppState().totalMl > 0.0) {
              _model.timeSinceLastDrinkInMs = functions.timeSinceLastDrinkMs(
                  valueOrDefault(currentUserDocument?.lastDrinkTimestampMs, 0));
              safeSetState(() {});
              _model.timerText = functions.timeSinceLastDrinkFormatted(
                  valueOrDefault(
                      currentUserDocument?.lastDrinkTimestampMs, 0))!;
              safeSetState(() {});
              await Future.delayed(
                Duration(
                  milliseconds: 1000,
                ),
              );
            }
          }
        }),
        Future(() async {
          while (FFAppState().currentBAC >= 0.0) {
            if (FFAppState().currentBAC <= .059) {
              while (FFAppState().currentBAC <= .059) {
                await Future.wait([
                  Future(() async {
                    if (animationsMap['textOnActionTriggerAnimation1'] !=
                        null) {
                      await animationsMap['textOnActionTriggerAnimation1']!
                          .controller
                          .forward(from: 0.0)
                          .whenComplete(
                              animationsMap['textOnActionTriggerAnimation1']!
                                  .controller
                                  .reverse);
                    }
                  }),
                  Future(() async {
                    if (animationsMap['textOnActionTriggerAnimation2'] !=
                        null) {
                      await animationsMap['textOnActionTriggerAnimation2']!
                          .controller
                          .forward(from: 0.0)
                          .whenComplete(
                              animationsMap['textOnActionTriggerAnimation2']!
                                  .controller
                                  .reverse);
                    }
                  }),
                ]);
              }
            } else {
              if (FFAppState().currentBAC <= .099) {
                while (FFAppState().currentBAC <= .099) {
                  await Future.wait([
                    Future(() async {
                      if (animationsMap['textOnActionTriggerAnimation1'] !=
                          null) {
                        await animationsMap['textOnActionTriggerAnimation1']!
                            .controller
                            .forward(from: 0.0)
                            .whenComplete(
                                animationsMap['textOnActionTriggerAnimation1']!
                                    .controller
                                    .reverse);
                      }
                    }),
                    Future(() async {
                      if (animationsMap['textOnActionTriggerAnimation2'] !=
                          null) {
                        await animationsMap['textOnActionTriggerAnimation2']!
                            .controller
                            .forward(from: 0.0)
                            .whenComplete(
                                animationsMap['textOnActionTriggerAnimation2']!
                                    .controller
                                    .reverse);
                      }
                    }),
                  ]);
                }
              } else {
                if (FFAppState().currentBAC <= .199) {
                  while (FFAppState().currentBAC <= .199) {
                    await Future.wait([
                      Future(() async {
                        if (animationsMap['textOnActionTriggerAnimation1'] !=
                            null) {
                          await animationsMap['textOnActionTriggerAnimation1']!
                              .controller
                              .forward(from: 0.0)
                              .whenComplete(animationsMap[
                                      'textOnActionTriggerAnimation1']!
                                  .controller
                                  .reverse);
                        }
                      }),
                      Future(() async {
                        if (animationsMap['textOnActionTriggerAnimation2'] !=
                            null) {
                          await animationsMap['textOnActionTriggerAnimation2']!
                              .controller
                              .forward(from: 0.0)
                              .whenComplete(animationsMap[
                                      'textOnActionTriggerAnimation2']!
                                  .controller
                                  .reverse);
                        }
                      }),
                    ]);
                  }
                } else {
                  while (FFAppState().currentBAC <= 1000.0) {
                    await Future.wait([
                      Future(() async {
                        if (animationsMap['textOnActionTriggerAnimation1'] !=
                            null) {
                          await animationsMap['textOnActionTriggerAnimation1']!
                              .controller
                              .forward(from: 0.0)
                              .whenComplete(animationsMap[
                                      'textOnActionTriggerAnimation1']!
                                  .controller
                                  .reverse);
                        }
                      }),
                      Future(() async {
                        if (animationsMap['textOnActionTriggerAnimation2'] !=
                            null) {
                          await animationsMap['textOnActionTriggerAnimation2']!
                              .controller
                              .forward(from: 0.0)
                              .whenComplete(animationsMap[
                                      'textOnActionTriggerAnimation2']!
                                  .controller
                                  .reverse);
                        }
                      }),
                    ]);
                  }
                }
              }
            }
          }
        }),
      ]);
    });

    animationsMap.addAll({
      'textOnActionTriggerAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: null,
      ),
      'textOnActionTriggerAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: null,
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

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
        width: double.infinity,
        height: 265.15,
        decoration: BoxDecoration(
          color: Color(0x90000000),
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: Colors.transparent,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                child: GradientText(
                  'Time since last drink...',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).primary,
                    fontSize: 25.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    decoration: TextDecoration.underline,
                    shadows: [
                      Shadow(
                        color: FlutterFlowTheme.of(context).primary,
                        offset: Offset(
                            FFAppState().currentBAC > 0.023 ? 5.0 : 0.0,
                            FFAppState().currentBAC > 0.023 ? 5.0 : 0.0),
                        blurRadius: 5.0,
                      )
                    ],
                  ),
                  colors: [
                    FlutterFlowTheme.of(context).customColor2,
                    FlutterFlowTheme.of(context).customColor3
                  ],
                  gradientDirection: GradientDirection.ltr,
                  gradientType: GradientType.linear,
                ).animateOnActionTrigger(
                  animationsMap['textOnActionTriggerAnimation1']!,
                  effects: [
                    TiltEffect(
                      curve: Curves.easeInOut,
                      delay: 0.0.ms,
                      duration: 1000.0.ms,
                      begin: Offset(
                          () {
                                if (FFAppState().currentBAC <= .029) {
                                  return 0.0;
                                } else if (FFAppState().currentBAC <= .059) {
                                  return -5.0;
                                } else if (FFAppState().currentBAC <= .099) {
                                  return -10.0;
                                } else if (FFAppState().currentBAC <= .199) {
                                  return -20.0;
                                } else {
                                  return -25.0;
                                }
                              }() *
                              (pi / 180),
                          () {
                                if (FFAppState().currentBAC <= .029) {
                                  return 0.0;
                                } else if (FFAppState().currentBAC <= .059) {
                                  return -5.0;
                                } else if (FFAppState().currentBAC <= .099) {
                                  return -10.0;
                                } else if (FFAppState().currentBAC <= .199) {
                                  return -20.0;
                                } else {
                                  return -25.0;
                                }
                              }() *
                              (pi / 180)),
                      end: Offset(
                          () {
                                if (FFAppState().currentBAC <= .029) {
                                  return 0.0;
                                } else if (FFAppState().currentBAC <= .059) {
                                  return 5.0;
                                } else if (FFAppState().currentBAC <= .099) {
                                  return 10.0;
                                } else if (FFAppState().currentBAC <= .199) {
                                  return 20.0;
                                } else {
                                  return 25.0;
                                }
                              }() *
                              (pi / 180),
                          () {
                                if (FFAppState().currentBAC <= .029) {
                                  return 0.0;
                                } else if (FFAppState().currentBAC <= .059) {
                                  return 5.0;
                                } else if (FFAppState().currentBAC <= .099) {
                                  return 10.0;
                                } else if (FFAppState().currentBAC <= .199) {
                                  return 20.0;
                                } else {
                                  return 25.0;
                                }
                              }() *
                              (pi / 180)),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Material(
                color: Colors.transparent,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: 220.52,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).customColor2,
                    borderRadius: BorderRadius.circular(24.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).customColor3,
                      width: 5.0,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 160.0,
                        maxHeight: 100.0,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10.0,
                            color: FlutterFlowTheme.of(context).customColor2,
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                            spreadRadius: 5.0,
                          )
                        ],
                        gradient: LinearGradient(
                          colors: [
                            FlutterFlowTheme.of(context).primaryBackground,
                            FlutterFlowTheme.of(context).secondaryBackground,
                            FlutterFlowTheme.of(context).secondaryBackground
                          ],
                          stops: [0.0, 0.5, 1.0],
                          begin: AlignmentDirectional(0.0, -1.0),
                          end: AlignmentDirectional(0, 1.0),
                        ),
                        borderRadius: BorderRadius.circular(24.0),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).customColor2,
                          width: 5.0,
                        ),
                      ),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Text(
                                  '00:00:00',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: 'Segment7',
                                        color: FFAppState().darkMode
                                            ? Color(0xDE580000)
                                            : Color(0x2B878787),
                                        fontSize: 45.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    _model.timerText,
                                    '00:00:00',
                                  ),
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                    fontFamily: 'Segment7',
                                    color: FFAppState().darkMode
                                        ? Color(0xFFFF0000)
                                        : Colors.black,
                                    fontSize: 45.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    shadows: [
                                      Shadow(
                                        color: FFAppState().darkMode
                                            ? Color(0xFFFF0000)
                                            : Colors.black,
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 2.0,
                                      ),
                                      Shadow(
                                        color: FFAppState().darkMode
                                            ? Color(0xFFFF0000)
                                            : Colors.black,
                                        offset: Offset(
                                            FFAppState().currentBAC > 0.023
                                                ? 5.0
                                                : 0.0,
                                            FFAppState().currentBAC > 0.023
                                                ? 5.0
                                                : 0.0),
                                        blurRadius: 2.0,
                                      )
                                    ],
                                  ),
                                ).animateOnActionTrigger(
                                  animationsMap[
                                      'textOnActionTriggerAnimation2']!,
                                  effects: [
                                    TiltEffect(
                                      curve: Curves.linear,
                                      delay: 0.0.ms,
                                      duration: 1000.0.ms,
                                      begin: Offset(
                                          () {
                                                if (FFAppState().currentBAC <=
                                                    .029) {
                                                  return 0.0;
                                                } else if (FFAppState()
                                                        .currentBAC <=
                                                    .059) {
                                                  return -5.0;
                                                } else if (FFAppState()
                                                        .currentBAC <=
                                                    .099) {
                                                  return -10.0;
                                                } else if (FFAppState()
                                                        .currentBAC <=
                                                    .199) {
                                                  return -20.0;
                                                } else {
                                                  return -25.0;
                                                }
                                              }() *
                                              (pi / 180),
                                          () {
                                                if (FFAppState().currentBAC <=
                                                    .029) {
                                                  return 0.0;
                                                } else if (FFAppState()
                                                        .currentBAC <=
                                                    .059) {
                                                  return -5.0;
                                                } else if (FFAppState()
                                                        .currentBAC <=
                                                    .099) {
                                                  return -10.0;
                                                } else if (FFAppState()
                                                        .currentBAC <=
                                                    .199) {
                                                  return -20.0;
                                                } else {
                                                  return -25.0;
                                                }
                                              }() *
                                              (pi / 180)),
                                      end: Offset(
                                          () {
                                                if (FFAppState().currentBAC <=
                                                    .029) {
                                                  return 0.0;
                                                } else if (FFAppState()
                                                        .currentBAC <=
                                                    .059) {
                                                  return 5.0;
                                                } else if (FFAppState()
                                                        .currentBAC <=
                                                    .099) {
                                                  return 10.0;
                                                } else if (FFAppState()
                                                        .currentBAC <=
                                                    .199) {
                                                  return 20.0;
                                                } else {
                                                  return 25.0;
                                                }
                                              }() *
                                              (pi / 180),
                                          () {
                                                if (FFAppState().currentBAC <=
                                                    .029) {
                                                  return 0.0;
                                                } else if (FFAppState()
                                                        .currentBAC <=
                                                    .059) {
                                                  return 5.0;
                                                } else if (FFAppState()
                                                        .currentBAC <=
                                                    .099) {
                                                  return 10.0;
                                                } else if (FFAppState()
                                                        .currentBAC <=
                                                    .199) {
                                                  return 20.0;
                                                } else {
                                                  return 25.0;
                                                }
                                              }() *
                                              (pi / 180)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
