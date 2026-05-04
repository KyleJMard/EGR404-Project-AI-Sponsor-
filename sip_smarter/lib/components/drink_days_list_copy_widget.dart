import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/drink_customization_components/drink/drink_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'drink_days_list_copy_model.dart';
export 'drink_days_list_copy_model.dart';

class DrinkDaysListCopyWidget extends StatefulWidget {
  const DrinkDaysListCopyWidget({
    super.key,
    required this.drinks,
    required this.dayKey,
  });

  final List<DrinkTotalsRecord>? drinks;
  final String? dayKey;

  @override
  State<DrinkDaysListCopyWidget> createState() =>
      _DrinkDaysListCopyWidgetState();
}

class _DrinkDaysListCopyWidgetState extends State<DrinkDaysListCopyWidget> {
  late DrinkDaysListCopyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrinkDaysListCopyModel());

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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 35.0, 0.0, 25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: FlutterFlowIconButton(
                        borderRadius: 8.0,
                        buttonSize: 51.67,
                        fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        icon: Icon(
                          Icons.close,
                          color: FlutterFlowTheme.of(context).info,
                          size: 35.0,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                ),
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
                          'dayKey',
                          isEqualTo: widget!.dayKey,
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

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewDrinkTotalsRecordList.length,
                      separatorBuilder: (_, __) => SizedBox(height: 15.0),
                      itemBuilder: (context, listViewIndex) {
                        final listViewDrinkTotalsRecord =
                            listViewDrinkTotalsRecordList[listViewIndex];
                        return DrinkWidget(
                          key: Key(
                              'Keyr05_${listViewIndex}_of_${listViewDrinkTotalsRecordList.length}'),
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
    );
  }
}
