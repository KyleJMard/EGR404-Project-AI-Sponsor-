import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/drink_customization_components/drink/drink_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'drink_days_list_model.dart';
export 'drink_days_list_model.dart';

class DrinkDaysListWidget extends StatefulWidget {
  const DrinkDaysListWidget({
    super.key,
    required this.drinkDay,
  });

  final DailyDrinkLogRecord? drinkDay;

  @override
  State<DrinkDaysListWidget> createState() => _DrinkDaysListWidgetState();
}

class _DrinkDaysListWidgetState extends State<DrinkDaysListWidget> {
  late DrinkDaysListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrinkDaysListModel());

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
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Container(
                  width: 411.0,
                  decoration: BoxDecoration(),
                  child: StreamBuilder<List<DrinkTotalsRecord>>(
                    stream: queryDrinkTotalsRecord(
                      queryBuilder: (drinkTotalsRecord) => drinkTotalsRecord
                          .where(
                            'ownerUid',
                            isEqualTo: currentUserReference?.id,
                          )
                          .where(
                            'removed',
                            isEqualTo: false,
                          )
                          .where(
                            'dayStart',
                            isEqualTo: widget!.drinkDay?.dayStart,
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
                      List<DrinkTotalsRecord> listViewDrinkTotalsRecordList =
                          snapshot.data!;

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewDrinkTotalsRecordList.length,
                        itemBuilder: (context, listViewIndex) {
                          final listViewDrinkTotalsRecord =
                              listViewDrinkTotalsRecordList[listViewIndex];
                          return DrinkWidget(
                            key: Key(
                                'Key7r0_${listViewIndex}_of_${listViewDrinkTotalsRecordList.length}'),
                            drinksTotalsDoc: listViewDrinkTotalsRecord,
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
      ),
    );
  }
}
