import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/drink_history_components/drink_history_months/drink_history_months_widget.dart';
import '/drink_history_components/drink_history_years/drink_history_years_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'drink_history_model.dart';
export 'drink_history_model.dart';

class DrinkHistoryWidget extends StatefulWidget {
  const DrinkHistoryWidget({super.key});

  static String routeName = 'drinkHistory';
  static String routePath = '/drinkHistory';

  @override
  State<DrinkHistoryWidget> createState() => _DrinkHistoryWidgetState();
}

class _DrinkHistoryWidgetState extends State<DrinkHistoryWidget>
    with TickerProviderStateMixin {
  late DrinkHistoryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrinkHistoryModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          children: [
            Align(
              alignment: Alignment(0.0, 0),
              child: TabBar(
                labelColor: FlutterFlowTheme.of(context).info,
                unselectedLabelColor: FlutterFlowTheme.of(context).customColor2,
                labelPadding:
                    EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                labelStyle: FlutterFlowTheme.of(context).titleMedium.override(
                      font: GoogleFonts.merriweather(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleMedium.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).titleMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleMedium.fontStyle,
                    ),
                unselectedLabelStyle: FlutterFlowTheme.of(context)
                    .titleMedium
                    .override(
                      font: GoogleFonts.merriweather(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleMedium.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).titleMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleMedium.fontStyle,
                    ),
                indicatorColor: FlutterFlowTheme.of(context).alternate,
                tabs: [
                  Tab(
                    text: 'Months',
                  ),
                  Tab(
                    text: 'Years',
                  ),
                ],
                controller: _model.tabBarController,
                onTap: (i) async {
                  [() async {}, () async {}][i]();
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _model.tabBarController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        StreamBuilder<List<MonthlyDrinkLogRecord>>(
                          stream: queryMonthlyDrinkLogRecord(
                            queryBuilder: (monthlyDrinkLogRecord) =>
                                monthlyDrinkLogRecord.where(
                              'uid',
                              isEqualTo: currentUserReference?.id,
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
                            List<MonthlyDrinkLogRecord>
                                listViewMonthlyDrinkLogRecordList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewMonthlyDrinkLogRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewMonthlyDrinkLogRecord =
                                    listViewMonthlyDrinkLogRecordList[
                                        listViewIndex];
                                return Container(
                                  height: 92.4,
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 25.0, 0.0, 0.0),
                                    child: DrinkHistoryMonthsWidget(
                                      key: Key(
                                          'Key0sg_${listViewIndex}_of_${listViewMonthlyDrinkLogRecordList.length}'),
                                      dailyMonthLogs:
                                          listViewMonthlyDrinkLogRecord,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        StreamBuilder<List<YearlyDrinkLogRecord>>(
                          stream: queryYearlyDrinkLogRecord(
                            queryBuilder: (yearlyDrinkLogRecord) =>
                                yearlyDrinkLogRecord.where(
                              'uid',
                              isEqualTo: currentUserReference?.id,
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
                            List<YearlyDrinkLogRecord>
                                listViewYearlyDrinkLogRecordList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewYearlyDrinkLogRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewYearlyDrinkLogRecord =
                                    listViewYearlyDrinkLogRecordList[
                                        listViewIndex];
                                return Container(
                                  height: 97.71,
                                  child: DrinkHistoryYearsWidget(
                                    key: Key(
                                        'Keywof_${listViewIndex}_of_${listViewYearlyDrinkLogRecordList.length}'),
                                    yearlyDrinkLog:
                                        listViewYearlyDrinkLogRecord,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
