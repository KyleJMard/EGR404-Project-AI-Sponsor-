import '/auth/firebase_auth/auth_util.dart';
import '/backend/ai_agents/ai_agent.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/barcode_components/barcode_result/barcode_result_widget.dart';
import '/drink_customization_components/add_drink_copy/add_drink_copy_widget.dart';
import '/drink_customization_components/drink/drink_widget.dart';
import '/drink_tabs_components/create_tab/create_tab_widget.dart';
import '/drink_tabs_components/drink_tab/drink_tab_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/miscellaneous_components/camera_image/camera_image_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static String routeName = 'Home';
  static String routePath = '/Home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        Future(() async {
          _model.drinkTotals = await queryDrinkTotalsRecordOnce(
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
          _model.totalMlResult = await actions.getTotalMl(
            context,
          );
          _model.totCost = await actions.getTotalCost(
            context,
          );
          _model.totCal = await actions.getTotalCalories(
            context,
          );
          FFAppState().totalMl = _model.totalMlResult!;
          FFAppState().currentBAC = functions.calculateBacFromDrinks(
              _model.drinkTotals!.toList(),
              valueOrDefault(currentUserDocument?.weightLbs, 0) > 0
                  ? functions.lbsToKg(
                      valueOrDefault(currentUserDocument?.weightLbs, 0))!
                  : valueOrDefault(currentUserDocument?.weightKg, 0),
              valueOrDefault(currentUserDocument?.gender, ''));
          FFAppState().bacRatio = FFAppState().currentBAC;
          FFAppState().totalCost = _model.totCost!;
          FFAppState().totalCalories = _model.totCal!;
          FFAppState().update(() {});
        }),
        Future(() async {
          while (FFAppState().currentBAC >= 0.0) {
            if (FFAppState().currentBAC <= .059) {
              while (FFAppState().currentBAC <= .059) {
                if (animationsMap['textOnActionTriggerAnimation'] != null) {
                  await animationsMap['textOnActionTriggerAnimation']!
                      .controller
                      .forward(from: 0.0)
                      .whenComplete(
                          animationsMap['textOnActionTriggerAnimation']!
                              .controller
                              .reverse);
                }
              }
            } else {
              if (FFAppState().currentBAC <= .099) {
                while (FFAppState().currentBAC <= .099) {
                  if (animationsMap['textOnActionTriggerAnimation'] != null) {
                    await animationsMap['textOnActionTriggerAnimation']!
                        .controller
                        .forward(from: 0.0)
                        .whenComplete(
                            animationsMap['textOnActionTriggerAnimation']!
                                .controller
                                .reverse);
                  }
                }
              } else {
                if (FFAppState().currentBAC <= .199) {
                  while (FFAppState().currentBAC <= .199) {
                    if (animationsMap['textOnActionTriggerAnimation'] != null) {
                      await animationsMap['textOnActionTriggerAnimation']!
                          .controller
                          .forward(from: 0.0)
                          .whenComplete(
                              animationsMap['textOnActionTriggerAnimation']!
                                  .controller
                                  .reverse);
                    }
                  }
                } else {
                  while (FFAppState().currentBAC <= 1000.0) {
                    if (animationsMap['textOnActionTriggerAnimation'] != null) {
                      await animationsMap['textOnActionTriggerAnimation']!
                          .controller
                          .forward(from: 0.0)
                          .whenComplete(
                              animationsMap['textOnActionTriggerAnimation']!
                                  .controller
                                  .reverse);
                    }
                  }
                }
              }
            }
          }
        }),
      ]);
    });

    animationsMap.addAll({
      'containerOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          BlurEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 0.0),
            end: Offset(4.0, 4.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: FlutterFlowTheme.of(context).primary,
            angle: 0.524,
          ),
        ],
      ),
      'iconButtonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: FlutterFlowTheme.of(context).primary,
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'cameraImageOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnActionTriggerAnimation': AnimationInfo(
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
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<UsersRecord>>(
      stream: queryUsersRecord(
        queryBuilder: (usersRecord) => usersRecord.where(
          'uid',
          isEqualTo: currentUserReference?.id,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: SpinKitFadingCube(
                  color: Color(0xFFFBC02D),
                  size: 50.0,
                ),
              ),
            ),
          );
        }
        List<UsersRecord> homeUsersRecordList = snapshot.data!;
        final homeUsersRecord =
            homeUsersRecordList.isNotEmpty ? homeUsersRecordList.first : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                    child: PageView(
                      controller: _model.pageViewController ??=
                          PageController(initialPage: 0),
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 82.5, 0.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    child: Stack(
                                      alignment:
                                          AlignmentDirectional(0.0, -1.0),
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            children: [],
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                height: () {
                                                  if (MediaQuery.sizeOf(context)
                                                          .width <
                                                      kBreakpointSmall) {
                                                    return 492.0;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      400.0) {
                                                    return 560.0;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      430.0) {
                                                    return 590.0;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      440.0) {
                                                    return 635.0;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      450.0) {
                                                    return 700.0;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      820.0) {
                                                    return 800.0;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      840.0) {
                                                    return 900.0;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      1040.0) {
                                                    return 1075.0;
                                                  } else {
                                                    return 600.0;
                                                  }
                                                }(),
                                                decoration: BoxDecoration(),
                                                child: StreamBuilder<
                                                    List<DrinkTotalsRecord>>(
                                                  stream:
                                                      queryDrinkTotalsRecord(
                                                    queryBuilder:
                                                        (drinkTotalsRecord) =>
                                                            drinkTotalsRecord
                                                                .where(
                                                                  'ownerUid',
                                                                  isEqualTo:
                                                                      currentUserReference
                                                                          ?.id,
                                                                )
                                                                .where(
                                                                  'removed',
                                                                  isEqualTo:
                                                                      false,
                                                                )
                                                                .where(
                                                                  'dayKey',
                                                                  isEqualTo:
                                                                      functions
                                                                          .getTodayDayKey(),
                                                                )
                                                                .orderBy(
                                                                    'lastAddedAt',
                                                                    descending:
                                                                        true),
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50.0,
                                                          height: 50.0,
                                                          child:
                                                              SpinKitFadingCube(
                                                            color: Color(
                                                                0xFFFBC02D),
                                                            size: 50.0,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<DrinkTotalsRecord>
                                                        listViewDrinkTotalsRecordList =
                                                        snapshot.data!;

                                                    return ListView.separated(
                                                      padding: EdgeInsets.zero,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          listViewDrinkTotalsRecordList
                                                              .length,
                                                      separatorBuilder: (_,
                                                              __) =>
                                                          SizedBox(height: 1.0),
                                                      itemBuilder: (context,
                                                          listViewIndex) {
                                                        final listViewDrinkTotalsRecord =
                                                            listViewDrinkTotalsRecordList[
                                                                listViewIndex];
                                                        return StreamBuilder<
                                                            List<
                                                                DailyDrinkLogRecord>>(
                                                          stream:
                                                              queryDailyDrinkLogRecord(
                                                            queryBuilder:
                                                                (dailyDrinkLogRecord) =>
                                                                    dailyDrinkLogRecord
                                                                        .where(
                                                                          'uid',
                                                                          isEqualTo:
                                                                              currentUserReference,
                                                                        )
                                                                        .where(
                                                                          'dayStart',
                                                                          isEqualTo:
                                                                              listViewDrinkTotalsRecord.dayStart,
                                                                        )
                                                                        .where(
                                                                          'dailyRemoved',
                                                                          isEqualTo:
                                                                              false,
                                                                        ),
                                                            singleRecord: true,
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  child:
                                                                      SpinKitFadingCube(
                                                                    color: Color(
                                                                        0xFFFBC02D),
                                                                    size: 50.0,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            List<DailyDrinkLogRecord>
                                                                containerDailyDrinkLogRecordList =
                                                                snapshot.data!;
                                                            // Return an empty Container when the item does not exist.
                                                            if (snapshot.data!
                                                                .isEmpty) {
                                                              return Container();
                                                            }
                                                            final containerDailyDrinkLogRecord =
                                                                containerDailyDrinkLogRecordList
                                                                        .isNotEmpty
                                                                    ? containerDailyDrinkLogRecordList
                                                                        .first
                                                                    : null;

                                                            return Container(
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Hero(
                                                                tag: 'addDrink',
                                                                transitionOnUserGestures:
                                                                    true,
                                                                child: Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  child:
                                                                      DrinkWidget(
                                                                    key: Key(
                                                                        'Key7p4_${listViewIndex}_of_${listViewDrinkTotalsRecordList.length}'),
                                                                    drinksTotalsDoc:
                                                                        listViewDrinkTotalsRecord,
                                                                    drinkLogs:
                                                                        containerDailyDrinkLogRecord,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ).animateOnActionTrigger(
                                animationsMap[
                                    'containerOnActionTriggerAnimation']!,
                              ),
                              if (FFAppState().totalMl == 0.0)
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                ),
                              Align(
                                alignment: AlignmentDirectional(1.0, 1.01),
                                child: Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 89.0,
                                      constraints: BoxConstraints(
                                        minWidth: double.infinity,
                                        maxWidth: double.infinity,
                                      ),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4.0,
                                            color: Color(0xFFFBC02D),
                                            offset: Offset(
                                              0.0,
                                              2.0,
                                            ),
                                            spreadRadius: 2.0,
                                          )
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFB6BEFF),
                                            Color(0x79DF13BA),
                                            Color(0x3CFBC02D)
                                          ],
                                          stops: [0.0, 0.5, 1.0],
                                          begin:
                                              AlignmentDirectional(1.0, -1.0),
                                          end: AlignmentDirectional(-1.0, 1.0),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        shape: BoxShape.rectangle,
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 1.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 5.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 82.7,
                                                decoration: BoxDecoration(),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Material(
                                                      color: Colors.transparent,
                                                      elevation: 5.0,
                                                      shape:
                                                          const CircleBorder(),
                                                      child: Container(
                                                        width: 75.0,
                                                        height: 75.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            image: Image.asset(
                                                              Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark
                                                                  ? 'assets/images/AIGenImageForAddDrinks.png'
                                                                  : 'assets/images/ChatGPT_Image_Dec_24,_2025,_12_55_43_AM.png',
                                                            ).image,
                                                          ),
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFFFAFF00),
                                                          ),
                                                        ),
                                                        child: Opacity(
                                                          opacity: 0.0,
                                                          child:
                                                              FlutterFlowIconButton(
                                                            borderRadius: 20.0,
                                                            buttonSize: 75.0,
                                                            icon: Icon(
                                                              Icons.add,
                                                              size: 60.0,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              if (animationsMap[
                                                                      'containerOnActionTriggerAnimation'] !=
                                                                  null) {
                                                                await animationsMap[
                                                                        'containerOnActionTriggerAnimation']!
                                                                    .controller
                                                                    .forward(
                                                                        from:
                                                                            0.0);
                                                              }
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .unfocus();
                                                                      FocusManager
                                                                          .instance
                                                                          .primaryFocus
                                                                          ?.unfocus();
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          AddDrinkCopyWidget(),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));

                                                              _model.totalMlResult3 =
                                                                  await actions
                                                                      .getTotalMl(
                                                                context,
                                                              );
                                                              _model.totGrams3 =
                                                                  await actions
                                                                      .getTotalAlcoholGrams();
                                                              FFAppState()
                                                                      .totalMl =
                                                                  _model
                                                                      .totalMlResult3!;
                                                              FFAppState().currentBAC = functions.calculateBac(
                                                                  _model
                                                                      .totGrams3!,
                                                                  valueOrDefault(
                                                                              currentUserDocument
                                                                                  ?.weightLbs,
                                                                              0) >
                                                                          0
                                                                      ? functions.lbsToKg(valueOrDefault(
                                                                          currentUserDocument
                                                                              ?.weightLbs,
                                                                          0))!
                                                                      : valueOrDefault(
                                                                          currentUserDocument
                                                                              ?.weightKg,
                                                                          0),
                                                                  valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.gender,
                                                                      ''),
                                                                  functions.elapseSinceFirstDrinkMs(
                                                                      valueOrDefault(
                                                                          currentUserDocument
                                                                              ?.firstDrinkTimestampMs,
                                                                          0))!);
                                                              FFAppState()
                                                                      .bacRatio =
                                                                  FFAppState()
                                                                      .currentBAC;
                                                              FFAppState()
                                                                  .update(
                                                                      () {});
                                                              if (animationsMap[
                                                                      'containerOnActionTriggerAnimation'] !=
                                                                  null) {
                                                                animationsMap[
                                                                        'containerOnActionTriggerAnimation']!
                                                                    .controller
                                                                    .reset();
                                                              }

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                          ).animateOnPageLoad(
                                                                  animationsMap[
                                                                      'iconButtonOnPageLoadAnimation']!),
                                                        ),
                                                      ),
                                                    ).animateOnPageLoad(
                                                        animationsMap[
                                                            'containerOnPageLoadAnimation1']!),
                                                    Stack(
                                                      children: [
                                                        if (FFAppState()
                                                                .darkMode
                                                            ? true
                                                            : false)
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              final selectedMedia =
                                                                  await selectMediaWithSourceBottomSheet(
                                                                context:
                                                                    context,
                                                                allowPhoto:
                                                                    true,
                                                              );
                                                              if (selectedMedia !=
                                                                      null &&
                                                                  selectedMedia.every((m) =>
                                                                      validateFileFormat(
                                                                          m.storagePath,
                                                                          context))) {
                                                                safeSetState(() =>
                                                                    _model.isDataUploading_uploadDataHox2 =
                                                                        true);
                                                                var selectedUploadedFiles =
                                                                    <FFUploadedFile>[];

                                                                try {
                                                                  selectedUploadedFiles =
                                                                      selectedMedia
                                                                          .map((m) =>
                                                                              FFUploadedFile(
                                                                                name: m.storagePath.split('/').last,
                                                                                bytes: m.bytes,
                                                                                height: m.dimensions?.height,
                                                                                width: m.dimensions?.width,
                                                                                blurHash: m.blurHash,
                                                                                originalFilename: m.originalFilename,
                                                                              ))
                                                                          .toList();
                                                                } finally {
                                                                  _model.isDataUploading_uploadDataHox2 =
                                                                      false;
                                                                }
                                                                if (selectedUploadedFiles
                                                                        .length ==
                                                                    selectedMedia
                                                                        .length) {
                                                                  safeSetState(
                                                                      () {
                                                                    _model.uploadedLocalFile_uploadDataHox2 =
                                                                        selectedUploadedFiles
                                                                            .first;
                                                                  });
                                                                } else {
                                                                  safeSetState(
                                                                      () {});
                                                                  return;
                                                                }
                                                              }

                                                              await callAiAgent(
                                                                context:
                                                                    context,
                                                                prompt:
                                                                    'nothing',
                                                                imageAsset: _model
                                                                    .uploadedLocalFile_uploadDataHox2,
                                                                threadId:
                                                                    currentUserUid,
                                                                agentCloudFunctionName:
                                                                    'drinkImageParser',
                                                                provider:
                                                                    'GOOGLE',
                                                                agentJson:
                                                                    '{\"status\":\"LIVE\",\"identifier\":{\"name\":\"drinkImageParser\",\"key\":\"j1fkq\"},\"name\":\"DrinkImageParser\",\"description\":\"This agent takes an image of a drink and extracts structured data about the drink the person is actively consuming.  The image is only used to estimate size. If the image shows a large container (such as a handle, bottle, or jug), the agent should infer a reasonable single serving instead of treating the whole container as the drink. The agent returns normalized JSON containing drink_name, drink_abv, drink_size, drink_size_type, and confidence, and drink_name must be formatted in clean title case.\\r\\n\",\"aiModel\":{\"provider\":\"GOOGLE\",\"model\":\"gemini-2.0-flash\",\"parameters\":{\"temperature\":{\"inputValue\":0.8},\"maxTokens\":{\"inputValue\":8192},\"topP\":{\"inputValue\":0.95}},\"messages\":[{\"role\":\"SYSTEM\",\"text\":\"You analyze images of drinks and return a JSON object that represents the drink the person is actively consuming. Images always override text input. \\n\\r\\nIf the image shows a large container (handle, bottle, jug, can, multipack, etc.) do NOT assume the user is drinking the entire container. Infer the most likely single serving based on the drink type. For example:\\r\\n- A handle of 40 percent vodka implies a typical bar shot (about 1.5 oz).\\r\\n- A large bottle of wine implies a single glass pour (5 oz).\\r\\n- A liquor bottle shown without context should default to a standard serving size (1.5 oz).\\r\\n\\r\\nOutput must follow this exact structure:\\r\\n\\r\\n{\\r\\n  \\\"drink_name\\\": string,\\r\\n  \\\"drink_abv\\\": number,\\r\\n  \\\"drink_size\\\": number,\\r\\n  \\\"drink_size_type\\\": \\\"oz\\\" or \\\"mL\\\",\\r\\n\\\"drink_calories\\\": number,\\n  \\\"confidence\\\": number\\r\\n}\\r\\n\\r\\nRules:\\r\\n- drink_calories is the number of calories in a single serving of the drink\\n- Format drink_name in clean, presentable title case.\\r\\n- If information is missing, guess with lower confidence.\\r\\n- drink_abv is the percent ABV without the percent symbol.\\r\\n- drink_size is numeric only and should represent a realistic single serving.\\n- drink_size_type must be \\\"oz\\\", \\\"mL\\\", or \\\"cups\\\".\\r\\n- confidence is a number from 0 to 100.\\r\\n- Do not include any text outside the JSON.\"}]},\"requestOptions\":{\"requestTypes\":[\"IMAGE\",\"PLAINTEXT\"]},\"responseOptions\":{\"responseType\":\"JSON\"}}',
                                                                responseType:
                                                                    'JSON',
                                                              ).then(
                                                                  (generatedText) {
                                                                safeSetState(() =>
                                                                    _model.goldenAIAgent2 =
                                                                        generatedText);
                                                              });

                                                              FFAppState()
                                                                      .drinkSizeType =
                                                                  getJsonField(
                                                                _model
                                                                    .goldenAIAgent2,
                                                                r'''$["drink_size_type"]''',
                                                              ).toString();
                                                              safeSetState(
                                                                  () {});
                                                              await Future
                                                                  .delayed(
                                                                Duration(
                                                                  milliseconds:
                                                                      200,
                                                                ),
                                                              );
                                                              await actions
                                                                  .addDrink(
                                                                context,
                                                                functions
                                                                    .toLowerCase(
                                                                        getJsonField(
                                                                  _model
                                                                      .goldenAIAgent2,
                                                                  r'''$["drink_name"]''',
                                                                ).toString()),
                                                                getJsonField(
                                                                  _model
                                                                      .goldenAIAgent2,
                                                                  r'''$["drink_name"]''',
                                                                ).toString(),
                                                                FFAppState().drinkSizeType ==
                                                                        'oz'
                                                                    ? functions
                                                                        .ouncesToMl(
                                                                            getJsonField(
                                                                        _model
                                                                            .goldenAIAgent2,
                                                                        r'''$["drink_size"]''',
                                                                      ))
                                                                    : functions
                                                                        .doubleToInt(
                                                                            getJsonField(
                                                                        _model
                                                                            .goldenAIAgent2,
                                                                        r'''$["drink_size"]''',
                                                                      )),
                                                                'mL',
                                                                functions
                                                                    .stringToDouble(
                                                                        getJsonField(
                                                                  _model
                                                                      .goldenAIAgent2,
                                                                  r'''$["drink_abv"]''',
                                                                ).toString()),
                                                                1,
                                                                '0',
                                                                'null',
                                                                getJsonField(
                                                                  _model
                                                                      .goldenAIAgent2,
                                                                  r'''$["drink_calories"]''',
                                                                ),
                                                              );
                                                              await Future
                                                                  .delayed(
                                                                Duration(
                                                                  milliseconds:
                                                                      200,
                                                                ),
                                                              );
                                                              _model.totalMlCamera2 =
                                                                  await actions
                                                                      .getTotalMl(
                                                                context,
                                                              );
                                                              FFAppState()
                                                                      .drinkSizeType =
                                                                  getJsonField(
                                                                _model
                                                                    .aIAudioRecord,
                                                                r'''$["drink_size_type"]''',
                                                              ).toString();
                                                              FFAppState()
                                                                      .totalMl =
                                                                  _model
                                                                      .totalMlCamera2!;
                                                              safeSetState(
                                                                  () {});

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              elevation: 5.0,
                                                              shape:
                                                                  const CircleBorder(),
                                                              child: Container(
                                                                width: 75.0,
                                                                height: 75.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    fit: BoxFit
                                                                        .none,
                                                                    image: Image
                                                                        .asset(
                                                                      'assets/images/CameraIconImage.webp',
                                                                    ).image,
                                                                  ),
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary
                                                                    ],
                                                                    stops: [
                                                                      0.0,
                                                                      1.0
                                                                    ],
                                                                    begin:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            -1.0),
                                                                    end: AlignmentDirectional(
                                                                        0, 1.0),
                                                                  ),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ).animateOnPageLoad(
                                                              animationsMap[
                                                                  'containerOnPageLoadAnimation2']!),
                                                        if (FFAppState()
                                                                .darkMode
                                                            ? false
                                                            : true)
                                                          Material(
                                                            color: Colors
                                                                .transparent,
                                                            elevation: 5.0,
                                                            shape:
                                                                const CircleBorder(),
                                                            child: Container(
                                                              width: 75.0,
                                                              height: 75.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Visibility(
                                                                visible:
                                                                    FFAppState()
                                                                            .darkMode
                                                                        ? false
                                                                        : true,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    final selectedMedia =
                                                                        await selectMediaWithSourceBottomSheet(
                                                                      context:
                                                                          context,
                                                                      allowPhoto:
                                                                          true,
                                                                    );
                                                                    if (selectedMedia !=
                                                                            null &&
                                                                        selectedMedia.every((m) => validateFileFormat(
                                                                            m.storagePath,
                                                                            context))) {
                                                                      safeSetState(() =>
                                                                          _model.isDataUploading_uploadDataHox =
                                                                              true);
                                                                      var selectedUploadedFiles =
                                                                          <FFUploadedFile>[];

                                                                      try {
                                                                        selectedUploadedFiles = selectedMedia
                                                                            .map((m) => FFUploadedFile(
                                                                                  name: m.storagePath.split('/').last,
                                                                                  bytes: m.bytes,
                                                                                  height: m.dimensions?.height,
                                                                                  width: m.dimensions?.width,
                                                                                  blurHash: m.blurHash,
                                                                                  originalFilename: m.originalFilename,
                                                                                ))
                                                                            .toList();
                                                                      } finally {
                                                                        _model.isDataUploading_uploadDataHox =
                                                                            false;
                                                                      }
                                                                      if (selectedUploadedFiles
                                                                              .length ==
                                                                          selectedMedia
                                                                              .length) {
                                                                        safeSetState(
                                                                            () {
                                                                          _model.uploadedLocalFile_uploadDataHox =
                                                                              selectedUploadedFiles.first;
                                                                        });
                                                                      } else {
                                                                        safeSetState(
                                                                            () {});
                                                                        return;
                                                                      }
                                                                    }

                                                                    await callAiAgent(
                                                                      context:
                                                                          context,
                                                                      prompt:
                                                                          'nothing',
                                                                      imageAsset:
                                                                          _model
                                                                              .uploadedLocalFile_uploadDataHox,
                                                                      threadId:
                                                                          currentUserUid,
                                                                      agentCloudFunctionName:
                                                                          'drinkImageParser',
                                                                      provider:
                                                                          'GOOGLE',
                                                                      agentJson:
                                                                          '{\"status\":\"LIVE\",\"identifier\":{\"name\":\"drinkImageParser\",\"key\":\"j1fkq\"},\"name\":\"DrinkImageParser\",\"description\":\"This agent takes an image of a drink and extracts structured data about the drink the person is actively consuming.  The image is only used to estimate size. If the image shows a large container (such as a handle, bottle, or jug), the agent should infer a reasonable single serving instead of treating the whole container as the drink. The agent returns normalized JSON containing drink_name, drink_abv, drink_size, drink_size_type, and confidence, and drink_name must be formatted in clean title case.\\r\\n\",\"aiModel\":{\"provider\":\"GOOGLE\",\"model\":\"gemini-2.0-flash\",\"parameters\":{\"temperature\":{\"inputValue\":0.8},\"maxTokens\":{\"inputValue\":8192},\"topP\":{\"inputValue\":0.95}},\"messages\":[{\"role\":\"SYSTEM\",\"text\":\"You analyze images of drinks and return a JSON object that represents the drink the person is actively consuming. Images always override text input. \\n\\r\\nIf the image shows a large container (handle, bottle, jug, can, multipack, etc.) do NOT assume the user is drinking the entire container. Infer the most likely single serving based on the drink type. For example:\\r\\n- A handle of 40 percent vodka implies a typical bar shot (about 1.5 oz).\\r\\n- A large bottle of wine implies a single glass pour (5 oz).\\r\\n- A liquor bottle shown without context should default to a standard serving size (1.5 oz).\\r\\n\\r\\nOutput must follow this exact structure:\\r\\n\\r\\n{\\r\\n  \\\"drink_name\\\": string,\\r\\n  \\\"drink_abv\\\": number,\\r\\n  \\\"drink_size\\\": number,\\r\\n  \\\"drink_size_type\\\": \\\"oz\\\" or \\\"mL\\\",\\r\\n\\\"drink_calories\\\": number,\\n  \\\"confidence\\\": number\\r\\n}\\r\\n\\r\\nRules:\\r\\n- drink_calories is the number of calories in a single serving of the drink\\n- Format drink_name in clean, presentable title case.\\r\\n- If information is missing, guess with lower confidence.\\r\\n- drink_abv is the percent ABV without the percent symbol.\\r\\n- drink_size is numeric only and should represent a realistic single serving.\\n- drink_size_type must be \\\"oz\\\", \\\"mL\\\", or \\\"cups\\\".\\r\\n- confidence is a number from 0 to 100.\\r\\n- Do not include any text outside the JSON.\"}]},\"requestOptions\":{\"requestTypes\":[\"IMAGE\",\"PLAINTEXT\"]},\"responseOptions\":{\"responseType\":\"JSON\"}}',
                                                                      responseType:
                                                                          'JSON',
                                                                    ).then(
                                                                        (generatedText) {
                                                                      safeSetState(() =>
                                                                          _model.goldenAIAgent =
                                                                              generatedText);
                                                                    });

                                                                    FFAppState()
                                                                            .drinkSizeType =
                                                                        getJsonField(
                                                                      _model
                                                                          .goldenAIAgent,
                                                                      r'''$["drink_size_type"]''',
                                                                    ).toString();
                                                                    safeSetState(
                                                                        () {});
                                                                    await Future
                                                                        .delayed(
                                                                      Duration(
                                                                        milliseconds:
                                                                            200,
                                                                      ),
                                                                    );
                                                                    await actions
                                                                        .addDrink(
                                                                      context,
                                                                      functions
                                                                          .toLowerCase(
                                                                              getJsonField(
                                                                        _model
                                                                            .goldenAIAgent,
                                                                        r'''$["drink_name"]''',
                                                                      ).toString()),
                                                                      getJsonField(
                                                                        _model
                                                                            .goldenAIAgent,
                                                                        r'''$["drink_name"]''',
                                                                      ).toString(),
                                                                      FFAppState().drinkSizeType ==
                                                                              'oz'
                                                                          ? functions.ouncesToMl(
                                                                              getJsonField(
                                                                              _model.goldenAIAgent,
                                                                              r'''$["drink_size"]''',
                                                                            ))
                                                                          : functions
                                                                              .doubleToInt(getJsonField(
                                                                              _model.goldenAIAgent,
                                                                              r'''$["drink_size"]''',
                                                                            )),
                                                                      'mL',
                                                                      functions
                                                                          .stringToDouble(
                                                                              getJsonField(
                                                                        _model
                                                                            .goldenAIAgent,
                                                                        r'''$["drink_abv"]''',
                                                                      ).toString()),
                                                                      1,
                                                                      '0',
                                                                      'null',
                                                                      getJsonField(
                                                                        _model
                                                                            .goldenAIAgent,
                                                                        r'''$["drink_calories"]''',
                                                                      ),
                                                                    );
                                                                    await Future
                                                                        .delayed(
                                                                      Duration(
                                                                        milliseconds:
                                                                            200,
                                                                      ),
                                                                    );
                                                                    _model.totalMlCamera =
                                                                        await actions
                                                                            .getTotalMl(
                                                                      context,
                                                                    );
                                                                    FFAppState()
                                                                            .drinkSizeType =
                                                                        getJsonField(
                                                                      _model
                                                                          .aIAudioRecord,
                                                                      r'''$["drink_size_type"]''',
                                                                    ).toString();
                                                                    FFAppState()
                                                                            .totalMl =
                                                                        _model
                                                                            .totalMlCamera!;
                                                                    safeSetState(
                                                                        () {});

                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .cameraImageModel,
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        CameraImageWidget(),
                                                                  ),
                                                                ).animateOnPageLoad(
                                                                    animationsMap[
                                                                        'cameraImageOnPageLoadAnimation']!),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    Material(
                                                      color: Colors.transparent,
                                                      elevation: 5.0,
                                                      shape:
                                                          const CircleBorder(),
                                                      child: Container(
                                                        width: 75.0,
                                                        height: 75.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                            colors: [
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .customColor4,
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .customColor2
                                                            ],
                                                            stops: [0.0, 1.0],
                                                            begin:
                                                                AlignmentDirectional(
                                                                    0.0, -1.0),
                                                            end:
                                                                AlignmentDirectional(
                                                                    0, 1.0),
                                                          ),
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                        ),
                                                        child:
                                                            FlutterFlowIconButton(
                                                          borderRadius: 8.0,
                                                          buttonSize: 54.7,
                                                          icon: FaIcon(
                                                            FontAwesomeIcons
                                                                .barcode,
                                                            color: Colors.black,
                                                            size: 45.0,
                                                          ),
                                                          onPressed: () async {
                                                            var _shouldSetState =
                                                                false;
                                                            _model.qRCodeResult =
                                                                await FlutterBarcodeScanner
                                                                    .scanBarcode(
                                                              '#C62828', // scanning line color
                                                              'Cancel', // cancel button text
                                                              true, // whether to show the torch (camera LED) toggle icon
                                                              ScanMode.QR,
                                                            );

                                                            _shouldSetState =
                                                                true;
                                                            _model.apiResultfkx =
                                                                await UPCItemDBCall
                                                                    .call(
                                                              barcode: _model
                                                                  .qRCodeResult,
                                                            );

                                                            _shouldSetState =
                                                                true;
                                                            if ((_model
                                                                    .apiResultfkx
                                                                    ?.succeeded ??
                                                                true)) {
                                                              if (getJsonField(
                                                                    (_model.apiResultfkx
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                    r'''$.items[:].title''',
                                                                  ) ==
                                                                  null) {
                                                                if (_shouldSetState)
                                                                  safeSetState(
                                                                      () {});
                                                                return;
                                                              }

                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .unfocus();
                                                                      FocusManager
                                                                          .instance
                                                                          .primaryFocus
                                                                          ?.unfocus();
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          BarcodeResultWidget(
                                                                        drinkName:
                                                                            getJsonField(
                                                                          (_model.apiResultfkx?.jsonBody ??
                                                                              ''),
                                                                          r'''$.items[:].title''',
                                                                        ).toString(),
                                                                        prices: (getJsonField(
                                                                          (_model.apiResultfkx?.jsonBody ??
                                                                              ''),
                                                                          r'''$.items[:].offers[:].price''',
                                                                          true,
                                                                        ) as List?)!
                                                                            .map<String>((e) => e.toString())
                                                                            .toList()
                                                                            .cast<String>(),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Invalid QR Code',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFFFF0000),
                                                                    ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                ),
                                                              );
                                                            }

                                                            if (_shouldSetState)
                                                              safeSetState(
                                                                  () {});
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Material(
                                                      color: Colors.transparent,
                                                      elevation: 5.0,
                                                      shape:
                                                          const CircleBorder(),
                                                      child: Container(
                                                        width: 75.0,
                                                        height: 75.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                            colors: [
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .customColor4,
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .customColor2
                                                            ],
                                                            stops: [0.0, 1.0],
                                                            begin:
                                                                AlignmentDirectional(
                                                                    0.0, -1.0),
                                                            end:
                                                                AlignmentDirectional(
                                                                    0, 1.0),
                                                          ),
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          children: [
                                                            Opacity(
                                                              opacity: 0.5,
                                                              child: Container(
                                                                width: 100.0,
                                                                height: 100.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary
                                                                    ],
                                                                    stops: [
                                                                      0.0,
                                                                      1.0
                                                                    ],
                                                                    begin:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            -1.0),
                                                                    end: AlignmentDirectional(
                                                                        0, 1.0),
                                                                  ),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                              ),
                                                            ),
                                                            if (!_model
                                                                .isRecording)
                                                              InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  _model.isRecording =
                                                                      true;
                                                                  safeSetState(
                                                                      () {});
                                                                  await startAudioRecording(
                                                                    context,
                                                                    audioRecorder:
                                                                        _model.audioRecorder ??=
                                                                            AudioRecorder(),
                                                                  );
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .mic_sharp,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 75.0,
                                                                ),
                                                              ),
                                                            if (_model
                                                                .isRecording)
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    await stopAudioRecording(
                                                                      audioRecorder:
                                                                          _model
                                                                              .audioRecorder,
                                                                      audioName:
                                                                          'recordedFileBytes',
                                                                      onRecordingComplete:
                                                                          (audioFilePath,
                                                                              audioBytes) {
                                                                        _model.goldenPathRecording =
                                                                            audioFilePath;
                                                                        _model.recordedFileBytes =
                                                                            audioBytes;
                                                                      },
                                                                    );

                                                                    _model.isRecording =
                                                                        false;
                                                                    safeSetState(
                                                                        () {});
                                                                    {
                                                                      safeSetState(() =>
                                                                          _model.isDataUploading_uploadDataDid =
                                                                              true);
                                                                      var selectedUploadedFiles =
                                                                          <FFUploadedFile>[];
                                                                      var selectedFiles =
                                                                          <SelectedFile>[];
                                                                      var downloadUrls =
                                                                          <String>[];
                                                                      try {
                                                                        selectedUploadedFiles = _model.recordedFileBytes.bytes!.isNotEmpty
                                                                            ? [
                                                                                _model.recordedFileBytes
                                                                              ]
                                                                            : <FFUploadedFile>[];
                                                                        selectedFiles =
                                                                            selectedFilesFromUploadedFiles(
                                                                          selectedUploadedFiles,
                                                                        );
                                                                        downloadUrls = (await Future
                                                                                .wait(
                                                                          selectedFiles
                                                                              .map(
                                                                            (f) async =>
                                                                                await uploadData(f.storagePath, f.bytes),
                                                                          ),
                                                                        ))
                                                                            .where((u) =>
                                                                                u !=
                                                                                null)
                                                                            .map((u) =>
                                                                                u!)
                                                                            .toList();
                                                                      } finally {
                                                                        _model.isDataUploading_uploadDataDid =
                                                                            false;
                                                                      }
                                                                      if (selectedUploadedFiles.length ==
                                                                              selectedFiles
                                                                                  .length &&
                                                                          downloadUrls.length ==
                                                                              selectedFiles.length) {
                                                                        safeSetState(
                                                                            () {
                                                                          _model.uploadedLocalFile_uploadDataDid =
                                                                              selectedUploadedFiles.first;
                                                                          _model.uploadedFileUrl_uploadDataDid =
                                                                              downloadUrls.first;
                                                                        });
                                                                      } else {
                                                                        safeSetState(
                                                                            () {});
                                                                        return;
                                                                      }
                                                                    }

                                                                    await callAiAgent(
                                                                      context:
                                                                          context,
                                                                      prompt:
                                                                          '',
                                                                      audioAsset:
                                                                          _model
                                                                              .recordedFileBytes,
                                                                      threadId:
                                                                          valueOrDefault<
                                                                              String>(
                                                                        homeUsersRecord
                                                                            ?.uid,
                                                                        '0',
                                                                      ),
                                                                      agentCloudFunctionName:
                                                                          'drinkAudioParser',
                                                                      provider:
                                                                          'GOOGLE',
                                                                      agentJson:
                                                                          '{\"status\":\"LIVE\",\"identifier\":{\"name\":\"drinkAudioParser\",\"key\":\"169uq\"},\"name\":\"DrinkAudioParser\",\"description\":\"This agent takes audio of a drink and extracts structured data about the drink the person is actively consuming.  The audio should be taken literally. If the audio mentions something (such as a handle, bottle, or jug), the agent should infer a reasonable single serving instead of treating the whole container as the drink. The agent returns normalized JSON containing drink_name, drink_abv, drink_size, drink_size_type, and confidence, and drink_name must be formatted in clean title case.\\r\\n\",\"aiModel\":{\"provider\":\"GOOGLE\",\"model\":\"gemini-2.5-flash\",\"parameters\":{\"temperature\":{\"inputValue\":0.8},\"maxTokens\":{\"inputValue\":8192},\"topP\":{\"inputValue\":0.95}},\"messages\":[{\"role\":\"SYSTEM\",\"text\":\"You analyze audio of drinks and return a JSON object that represents the drink the person is actively consuming. Audio overrides text input. The user may also state which tab the drink may be put under (i.e. \\\"...put under Kyle\'s tab\\\" results in string Kyle). The user may also specify the quantity of drinks to add, e.g., \\\"Put 3 Modelos under Kyle\'s tab\\\" should result in drink_count equaling 3. \\n\\r\\nIf theaudio describes a large container (handle, bottle, jug, can, multipack, etc.) do NOT assume the user is drinking the entire container. Infer the most likely single serving based on the drink type. For example:\\r\\n- A handle of 40 percent vodka implies a typical bar shot (about 1.5 oz).\\r\\n- A large bottle of wine implies a single glass pour (5 oz).\\r\\n- A liquor bottle shown without context should default to a standard serving size (1.5 oz).\\r\\n\\r\\nOutput must follow this exact structure:\\r\\n\\r\\n{\\r\\n  \\\"drink_name\\\": string,\\r\\n  \\\"drink_abv\\\": number,\\r\\n  \\\"drink_size\\\": number,\\r\\n  \\\"drink_size_type\\\": \\\"oz\\\" or \\\"mL\\\",\\r\\n  \\\"drink_tab\\\": string,\\n  \\\"drink_count\\\": number,\\n\\\"drink_calories\\\": number,\\n  \\\"confidence\\\": number\\r\\n}\\r\\n\\r\\nRules:\\r\\n- drink_calories is the number of calories in a single serving of the drink\\n- Format drink_name in clean, presentable title case.\\r\\n- If information is missing, guess with lower confidence.\\r\\n- drink_abv is the percent ABV without the percent symbol.\\r\\n- drink_size is numeric only and should represent a realistic single serving.\\n- drink_size_type must be \\\"oz\\\", \\\"mL\\\", or \\\"cups\\\".\\r\\n- confidence is a number from 0 to 100.\\r\\n- Do not include any text outside the JSON.\"}]},\"requestOptions\":{\"requestTypes\":[\"AUDIO\",\"PLAINTEXT\"]},\"responseOptions\":{\"responseType\":\"JSON\"}}',
                                                                      responseType:
                                                                          'JSON',
                                                                    ).then(
                                                                        (generatedText) {
                                                                      safeSetState(() =>
                                                                          _model.aIAudioRecord =
                                                                              generatedText);
                                                                    });

                                                                    await actions
                                                                        .addDrink(
                                                                      context,
                                                                      functions
                                                                          .toLowerCase(
                                                                              getJsonField(
                                                                        _model
                                                                            .aIAudioRecord,
                                                                        r'''$["drink_name"]''',
                                                                      ).toString()),
                                                                      getJsonField(
                                                                        _model
                                                                            .aIAudioRecord,
                                                                        r'''$["drink_name"]''',
                                                                      ).toString(),
                                                                      functions
                                                                          .stringToInt(
                                                                              getJsonField(
                                                                        _model
                                                                            .aIAudioRecord,
                                                                        r'''$["drink_size"]''',
                                                                      ).toString()),
                                                                      FFAppState()
                                                                          .drinkSizeType,
                                                                      getJsonField(
                                                                        _model
                                                                            .aIAudioRecord,
                                                                        r'''$["drink_abv"]''',
                                                                      ),
                                                                      getJsonField(
                                                                        _model
                                                                            .aIAudioRecord,
                                                                        r'''$["drink_count"]''',
                                                                      ),
                                                                      '0.0',
                                                                      getJsonField(
                                                                        _model
                                                                            .aIAudioRecord,
                                                                        r'''$["drink_tab"]''',
                                                                      ).toString(),
                                                                      getJsonField(
                                                                        _model
                                                                            .aIAudioRecord,
                                                                        r'''$["drink_calories"]''',
                                                                      ),
                                                                    );
                                                                    _model.totalMlAudio =
                                                                        await actions
                                                                            .getTotalMl(
                                                                      context,
                                                                    );
                                                                    FFAppState()
                                                                            .drinkSizeType =
                                                                        getJsonField(
                                                                      _model
                                                                          .aIAudioRecord,
                                                                      r'''$["drink_size_type"]''',
                                                                    ).toString();
                                                                    FFAppState()
                                                                            .totalMl =
                                                                        _model
                                                                            .totalMlAudio!;
                                                                    safeSetState(
                                                                        () {});

                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .mic_sharp,
                                                                    color: Color(
                                                                        0xFFFF0000),
                                                                    size: 75.0,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(SizedBox(
                                                      width: MediaQuery.sizeOf(
                                                                      context)
                                                                  .width <
                                                              kBreakpointSmall
                                                          ? 5.0
                                                          : 20.0)),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 10.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 5.0,
                                  child: Container(
                                    height: 83.8,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground
                                        ],
                                        stops: [0.0, 1.0],
                                        begin: AlignmentDirectional(0.0, -1.0),
                                        end: AlignmentDirectional(0, 1.0),
                                      ),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                      ),
                                    ),
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 50.0, 0.0, 0.0),
                                      child: StreamBuilder<
                                          List<DailyDrinkLogRecord>>(
                                        stream: queryDailyDrinkLogRecord(
                                          queryBuilder: (dailyDrinkLogRecord) =>
                                              dailyDrinkLogRecord
                                                  .where(
                                                    'uid',
                                                    isEqualTo:
                                                        currentUserReference,
                                                  )
                                                  .where(
                                                    'dailyRemoved',
                                                    isEqualTo: false,
                                                  ),
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
                                          List<DailyDrinkLogRecord>
                                              textDailyDrinkLogRecordList =
                                              snapshot.data!;

                                          return Text(
                                            'Sober Streak: ${functions.soberStreakDays(textDailyDrinkLogRecordList.toList()).toString()}${functions.soberStreakDays(textDailyDrinkLogRecordList.toList()).toString() == '1' ? ' day' : ' days'}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font:
                                                      GoogleFonts.merriweather(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ).animateOnActionTrigger(
                                            animationsMap[
                                                'textOnActionTriggerAnimation']!,
                                            effects: [
                                              TiltEffect(
                                                curve: Curves.easeInOut,
                                                delay: 0.0.ms,
                                                duration: 1000.0.ms,
                                                begin: Offset(
                                                    () {
                                                          if (FFAppState()
                                                                  .currentBAC <=
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
                                                          if (FFAppState()
                                                                  .currentBAC <=
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
                                                          if (FFAppState()
                                                                  .currentBAC <=
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
                                                          if (FFAppState()
                                                                  .currentBAC <=
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
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 25.0, 0.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: () {
                                        if (MediaQuery.sizeOf(context).width <
                                            kBreakpointSmall) {
                                          return 500.0;
                                        } else if (MediaQuery.sizeOf(context)
                                                .width <
                                            kBreakpointMedium) {
                                          return 600.0;
                                        } else if (MediaQuery.sizeOf(context)
                                                .width <
                                            kBreakpointLarge) {
                                          return 680.0;
                                        } else if (MediaQuery.sizeOf(context)
                                                .width <
                                            900.0) {
                                          return 825.0;
                                        } else if (MediaQuery.sizeOf(context)
                                                .width <
                                            1200.0) {
                                          return 825.0;
                                        } else {
                                          return 525.0;
                                        }
                                      }(),
                                      decoration: BoxDecoration(),
                                      child:
                                          StreamBuilder<List<DrinkTabsRecord>>(
                                        stream: queryDrinkTabsRecord(
                                          queryBuilder: (drinkTabsRecord) =>
                                              drinkTabsRecord
                                                  .where(
                                                    'ownerUid',
                                                    isEqualTo:
                                                        currentUserReference
                                                            ?.id,
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
                                          List<DrinkTabsRecord>
                                              listViewDrinkTabsRecordList =
                                              snapshot.data!;

                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                listViewDrinkTabsRecordList
                                                    .length,
                                            itemBuilder:
                                                (context, listViewIndex) {
                                              final listViewDrinkTabsRecord =
                                                  listViewDrinkTabsRecordList[
                                                      listViewIndex];
                                              return DrinkTabWidget(
                                                key: Key(
                                                    'Keyb0k_${listViewIndex}_of_${listViewDrinkTabsRecordList.length}'),
                                                tab: listViewDrinkTabsRecord,
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 1.01),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 95.8,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFB6BEFF),
                                        Color(0x79DF13BA),
                                        Color(0x3CFBC02D)
                                      ],
                                      stops: [0.0, 0.5, 1.0],
                                      begin: AlignmentDirectional(1.0, -1.0),
                                      end: AlignmentDirectional(-1.0, 1.0),
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            ArchivedTabsWidget.routeName,
                                            extra: <String, dynamic>{
                                              '__transition_info__':
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType
                                                        .rightToLeft,
                                              ),
                                            },
                                          );
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 5.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                          child: Container(
                                            width: 80.0,
                                            height: 80.0,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  FlutterFlowTheme.of(context)
                                                      .customColor2,
                                                  FlutterFlowTheme.of(context)
                                                      .customColor3
                                                ],
                                                stops: [0.0, 1.0],
                                                begin: AlignmentDirectional(
                                                    0.0, -1.0),
                                                end: AlignmentDirectional(
                                                    0, 1.0),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: FaIcon(
                                              FontAwesomeIcons.archive,
                                              color: Colors.black,
                                              size: 65.0,
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
                                              return GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child: CreateTabWidget(),
                                                ),
                                              );
                                            },
                                          ).then(
                                              (value) => safeSetState(() {}));
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 5.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                          child: Container(
                                            width: 80.0,
                                            height: 80.0,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  FlutterFlowTheme.of(context)
                                                      .customColor2,
                                                  FlutterFlowTheme.of(context)
                                                      .customColor3
                                                ],
                                                stops: [0.0, 1.0],
                                                begin: AlignmentDirectional(
                                                    0.0, -1.0),
                                                end: AlignmentDirectional(
                                                    0, 1.0),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.black,
                                              size: 80.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                      child: smooth_page_indicator.SmoothPageIndicator(
                        controller: _model.pageViewController ??=
                            PageController(initialPage: 0),
                        count: 2,
                        axisDirection: Axis.horizontal,
                        onDotClicked: (i) async {
                          await _model.pageViewController!.animateToPage(
                            i,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                          safeSetState(() {});
                        },
                        effect: smooth_page_indicator.SlideEffect(
                          spacing: 8.0,
                          radius: 8.0,
                          dotWidth: 8.0,
                          dotHeight: 8.0,
                          dotColor: FlutterFlowTheme.of(context).info,
                          activeDotColor: FlutterFlowTheme.of(context).accent4,
                          paintStyle: PaintingStyle.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
