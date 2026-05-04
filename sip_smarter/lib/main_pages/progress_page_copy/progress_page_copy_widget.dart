import '/auth/firebase_auth/auth_util.dart';
import '/backend/ai_agents/ai_agent.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'progress_page_copy_model.dart';
export 'progress_page_copy_model.dart';

class ProgressPageCopyWidget extends StatefulWidget {
  const ProgressPageCopyWidget({
    super.key,
    this.weekStart,
  });

  final DateTime? weekStart;

  static String routeName = 'ProgressPageCopy';
  static String routePath = '/ProgressCopy';

  @override
  State<ProgressPageCopyWidget> createState() => _ProgressPageCopyWidgetState();
}

class _ProgressPageCopyWidgetState extends State<ProgressPageCopyWidget>
    with TickerProviderStateMixin {
  late ProgressPageCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProgressPageCopyModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.currentWeekStart = functions.startOfWeek(getCurrentTimestamp);
      _model.currentMonthStart = functions.startOfMonth(getCurrentTimestamp);
      _model.currentYearStart = functions.startOfYear(getCurrentTimestamp);
      safeSetState(() {});
      await callAiAgent(
        context: context,
        prompt: functions.weeklyTotalMl(_model.dailyLogs.toList()).toString(),
        threadId: currentUserUid,
        agentCloudFunctionName: 'whatThatMuchCanFill',
        provider: 'GOOGLE',
        agentJson:
            '{\"status\":\"LIVE\",\"identifier\":{\"name\":\"whatThatMuchCanFill\",\"key\":\"mdybh\"},\"name\":\"WhatThatMuchCanFill\",\"description\":\"Takes an amount in mL and describes what that amount could possibly fill in terms of an object\'s volume.\",\"aiModel\":{\"provider\":\"GOOGLE\",\"model\":\"gemini-2.0-flash\",\"parameters\":{\"temperature\":{\"inputValue\":1},\"maxTokens\":{\"inputValue\":8192},\"topP\":{\"inputValue\":0.95}},\"messages\":[{\"role\":\"SYSTEM\",\"text\":\"You are given a quantity in milliliters and you take this quantity and return a short statement about what that amount of fluid could fill. For instance, 42 gallons fills a typical bathtub, so convert mL to other units in order to make an estimation of what kind of container might be able to be filled by the amount of fluid consumed. If the container is smaller than a cup, then output \\\"You\'ve consumed less than a cup.\\\" \"}]},\"requestOptions\":{\"requestTypes\":[\"PLAINTEXT\"]},\"responseOptions\":{\"responseType\":\"PLAINTEXT\"}}',
        responseType: 'PLAINTEXT',
      ).then((generatedText) {
        safeSetState(() => _model.whatThatCanFill = generatedText);
      });
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DailyDrinkLogRecord>>(
      stream: queryDailyDrinkLogRecord(
        queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
            .where(
              'uid',
              isEqualTo: currentUserReference,
            )
            .where(
              'dayStart',
              isGreaterThanOrEqualTo: _model.currentWeekStart,
            )
            .where(
              'dayStart',
              isLessThan: functions.nextWeekStart(_model.currentWeekStart!),
            ),
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
        List<DailyDrinkLogRecord> progressPageCopyDailyDrinkLogRecordList =
            snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Stack(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 70.0, 0.0, 0.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment(0.0, 0),
                                      child: TabBar(
                                        labelColor:
                                            FlutterFlowTheme.of(context).info,
                                        unselectedLabelColor:
                                            FlutterFlowTheme.of(context).info,
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              font: GoogleFonts.merriweather(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                              ),
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                            ),
                                        unselectedLabelStyle: FlutterFlowTheme
                                                .of(context)
                                            .titleMedium
                                            .override(
                                              font: GoogleFonts.merriweather(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                            ),
                                        indicatorColor:
                                            FlutterFlowTheme.of(context)
                                                .customColor2,
                                        tabs: [
                                          Tab(
                                            text: 'Weekly',
                                          ),
                                          Tab(
                                            text: 'Monthly',
                                          ),
                                          Tab(
                                            text: 'Yearly',
                                          ),
                                        ],
                                        controller: _model.tabBarController,
                                        onTap: (i) async {
                                          [
                                            () async {},
                                            () async {},
                                            () async {}
                                          ][i]();
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        controller: _model.tabBarController,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(),
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  valueOrDefault<double>(
                                                MediaQuery.sizeOf(context)
                                                            .width <
                                                        kBreakpointSmall
                                                    ? 0.0
                                                    : 16.0,
                                                0.0,
                                              )),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Material(
                                                            color: Colors
                                                                .transparent,
                                                            elevation: 5.0,
                                                            shape:
                                                                const CircleBorder(),
                                                            child: Container(
                                                              width: 50.0,
                                                              height: 50.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: InkWell(
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
                                                                  if (_model
                                                                          .rowIndex >
                                                                      0) {
                                                                    _model.rowIndex =
                                                                        _model.rowIndex +
                                                                            -1;
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.rowIndex =
                                                                        2;
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_back,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  size: 24.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Stack(
                                                            children: [
                                                              if (_model
                                                                      .rowIndex ==
                                                                  0)
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      _model.showUSD =
                                                                          true;
                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      elevation:
                                                                          5.0,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.0,
                                                                        height:
                                                                            70.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).customColor2,
                                                                          borderRadius:
                                                                              BorderRadius.circular(16.0),
                                                                          shape:
                                                                              BoxShape.rectangle,
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).accent4,
                                                                            width:
                                                                                1.0,
                                                                          ),
                                                                        ),
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            FaIcon(
                                                                          FontAwesomeIcons
                                                                              .glassWhiskey,
                                                                          color:
                                                                              Color(0xFFB27D00),
                                                                          size:
                                                                              50.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (_model
                                                                      .rowIndex ==
                                                                  1)
                                                                InkWell(
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
                                                                    _model.showUSD =
                                                                        false;
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        5.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          70.0,
                                                                      height:
                                                                          70.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .customColor2,
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent4,
                                                                          width:
                                                                              2.0,
                                                                        ),
                                                                      ),
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          FaIcon(
                                                                        FontAwesomeIcons
                                                                            .dollarSign,
                                                                        color: Color(
                                                                            0xFFB27D00),
                                                                        size:
                                                                            50.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (_model
                                                                      .rowIndex ==
                                                                  2)
                                                                InkWell(
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
                                                                    _model.showUSD =
                                                                        false;
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        5.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          70.0,
                                                                      height:
                                                                          70.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .customColor2,
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent4,
                                                                          width:
                                                                              2.0,
                                                                        ),
                                                                      ),
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .electric_bolt,
                                                                        color: Color(
                                                                            0xFFB27D00),
                                                                        size:
                                                                            50.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                          Material(
                                                            color: Colors
                                                                .transparent,
                                                            elevation: 5.0,
                                                            shape:
                                                                const CircleBorder(),
                                                            child: Container(
                                                              width: 50.0,
                                                              height: 50.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: InkWell(
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
                                                                  if (_model
                                                                          .rowIndex <
                                                                      2) {
                                                                    _model.rowIndex =
                                                                        _model.rowIndex +
                                                                            1;
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.rowIndex =
                                                                        0;
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_forward,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                                  size: 24.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Stack(
                                                        children: [
                                                          if (_model.rowIndex ==
                                                              0)
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          12.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Container(
                                                                width: 515.8,
                                                                height: 361.6,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          0.0,
                                                                          6.0),
                                                                      child:
                                                                          Text(
                                                                        'Daily Alcohol Intake (mL)',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    StreamBuilder<
                                                                        List<
                                                                            DailyDrinkLogRecord>>(
                                                                      stream:
                                                                          queryDailyDrinkLogRecord(
                                                                        queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                            .where(
                                                                              'uid',
                                                                              isEqualTo: currentUserReference,
                                                                            )
                                                                            .where(
                                                                              'dayStart',
                                                                              isGreaterThanOrEqualTo: _model.currentWeekStart,
                                                                            )
                                                                            .where(
                                                                              'dayStart',
                                                                              isLessThan: functions.nextWeekStart(_model.currentWeekStart!),
                                                                            ),
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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
                                                                            chartDailyDrinkLogRecordList =
                                                                            snapshot.data!;

                                                                        return Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              330.0,
                                                                          child:
                                                                              FlutterFlowBarChart(
                                                                            barData: [
                                                                              FFBarChartData(
                                                                                yData: functions.weeklyTotalsForChart(chartDailyDrinkLogRecordList.toList(), _model.currentWeekStart!),
                                                                                color: FlutterFlowTheme.of(context).customColor2,
                                                                              )
                                                                            ],
                                                                            xLabels:
                                                                                functions.weekDayLabels(_model.currentWeekStart!),
                                                                            barWidth:
                                                                                15.0,
                                                                            barBorderRadius:
                                                                                BorderRadius.circular(24.0),
                                                                            groupSpace:
                                                                                8.0,
                                                                            alignment:
                                                                                BarChartAlignment.spaceAround,
                                                                            chartStylingInfo:
                                                                                ChartStylingInfo(
                                                                              enableTooltip: true,
                                                                              tooltipBackgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                              borderColor: Colors.transparent,
                                                                              borderWidth: 0.0,
                                                                            ),
                                                                            axisBounds:
                                                                                AxisBounds(
                                                                              minY: 0.0,
                                                                            ),
                                                                            xAxisLabelInfo:
                                                                                AxisLabelInfo(
                                                                              showLabels: true,
                                                                              labelTextStyle: TextStyle(
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                              labelInterval: 10.0,
                                                                              reservedSize: 20.0,
                                                                            ),
                                                                            yAxisLabelInfo:
                                                                                AxisLabelInfo(
                                                                              reservedSize: 40.0,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          if (_model.rowIndex ==
                                                              1)
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          12.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Container(
                                                                width: 515.8,
                                                                height: 361.59,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          0.0,
                                                                          6.0),
                                                                      child:
                                                                          Text(
                                                                        'Daily Cost (USD)',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    StreamBuilder<
                                                                        List<
                                                                            DailyDrinkLogRecord>>(
                                                                      stream:
                                                                          queryDailyDrinkLogRecord(
                                                                        queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                            .where(
                                                                              'uid',
                                                                              isEqualTo: currentUserReference,
                                                                            )
                                                                            .where(
                                                                              'dayStart',
                                                                              isGreaterThanOrEqualTo: _model.currentWeekStart,
                                                                            )
                                                                            .where(
                                                                              'dayStart',
                                                                              isLessThan: functions.nextWeekStart(_model.currentWeekStart!),
                                                                            ),
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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
                                                                            chartDailyDrinkLogRecordList =
                                                                            snapshot.data!;

                                                                        return Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              330.1,
                                                                          child:
                                                                              FlutterFlowBarChart(
                                                                            barData: [
                                                                              FFBarChartData(
                                                                                yData: functions.weeklyCostSeries(_model.currentWeekStart!, chartDailyDrinkLogRecordList.toList()),
                                                                                color: FlutterFlowTheme.of(context).customColor2,
                                                                              )
                                                                            ],
                                                                            xLabels:
                                                                                functions.weekDayLabels(_model.currentWeekStart!),
                                                                            barWidth:
                                                                                15.0,
                                                                            barBorderRadius:
                                                                                BorderRadius.circular(24.0),
                                                                            groupSpace:
                                                                                8.0,
                                                                            alignment:
                                                                                BarChartAlignment.spaceAround,
                                                                            chartStylingInfo:
                                                                                ChartStylingInfo(
                                                                              enableTooltip: true,
                                                                              tooltipBackgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                              borderColor: Colors.transparent,
                                                                              borderWidth: 0.0,
                                                                            ),
                                                                            axisBounds:
                                                                                AxisBounds(
                                                                              minY: 0.0,
                                                                            ),
                                                                            xAxisLabelInfo:
                                                                                AxisLabelInfo(
                                                                              showLabels: true,
                                                                              labelTextStyle: TextStyle(
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                              labelInterval: 10.0,
                                                                              reservedSize: 20.0,
                                                                            ),
                                                                            yAxisLabelInfo:
                                                                                AxisLabelInfo(
                                                                              reservedSize: 40.0,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          if (_model.rowIndex ==
                                                              2)
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          12.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Container(
                                                                width: 515.8,
                                                                height: 361.6,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          0.0,
                                                                          6.0),
                                                                      child:
                                                                          Text(
                                                                        'Daily Calories',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    StreamBuilder<
                                                                        List<
                                                                            DailyDrinkLogRecord>>(
                                                                      stream:
                                                                          queryDailyDrinkLogRecord(
                                                                        queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                            .where(
                                                                              'uid',
                                                                              isEqualTo: currentUserReference,
                                                                            )
                                                                            .where(
                                                                              'dayStart',
                                                                              isGreaterThanOrEqualTo: _model.currentWeekStart,
                                                                            )
                                                                            .where(
                                                                              'dayStart',
                                                                              isLessThan: functions.nextWeekStart(_model.currentWeekStart!),
                                                                            ),
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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
                                                                            chartDailyDrinkLogRecordList =
                                                                            snapshot.data!;

                                                                        return Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              330.1,
                                                                          child:
                                                                              FlutterFlowBarChart(
                                                                            barData: [
                                                                              FFBarChartData(
                                                                                yData: functions.weeklyCaloriesForChart(chartDailyDrinkLogRecordList.toList(), _model.currentWeekStart!),
                                                                                color: FlutterFlowTheme.of(context).customColor2,
                                                                              )
                                                                            ],
                                                                            xLabels:
                                                                                functions.weekDayLabels(_model.currentWeekStart!),
                                                                            barWidth:
                                                                                15.0,
                                                                            barBorderRadius:
                                                                                BorderRadius.circular(24.0),
                                                                            groupSpace:
                                                                                8.0,
                                                                            alignment:
                                                                                BarChartAlignment.spaceAround,
                                                                            chartStylingInfo:
                                                                                ChartStylingInfo(
                                                                              enableTooltip: true,
                                                                              tooltipBackgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                              borderColor: Colors.transparent,
                                                                              borderWidth: 0.0,
                                                                            ),
                                                                            axisBounds:
                                                                                AxisBounds(
                                                                              minY: 0.0,
                                                                            ),
                                                                            xAxisLabelInfo:
                                                                                AxisLabelInfo(
                                                                              showLabels: true,
                                                                              labelTextStyle: TextStyle(
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                              labelInterval: 10.0,
                                                                              reservedSize: 20.0,
                                                                            ),
                                                                            yAxisLabelInfo:
                                                                                AxisLabelInfo(
                                                                              reservedSize: 40.0,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Stack(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          children: [
                                                            if (_model
                                                                    .rowIndex ==
                                                                0)
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child:
                                                                    Container(
                                                                  width: 515.8,
                                                                  height: 78.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                  ),
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children:
                                                                          [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Total alcohol consumption this week: ',
                                                                              textAlign: TextAlign.center,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.merriweather(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            StreamBuilder<List<DailyDrinkLogRecord>>(
                                                                              stream: queryDailyDrinkLogRecord(
                                                                                queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                                    .where(
                                                                                      'uid',
                                                                                      isEqualTo: currentUserReference,
                                                                                    )
                                                                                    .where(
                                                                                      'dayStart',
                                                                                      isGreaterThanOrEqualTo: _model.currentWeekStart,
                                                                                    )
                                                                                    .where(
                                                                                      'dayStart',
                                                                                      isLessThan: functions.nextWeekStart(_model.currentWeekStart!),
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
                                                                                List<DailyDrinkLogRecord> weeklyTotalDailyDrinkLogRecordList = snapshot.data!;

                                                                                return Text(
                                                                                  '${functions.weeklyTotalMl(weeklyTotalDailyDrinkLogRecordList.toList()).toString()} mL',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.merriweather(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Sober days this week: ',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.merriweather(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            StreamBuilder<List<DailyDrinkLogRecord>>(
                                                                              stream: queryDailyDrinkLogRecord(
                                                                                queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                                    .where(
                                                                                      'uid',
                                                                                      isEqualTo: currentUserReference,
                                                                                    )
                                                                                    .where(
                                                                                      'dayStart',
                                                                                      isGreaterThanOrEqualTo: _model.currentWeekStart,
                                                                                    )
                                                                                    .where(
                                                                                      'dayStart',
                                                                                      isLessThan: functions.nextWeekStart(_model.currentWeekStart!),
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
                                                                                List<DailyDrinkLogRecord> weeklyTotalDailyDrinkLogRecordList = snapshot.data!;

                                                                                return Text(
                                                                                  functions.soberDaysInPeriod(weeklyTotalDailyDrinkLogRecordList.toList(), _model.currentWeekStart!, functions.weekEnd(_model.currentWeekStart!)).toString(),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.merriweather(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 10.0)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (_model
                                                                    .rowIndex ==
                                                                1)
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child:
                                                                    Container(
                                                                  width: 515.8,
                                                                  height: 78.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                  ),
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children:
                                                                          [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Total cost this week: ',
                                                                              textAlign: TextAlign.center,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.merriweather(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            StreamBuilder<List<DailyDrinkLogRecord>>(
                                                                              stream: queryDailyDrinkLogRecord(
                                                                                queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                                    .where(
                                                                                      'uid',
                                                                                      isEqualTo: currentUserReference,
                                                                                    )
                                                                                    .where(
                                                                                      'dayStart',
                                                                                      isGreaterThanOrEqualTo: _model.currentWeekStart,
                                                                                    )
                                                                                    .where(
                                                                                      'dayStart',
                                                                                      isLessThan: functions.nextWeekStart(_model.currentWeekStart!),
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
                                                                                List<DailyDrinkLogRecord> textDailyDrinkLogRecordList = snapshot.data!;

                                                                                return Text(
                                                                                  functions.weeklyTotalCost(functions.weeklyCostSeries(_model.currentWeekStart!, textDailyDrinkLogRecordList.toList()).toList()).toString(),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.merriweather(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 10.0)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (_model
                                                                    .rowIndex ==
                                                                2)
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child:
                                                                    Container(
                                                                  width: 515.8,
                                                                  height: 78.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                  ),
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children:
                                                                          [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Total calories this week: ',
                                                                              textAlign: TextAlign.center,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.merriweather(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            StreamBuilder<List<DailyDrinkLogRecord>>(
                                                                              stream: queryDailyDrinkLogRecord(
                                                                                queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                                    .where(
                                                                                      'uid',
                                                                                      isEqualTo: currentUserReference,
                                                                                    )
                                                                                    .where(
                                                                                      'dayStart',
                                                                                      isGreaterThanOrEqualTo: _model.currentWeekStart,
                                                                                    )
                                                                                    .where(
                                                                                      'dayStart',
                                                                                      isLessThan: functions.nextWeekStart(_model.currentWeekStart!),
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
                                                                                List<DailyDrinkLogRecord> textDailyDrinkLogRecordList = snapshot.data!;

                                                                                return Text(
                                                                                  functions.weeklyTotalCalories(textDailyDrinkLogRecordList.toList()).toString(),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.merriweather(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 10.0)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 5.0)),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .customColor2,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24.0),
                                                            ),
                                                            child: InkWell(
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
                                                                _model.currentWeekStart =
                                                                    functions.addDays(
                                                                        _model
                                                                            .currentWeekStart!,
                                                                        -7);
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .chevron_left,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 35.0,
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                child: Text(
                                                                  functions
                                                                      .formatWeekLabel(
                                                                          _model
                                                                              .currentWeekStart!),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .poppins(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .customColor2,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24.0),
                                                            ),
                                                            child: InkWell(
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
                                                                _model.currentWeekStart =
                                                                    functions.addDays(
                                                                        _model
                                                                            .currentWeekStart!,
                                                                        7);
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .chevron_right,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 36.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  valueOrDefault<double>(
                                                MediaQuery.sizeOf(context)
                                                            .width <
                                                        kBreakpointSmall
                                                    ? 0.0
                                                    : 16.0,
                                                0.0,
                                              )),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Material(
                                                              color: Colors
                                                                  .transparent,
                                                              elevation: 5.0,
                                                              shape:
                                                                  const CircleBorder(),
                                                              child: Container(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
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
                                                                    if (_model
                                                                            .rowIndex >
                                                                        0) {
                                                                      _model.rowIndex =
                                                                          _model.rowIndex +
                                                                              -1;
                                                                      safeSetState(
                                                                          () {});
                                                                    } else {
                                                                      _model.rowIndex =
                                                                          2;
                                                                      safeSetState(
                                                                          () {});
                                                                    }
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .arrow_back,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    size: 24.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Stack(
                                                              children: [
                                                                if (_model
                                                                        .rowIndex ==
                                                                    0)
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        _model.showUSD =
                                                                            true;
                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        elevation:
                                                                            5.0,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(16.0),
                                                                        ),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              70.0,
                                                                          height:
                                                                              70.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).customColor2,
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.0),
                                                                            shape:
                                                                                BoxShape.rectangle,
                                                                            border:
                                                                                Border.all(
                                                                              color: FlutterFlowTheme.of(context).accent4,
                                                                              width: 1.0,
                                                                            ),
                                                                          ),
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              FaIcon(
                                                                            FontAwesomeIcons.glassWhiskey,
                                                                            color:
                                                                                Color(0xFFB27D00),
                                                                            size:
                                                                                50.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if (_model
                                                                        .rowIndex ==
                                                                    1)
                                                                  InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      _model.showUSD =
                                                                          false;
                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      elevation:
                                                                          5.0,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.0,
                                                                        height:
                                                                            70.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).customColor2,
                                                                          borderRadius:
                                                                              BorderRadius.circular(16.0),
                                                                          shape:
                                                                              BoxShape.rectangle,
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).accent4,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                        ),
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            FaIcon(
                                                                          FontAwesomeIcons
                                                                              .dollarSign,
                                                                          color:
                                                                              Color(0xFFB27D00),
                                                                          size:
                                                                              50.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if (_model
                                                                        .rowIndex ==
                                                                    2)
                                                                  InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      _model.showUSD =
                                                                          false;
                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      elevation:
                                                                          5.0,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.0,
                                                                        height:
                                                                            70.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).customColor2,
                                                                          borderRadius:
                                                                              BorderRadius.circular(16.0),
                                                                          shape:
                                                                              BoxShape.rectangle,
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).accent4,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                        ),
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .electric_bolt,
                                                                          color:
                                                                              Color(0xFFB27D00),
                                                                          size:
                                                                              50.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                            Material(
                                                              color: Colors
                                                                  .transparent,
                                                              elevation: 5.0,
                                                              shape:
                                                                  const CircleBorder(),
                                                              child: Container(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
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
                                                                    if (_model
                                                                            .rowIndex <
                                                                        2) {
                                                                      _model.rowIndex =
                                                                          _model.rowIndex +
                                                                              1;
                                                                      safeSetState(
                                                                          () {});
                                                                    } else {
                                                                      _model.rowIndex =
                                                                          0;
                                                                      safeSetState(
                                                                          () {});
                                                                    }
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .arrow_forward,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    size: 24.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Stack(
                                                        children: [
                                                          if (_model.rowIndex ==
                                                              0)
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 1.0),
                                                              child: Container(
                                                                width: 523.5,
                                                                height: 361.6,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              24.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 4.0,
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        1.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    StreamBuilder<
                                                                        List<
                                                                            DailyDrinkLogRecord>>(
                                                                      stream:
                                                                          queryDailyDrinkLogRecord(
                                                                        queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                            .where(
                                                                              'uid',
                                                                              isEqualTo: currentUserReference,
                                                                            )
                                                                            .where(
                                                                              'dayStart',
                                                                              isLessThan: functions.nextMonthStart(_model.currentMonthStart!),
                                                                            )
                                                                            .where(
                                                                              'dayStart',
                                                                              isGreaterThanOrEqualTo: _model.currentMonthStart,
                                                                            ),
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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
                                                                            chartDailyDrinkLogRecordList =
                                                                            snapshot.data!;

                                                                        return Container(
                                                                          width:
                                                                              353.0,
                                                                          height:
                                                                              330.0,
                                                                          child:
                                                                              FlutterFlowLineChart(
                                                                            data: [
                                                                              FFLineChartData(
                                                                                xData: functions.monthDayLabels(_model.currentMonthStart!),
                                                                                yData: functions.monthDailyMlValues(_model.currentMonthStart!, chartDailyDrinkLogRecordList.toList()),
                                                                                settings: LineChartBarData(
                                                                                  color: FlutterFlowTheme.of(context).customColor2,
                                                                                  barWidth: 4.0,
                                                                                  dotData: FlDotData(show: false),
                                                                                ),
                                                                              )
                                                                            ],
                                                                            chartStylingInfo:
                                                                                ChartStylingInfo(
                                                                              enableTooltip: true,
                                                                              tooltipBackgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                              showBorder: false,
                                                                            ),
                                                                            axisBounds:
                                                                                AxisBounds(),
                                                                            xAxisLabelInfo:
                                                                                AxisLabelInfo(
                                                                              title: 'Days',
                                                                              titleTextStyle: TextStyle(
                                                                                fontSize: 14.0,
                                                                              ),
                                                                              reservedSize: 32.0,
                                                                            ),
                                                                            yAxisLabelInfo:
                                                                                AxisLabelInfo(
                                                                              title: 'mL',
                                                                              titleTextStyle: TextStyle(
                                                                                fontSize: 14.0,
                                                                              ),
                                                                              reservedSize: 40.0,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          if (_model.rowIndex ==
                                                              1)
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 1.0),
                                                              child: Container(
                                                                width: 523.5,
                                                                height: 361.6,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              24.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 4.0,
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        1.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    StreamBuilder<
                                                                        List<
                                                                            DailyDrinkLogRecord>>(
                                                                      stream:
                                                                          queryDailyDrinkLogRecord(
                                                                        queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                            .where(
                                                                              'uid',
                                                                              isEqualTo: currentUserReference,
                                                                            )
                                                                            .where(
                                                                              'dayStart',
                                                                              isLessThan: functions.nextMonthStart(_model.currentMonthStart!),
                                                                            )
                                                                            .where(
                                                                              'dayStart',
                                                                              isGreaterThanOrEqualTo: _model.currentMonthStart,
                                                                            ),
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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
                                                                            chartDailyDrinkLogRecordList =
                                                                            snapshot.data!;

                                                                        return Container(
                                                                          width:
                                                                              353.0,
                                                                          height:
                                                                              330.0,
                                                                          child:
                                                                              FlutterFlowLineChart(
                                                                            data: [
                                                                              FFLineChartData(
                                                                                xData: functions.monthlyDayXAxis(_model.currentMonthStart!),
                                                                                yData: functions.monthlyCostSeries(_model.currentMonthStart!, chartDailyDrinkLogRecordList.toList()),
                                                                                settings: LineChartBarData(
                                                                                  color: FlutterFlowTheme.of(context).customColor2,
                                                                                  barWidth: 4.0,
                                                                                  dotData: FlDotData(show: false),
                                                                                ),
                                                                              )
                                                                            ],
                                                                            chartStylingInfo:
                                                                                ChartStylingInfo(
                                                                              enableTooltip: true,
                                                                              tooltipBackgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                              showBorder: false,
                                                                            ),
                                                                            axisBounds:
                                                                                AxisBounds(),
                                                                            xAxisLabelInfo:
                                                                                AxisLabelInfo(
                                                                              title: 'Days',
                                                                              titleTextStyle: TextStyle(
                                                                                fontSize: 14.0,
                                                                              ),
                                                                              reservedSize: 32.0,
                                                                            ),
                                                                            yAxisLabelInfo:
                                                                                AxisLabelInfo(
                                                                              title: '\$USD',
                                                                              titleTextStyle: TextStyle(
                                                                                fontSize: 14.0,
                                                                              ),
                                                                              reservedSize: 40.0,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          if (_model.rowIndex ==
                                                              2)
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 1.0),
                                                              child: Container(
                                                                width: 523.5,
                                                                height: 361.6,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              24.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 4.0,
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        1.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    StreamBuilder<
                                                                        List<
                                                                            DailyDrinkLogRecord>>(
                                                                      stream:
                                                                          queryDailyDrinkLogRecord(
                                                                        queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                            .where(
                                                                              'uid',
                                                                              isEqualTo: currentUserReference,
                                                                            )
                                                                            .where(
                                                                              'dayStart',
                                                                              isLessThan: functions.nextMonthStart(_model.currentMonthStart!),
                                                                            )
                                                                            .where(
                                                                              'dayStart',
                                                                              isGreaterThanOrEqualTo: _model.currentMonthStart,
                                                                            ),
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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
                                                                            chartDailyDrinkLogRecordList =
                                                                            snapshot.data!;

                                                                        return Container(
                                                                          width:
                                                                              353.0,
                                                                          height:
                                                                              330.0,
                                                                          child:
                                                                              FlutterFlowLineChart(
                                                                            data: [
                                                                              FFLineChartData(
                                                                                xData: functions.monthlyDayXAxis(_model.currentMonthStart!),
                                                                                yData: functions.monthlyCaloriesSeries(_model.currentMonthStart!, chartDailyDrinkLogRecordList.toList()),
                                                                                settings: LineChartBarData(
                                                                                  color: FlutterFlowTheme.of(context).customColor2,
                                                                                  barWidth: 4.0,
                                                                                  dotData: FlDotData(show: false),
                                                                                ),
                                                                              )
                                                                            ],
                                                                            chartStylingInfo:
                                                                                ChartStylingInfo(
                                                                              enableTooltip: true,
                                                                              tooltipBackgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                              showBorder: false,
                                                                            ),
                                                                            axisBounds:
                                                                                AxisBounds(),
                                                                            xAxisLabelInfo:
                                                                                AxisLabelInfo(
                                                                              title: 'Days',
                                                                              titleTextStyle: TextStyle(
                                                                                fontSize: 14.0,
                                                                              ),
                                                                              reservedSize: 32.0,
                                                                            ),
                                                                            yAxisLabelInfo:
                                                                                AxisLabelInfo(
                                                                              title: 'Calories',
                                                                              titleTextStyle: TextStyle(
                                                                                fontSize: 14.0,
                                                                              ),
                                                                              reservedSize: 40.0,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      Stack(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        children: [
                                                          if (_model.rowIndex ==
                                                              0)
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 1.0),
                                                              child: Container(
                                                                width: 523.5,
                                                                height: 72.7,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            'Total consumption this month: ',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.merriweather(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                          StreamBuilder<
                                                                              List<DailyDrinkLogRecord>>(
                                                                            stream:
                                                                                queryDailyDrinkLogRecord(
                                                                              queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                                  .where(
                                                                                    'uid',
                                                                                    isEqualTo: currentUserReference,
                                                                                  )
                                                                                  .where(
                                                                                    'dayStart',
                                                                                    isGreaterThanOrEqualTo: _model.currentWeekStart,
                                                                                  )
                                                                                  .where(
                                                                                    'dayStart',
                                                                                    isLessThan: functions.nextWeekStart(_model.currentWeekStart!),
                                                                                  ),
                                                                            ),
                                                                            builder:
                                                                                (context, snapshot) {
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
                                                                              List<DailyDrinkLogRecord> textDailyDrinkLogRecordList = snapshot.data!;

                                                                              return Text(
                                                                                functions.monthlyTotalMl(textDailyDrinkLogRecordList.toList(), _model.currentMonthStart!).toString(),
                                                                                textAlign: TextAlign.center,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.merriweather(
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            'Sober days this month: ',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.merriweather(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                          StreamBuilder<
                                                                              List<DailyDrinkLogRecord>>(
                                                                            stream:
                                                                                queryDailyDrinkLogRecord(
                                                                              queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                                  .where(
                                                                                    'uid',
                                                                                    isEqualTo: currentUserReference,
                                                                                  )
                                                                                  .where(
                                                                                    'dayStart',
                                                                                    isGreaterThanOrEqualTo: _model.currentWeekStart,
                                                                                  )
                                                                                  .where(
                                                                                    'dayStart',
                                                                                    isLessThan: functions.nextWeekStart(_model.currentWeekStart!),
                                                                                  ),
                                                                            ),
                                                                            builder:
                                                                                (context, snapshot) {
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
                                                                              List<DailyDrinkLogRecord> textDailyDrinkLogRecordList = snapshot.data!;

                                                                              return Text(
                                                                                functions.soberDaysInPeriod(textDailyDrinkLogRecordList.toList(), _model.currentMonthStart!, functions.monthEnd(_model.currentMonthStart!)).toString(),
                                                                                textAlign: TextAlign.center,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.merriweather(
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            10.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          if (_model.rowIndex ==
                                                              1)
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 1.0),
                                                              child: Container(
                                                                width: 523.5,
                                                                height: 72.7,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            'Total cost this month: ',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.merriweather(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                          StreamBuilder<
                                                                              List<DailyDrinkLogRecord>>(
                                                                            stream:
                                                                                queryDailyDrinkLogRecord(
                                                                              queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                                  .where(
                                                                                    'uid',
                                                                                    isEqualTo: currentUserReference,
                                                                                  )
                                                                                  .where(
                                                                                    'dayStart',
                                                                                    isGreaterThanOrEqualTo: _model.currentWeekStart,
                                                                                  )
                                                                                  .where(
                                                                                    'dayStart',
                                                                                    isLessThan: functions.nextWeekStart(_model.currentWeekStart!),
                                                                                  ),
                                                                            ),
                                                                            builder:
                                                                                (context, snapshot) {
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
                                                                              List<DailyDrinkLogRecord> textDailyDrinkLogRecordList = snapshot.data!;

                                                                              return Text(
                                                                                functions.monthlyTotalCost(textDailyDrinkLogRecordList.toList(), _model.currentMonthStart!).toString(),
                                                                                textAlign: TextAlign.center,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.merriweather(
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            10.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          if (_model.rowIndex ==
                                                              2)
                                                            Container(
                                                              width: 523.5,
                                                              height: 72.7,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0.0),
                                                                border:
                                                                    Border.all(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                  width: 2.0,
                                                                ),
                                                              ),
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Total calories this month: ',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.merriweather(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                        StreamBuilder<
                                                                            List<DailyDrinkLogRecord>>(
                                                                          stream:
                                                                              queryDailyDrinkLogRecord(
                                                                            queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                                .where(
                                                                                  'uid',
                                                                                  isEqualTo: currentUserReference,
                                                                                )
                                                                                .where(
                                                                                  'dayStart',
                                                                                  isGreaterThanOrEqualTo: _model.currentWeekStart,
                                                                                )
                                                                                .where(
                                                                                  'dayStart',
                                                                                  isLessThan: functions.nextWeekStart(_model.currentWeekStart!),
                                                                                ),
                                                                          ),
                                                                          builder:
                                                                              (context, snapshot) {
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
                                                                              functions.monthlyTotalCalories(textDailyDrinkLogRecordList.toList(), _model.currentMonthStart!).toString(),
                                                                              textAlign: TextAlign.center,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.merriweather(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          10.0)),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ].divide(SizedBox(
                                                        height: MediaQuery.sizeOf(
                                                                        context)
                                                                    .width <
                                                                kBreakpointSmall
                                                            ? 0.0
                                                            : 10.0)),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .customColor2,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24.0),
                                                            ),
                                                            child: InkWell(
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
                                                                _model.currentMonthStart =
                                                                    functions.prevMonthStart(
                                                                        _model
                                                                            .currentMonthStart!);
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .chevron_left,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 35.0,
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                child: Text(
                                                                  functions
                                                                      .formatMonthYear(
                                                                          _model
                                                                              .currentMonthStart!),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .poppins(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .customColor2,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24.0),
                                                            ),
                                                            child: InkWell(
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
                                                                _model.currentMonthStart =
                                                                    functions.nextMonthStart(
                                                                        _model
                                                                            .currentMonthStart!);
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .chevron_right,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 35.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  valueOrDefault<double>(
                                                MediaQuery.sizeOf(context)
                                                            .width <
                                                        kBreakpointSmall
                                                    ? 0.0
                                                    : 16.0,
                                                0.0,
                                              )),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Material(
                                                                color: Colors
                                                                    .transparent,
                                                                elevation: 5.0,
                                                                shape:
                                                                    const CircleBorder(),
                                                                child:
                                                                    Container(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child:
                                                                      InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      if (_model
                                                                              .rowIndex >
                                                                          0) {
                                                                        _model.rowIndex =
                                                                            _model.rowIndex +
                                                                                -1;
                                                                        safeSetState(
                                                                            () {});
                                                                      } else {
                                                                        _model.rowIndex =
                                                                            2;
                                                                        safeSetState(
                                                                            () {});
                                                                      }
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .arrow_back,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Stack(
                                                                children: [
                                                                  if (_model
                                                                          .rowIndex ==
                                                                      0)
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          _model.showUSD =
                                                                              true;
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        child:
                                                                            Material(
                                                                          color:
                                                                              Colors.transparent,
                                                                          elevation:
                                                                              5.0,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.0),
                                                                          ),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                70.0,
                                                                            height:
                                                                                70.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).customColor2,
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                              shape: BoxShape.rectangle,
                                                                              border: Border.all(
                                                                                color: FlutterFlowTheme.of(context).accent4,
                                                                                width: 1.0,
                                                                              ),
                                                                            ),
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                FaIcon(
                                                                              FontAwesomeIcons.glassWhiskey,
                                                                              color: Color(0xFFB27D00),
                                                                              size: 50.0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  if (_model
                                                                          .rowIndex ==
                                                                      1)
                                                                    InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        _model.showUSD =
                                                                            false;
                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        elevation:
                                                                            5.0,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(16.0),
                                                                        ),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              70.0,
                                                                          height:
                                                                              70.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).customColor2,
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.0),
                                                                            shape:
                                                                                BoxShape.rectangle,
                                                                            border:
                                                                                Border.all(
                                                                              color: FlutterFlowTheme.of(context).accent4,
                                                                              width: 2.0,
                                                                            ),
                                                                          ),
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              FaIcon(
                                                                            FontAwesomeIcons.dollarSign,
                                                                            color:
                                                                                Color(0xFFB27D00),
                                                                            size:
                                                                                50.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  if (_model
                                                                          .rowIndex ==
                                                                      2)
                                                                    InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        _model.showUSD =
                                                                            false;
                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        elevation:
                                                                            5.0,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(16.0),
                                                                        ),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              70.0,
                                                                          height:
                                                                              70.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).customColor2,
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.0),
                                                                            shape:
                                                                                BoxShape.rectangle,
                                                                            border:
                                                                                Border.all(
                                                                              color: FlutterFlowTheme.of(context).accent4,
                                                                              width: 2.0,
                                                                            ),
                                                                          ),
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.electric_bolt,
                                                                            color:
                                                                                Color(0xFFB27D00),
                                                                            size:
                                                                                50.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                              Material(
                                                                color: Colors
                                                                    .transparent,
                                                                elevation: 5.0,
                                                                shape:
                                                                    const CircleBorder(),
                                                                child:
                                                                    Container(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child:
                                                                      InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      if (_model
                                                                              .rowIndex <
                                                                          2) {
                                                                        _model.rowIndex =
                                                                            _model.rowIndex +
                                                                                1;
                                                                        safeSetState(
                                                                            () {});
                                                                      } else {
                                                                        _model.rowIndex =
                                                                            0;
                                                                        safeSetState(
                                                                            () {});
                                                                      }
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .arrow_forward,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Stack(
                                                          children: [
                                                            if (_model
                                                                    .rowIndex ==
                                                                0)
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        1.0),
                                                                child:
                                                                    Container(
                                                                  width: 523.5,
                                                                  height: 361.6,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            24.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width:
                                                                          4.0,
                                                                    ),
                                                                  ),
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          1.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      StreamBuilder<
                                                                          List<
                                                                              DailyDrinkLogRecord>>(
                                                                        stream:
                                                                            queryDailyDrinkLogRecord(
                                                                          queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                              .where(
                                                                                'uid',
                                                                                isEqualTo: currentUserReference,
                                                                              )
                                                                              .where(
                                                                                'dayStart',
                                                                                isGreaterThanOrEqualTo: _model.currentYearStart,
                                                                              )
                                                                              .where(
                                                                                'dayStart',
                                                                                isLessThan: functions.nextYearStart(_model.currentYearStart!),
                                                                              ),
                                                                        ),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
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
                                                                              chartDailyDrinkLogRecordList =
                                                                              snapshot.data!;

                                                                          return Container(
                                                                            width:
                                                                                353.0,
                                                                            height:
                                                                                330.0,
                                                                            child:
                                                                                FlutterFlowLineChart(
                                                                              data: [
                                                                                FFLineChartData(
                                                                                  xData: functions.yearMonthLabels(),
                                                                                  yData: functions.yearMonthlyMlTotals(_model.currentYearStart!, chartDailyDrinkLogRecordList.toList()),
                                                                                  settings: LineChartBarData(
                                                                                    color: FlutterFlowTheme.of(context).customColor2,
                                                                                    barWidth: 8.0,
                                                                                    dotData: FlDotData(show: false),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                              chartStylingInfo: ChartStylingInfo(
                                                                                enableTooltip: true,
                                                                                tooltipBackgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                showBorder: false,
                                                                              ),
                                                                              axisBounds: AxisBounds(),
                                                                              xAxisLabelInfo: AxisLabelInfo(
                                                                                title: 'Months',
                                                                                titleTextStyle: TextStyle(
                                                                                  fontSize: 14.0,
                                                                                ),
                                                                                reservedSize: 32.0,
                                                                              ),
                                                                              yAxisLabelInfo: AxisLabelInfo(
                                                                                title: 'mL',
                                                                                titleTextStyle: TextStyle(
                                                                                  fontSize: 14.0,
                                                                                ),
                                                                                reservedSize: 40.0,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            if (_model
                                                                    .rowIndex ==
                                                                1)
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        1.0),
                                                                child:
                                                                    Container(
                                                                  width: 523.5,
                                                                  height: 361.6,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            24.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width:
                                                                          4.0,
                                                                    ),
                                                                  ),
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          1.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      StreamBuilder<
                                                                          List<
                                                                              DailyDrinkLogRecord>>(
                                                                        stream:
                                                                            queryDailyDrinkLogRecord(
                                                                          queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                              .where(
                                                                                'uid',
                                                                                isEqualTo: currentUserReference,
                                                                              )
                                                                              .where(
                                                                                'dayStart',
                                                                                isGreaterThanOrEqualTo: _model.currentYearStart,
                                                                              )
                                                                              .where(
                                                                                'dayStart',
                                                                                isLessThan: functions.nextYearStart(_model.currentYearStart!),
                                                                              ),
                                                                        ),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
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
                                                                              chartDailyDrinkLogRecordList =
                                                                              snapshot.data!;

                                                                          return Container(
                                                                            width:
                                                                                353.0,
                                                                            height:
                                                                                330.0,
                                                                            child:
                                                                                FlutterFlowLineChart(
                                                                              data: [
                                                                                FFLineChartData(
                                                                                  xData: functions.yearMonthLabels(),
                                                                                  yData: functions.yearlyCostSeries(_model.currentYearStart!, chartDailyDrinkLogRecordList.toList()),
                                                                                  settings: LineChartBarData(
                                                                                    color: FlutterFlowTheme.of(context).customColor2,
                                                                                    barWidth: 8.0,
                                                                                    dotData: FlDotData(show: false),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                              chartStylingInfo: ChartStylingInfo(
                                                                                enableTooltip: true,
                                                                                tooltipBackgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                showBorder: false,
                                                                              ),
                                                                              axisBounds: AxisBounds(),
                                                                              xAxisLabelInfo: AxisLabelInfo(
                                                                                title: 'Months',
                                                                                titleTextStyle: TextStyle(
                                                                                  fontSize: 14.0,
                                                                                ),
                                                                                reservedSize: 32.0,
                                                                              ),
                                                                              yAxisLabelInfo: AxisLabelInfo(
                                                                                title: '\$USD',
                                                                                titleTextStyle: TextStyle(
                                                                                  fontSize: 14.0,
                                                                                ),
                                                                                reservedSize: 40.0,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            if (_model
                                                                    .rowIndex ==
                                                                2)
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        1.0),
                                                                child:
                                                                    Container(
                                                                  width: 523.5,
                                                                  height: 361.6,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            24.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width:
                                                                          4.0,
                                                                    ),
                                                                  ),
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          1.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      StreamBuilder<
                                                                          List<
                                                                              DailyDrinkLogRecord>>(
                                                                        stream:
                                                                            queryDailyDrinkLogRecord(
                                                                          queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                              .where(
                                                                                'uid',
                                                                                isEqualTo: currentUserReference,
                                                                              )
                                                                              .where(
                                                                                'dayStart',
                                                                                isGreaterThanOrEqualTo: _model.currentYearStart,
                                                                              )
                                                                              .where(
                                                                                'dayStart',
                                                                                isLessThan: functions.nextYearStart(_model.currentYearStart!),
                                                                              ),
                                                                        ),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
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
                                                                              chartDailyDrinkLogRecordList =
                                                                              snapshot.data!;

                                                                          return Container(
                                                                            width:
                                                                                353.0,
                                                                            height:
                                                                                330.0,
                                                                            child:
                                                                                FlutterFlowLineChart(
                                                                              data: [
                                                                                FFLineChartData(
                                                                                  xData: functions.yearMonthLabels(),
                                                                                  yData: functions.yearlyCaloriesSeries(_model.currentYearStart!, chartDailyDrinkLogRecordList.toList()),
                                                                                  settings: LineChartBarData(
                                                                                    color: FlutterFlowTheme.of(context).customColor2,
                                                                                    barWidth: 8.0,
                                                                                    dotData: FlDotData(show: false),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                              chartStylingInfo: ChartStylingInfo(
                                                                                enableTooltip: true,
                                                                                tooltipBackgroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                showBorder: false,
                                                                              ),
                                                                              axisBounds: AxisBounds(),
                                                                              xAxisLabelInfo: AxisLabelInfo(
                                                                                title: 'Months',
                                                                                titleTextStyle: TextStyle(
                                                                                  fontSize: 14.0,
                                                                                ),
                                                                                reservedSize: 32.0,
                                                                              ),
                                                                              yAxisLabelInfo: AxisLabelInfo(
                                                                                title: 'Calories',
                                                                                titleTextStyle: TextStyle(
                                                                                  fontSize: 14.0,
                                                                                ),
                                                                                reservedSize: 40.0,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                        Stack(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          children: [
                                                            if (_model
                                                                    .rowIndex ==
                                                                0)
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        1.0),
                                                                child:
                                                                    Container(
                                                                  width: 523.5,
                                                                  height: 86.8,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                  ),
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children:
                                                                          [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Total consumption this year: ',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.merriweather(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            StreamBuilder<List<DailyDrinkLogRecord>>(
                                                                              stream: queryDailyDrinkLogRecord(
                                                                                queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                                    .where(
                                                                                      'uid',
                                                                                      isEqualTo: currentUserReference,
                                                                                    )
                                                                                    .where(
                                                                                      'dayStart',
                                                                                      isGreaterThanOrEqualTo: _model.currentWeekStart,
                                                                                    )
                                                                                    .where(
                                                                                      'dayStart',
                                                                                      isLessThan: functions.nextWeekStart(_model.currentWeekStart!),
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
                                                                                List<DailyDrinkLogRecord> textDailyDrinkLogRecordList = snapshot.data!;

                                                                                return Text(
                                                                                  functions.yearlyTotalMl(textDailyDrinkLogRecordList.toList(), _model.currentYearStart!).toString(),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.merriweather(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Sober days this year: ',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.merriweather(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            StreamBuilder<List<DailyDrinkLogRecord>>(
                                                                              stream: queryDailyDrinkLogRecord(
                                                                                queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                                    .where(
                                                                                      'uid',
                                                                                      isEqualTo: currentUserReference,
                                                                                    )
                                                                                    .where(
                                                                                      'dayStart',
                                                                                      isGreaterThanOrEqualTo: _model.currentWeekStart,
                                                                                    )
                                                                                    .where(
                                                                                      'dayStart',
                                                                                      isLessThan: functions.nextWeekStart(_model.currentWeekStart!),
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
                                                                                List<DailyDrinkLogRecord> textDailyDrinkLogRecordList = snapshot.data!;

                                                                                return Text(
                                                                                  functions.soberDaysInPeriod(textDailyDrinkLogRecordList.toList(), _model.currentYearStart!, functions.yearEnd(_model.currentYearStart!)).toString(),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.merriweather(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 10.0)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (_model
                                                                    .rowIndex ==
                                                                1)
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        1.0),
                                                                child:
                                                                    Container(
                                                                  width: 523.5,
                                                                  height: 86.8,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                  ),
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children:
                                                                          [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Total Cost This Year: ',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.merriweather(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            StreamBuilder<List<DailyDrinkLogRecord>>(
                                                                              stream: queryDailyDrinkLogRecord(
                                                                                queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                                    .where(
                                                                                      'uid',
                                                                                      isEqualTo: currentUserReference,
                                                                                    )
                                                                                    .where(
                                                                                      'dayStart',
                                                                                      isGreaterThanOrEqualTo: _model.currentWeekStart,
                                                                                    )
                                                                                    .where(
                                                                                      'dayStart',
                                                                                      isLessThan: functions.nextWeekStart(_model.currentWeekStart!),
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
                                                                                List<DailyDrinkLogRecord> textDailyDrinkLogRecordList = snapshot.data!;

                                                                                return Text(
                                                                                  functions.yearlyTotalCost(textDailyDrinkLogRecordList.toList(), _model.currentYearStart!).toString(),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.merriweather(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 10.0)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (_model
                                                                    .rowIndex ==
                                                                2)
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        1.0),
                                                                child:
                                                                    Container(
                                                                  width: 523.5,
                                                                  height: 86.8,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                  ),
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children:
                                                                          [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Total calories this year: ',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.merriweather(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            StreamBuilder<List<DailyDrinkLogRecord>>(
                                                                              stream: queryDailyDrinkLogRecord(
                                                                                queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                                                                                    .where(
                                                                                      'uid',
                                                                                      isEqualTo: currentUserReference,
                                                                                    )
                                                                                    .where(
                                                                                      'dayStart',
                                                                                      isGreaterThanOrEqualTo: _model.currentWeekStart,
                                                                                    )
                                                                                    .where(
                                                                                      'dayStart',
                                                                                      isLessThan: functions.nextWeekStart(_model.currentWeekStart!),
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
                                                                                List<DailyDrinkLogRecord> textDailyDrinkLogRecordList = snapshot.data!;

                                                                                return Text(
                                                                                  functions.yearlyTotalCalories(_model.currentYearStart!, textDailyDrinkLogRecordList.toList()).toString(),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.merriweather(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 10.0)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: MediaQuery.sizeOf(
                                                                          context)
                                                                      .width <
                                                                  kBreakpointSmall
                                                              ? 0.0
                                                              : 10.0)),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .customColor2,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      24.0),
                                                        ),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            _model.currentYearStart =
                                                                functions
                                                                    .prevYearStart(
                                                                        _model
                                                                            .currentYearStart!);
                                                            safeSetState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons.chevron_left,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 35.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5.0,
                                                                        0.0,
                                                                        5.0,
                                                                        0.0),
                                                            child: Text(
                                                              functions
                                                                  .formatYearLabel(
                                                                      _model
                                                                          .currentYearStart!),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .poppins(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .customColor2,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      24.0),
                                                        ),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            _model.currentYearStart =
                                                                functions
                                                                    .nextYearStart(
                                                                        _model
                                                                            .currentYearStart!);
                                                            safeSetState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons.chevron_right,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 35.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
