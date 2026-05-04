import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/drink_history_components/drink_history_days/drink_history_days_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'drink_months_list_model.dart';
export 'drink_months_list_model.dart';

class DrinkMonthsListWidget extends StatefulWidget {
  const DrinkMonthsListWidget({
    super.key,
    required this.monthLog,
  });

  final MonthlyDrinkLogRecord? monthLog;

  @override
  State<DrinkMonthsListWidget> createState() => _DrinkMonthsListWidgetState();
}

class _DrinkMonthsListWidgetState extends State<DrinkMonthsListWidget> {
  late DrinkMonthsListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrinkMonthsListModel());

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
      alignment: AlignmentDirectional(0.0, -1.0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 45.0, 0.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 3.0,
                  ),
                ),
                child: StreamBuilder<List<DailyDrinkLogRecord>>(
                  stream: queryDailyDrinkLogRecord(
                    queryBuilder: (dailyDrinkLogRecord) => dailyDrinkLogRecord
                        .where(
                          'uid',
                          isEqualTo: currentUserReference,
                        )
                        .where(
                          'monthKey',
                          isEqualTo: widget!.monthLog?.monthKey,
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
                    List<DailyDrinkLogRecord> listViewDailyDrinkLogRecordList =
                        snapshot.data!;

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewDailyDrinkLogRecordList.length,
                      itemBuilder: (context, listViewIndex) {
                        final listViewDailyDrinkLogRecord =
                            listViewDailyDrinkLogRecordList[listViewIndex];
                        return Container(
                          height: 67.0,
                          decoration: BoxDecoration(),
                          child: DrinkHistoryDaysWidget(
                            key: Key(
                                'Keyy3k_${listViewIndex}_of_${listViewDailyDrinkLogRecordList.length}'),
                            dailyDrinkLogs: listViewDailyDrinkLogRecord,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
