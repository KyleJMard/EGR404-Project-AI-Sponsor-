import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/drink_history_components/drink_history_months/drink_history_months_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'drink_years_list_model.dart';
export 'drink_years_list_model.dart';

class DrinkYearsListWidget extends StatefulWidget {
  const DrinkYearsListWidget({
    super.key,
    required this.yearsLog,
  });

  final YearlyDrinkLogRecord? yearsLog;

  @override
  State<DrinkYearsListWidget> createState() => _DrinkYearsListWidgetState();
}

class _DrinkYearsListWidgetState extends State<DrinkYearsListWidget> {
  late DrinkYearsListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrinkYearsListModel());

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
                child: StreamBuilder<List<MonthlyDrinkLogRecord>>(
                  stream: queryMonthlyDrinkLogRecord(
                    queryBuilder: (monthlyDrinkLogRecord) =>
                        monthlyDrinkLogRecord
                            .where(
                              'uid',
                              isEqualTo: currentUserReference?.id,
                            )
                            .where(
                              'monthlyRemoved',
                              isEqualTo: false,
                            )
                            .where(
                              'yearKey',
                              isEqualTo: widget!.yearsLog?.yearKey,
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
                        listViewMonthlyDrinkLogRecordList = snapshot.data!;

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewMonthlyDrinkLogRecordList.length,
                      itemBuilder: (context, listViewIndex) {
                        final listViewMonthlyDrinkLogRecord =
                            listViewMonthlyDrinkLogRecordList[listViewIndex];
                        return Container(
                          height: 95.7,
                          decoration: BoxDecoration(),
                          child: DrinkHistoryMonthsWidget(
                            key: Key(
                                'Keyeup_${listViewIndex}_of_${listViewMonthlyDrinkLogRecordList.length}'),
                            dailyMonthLogs: listViewMonthlyDrinkLogRecord,
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
