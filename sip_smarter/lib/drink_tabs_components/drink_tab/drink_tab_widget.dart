import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/drink_customization_components/drink/drink_widget.dart';
import '/drink_tabs_components/close_tab_confirmation/close_tab_confirmation_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'drink_tab_model.dart';
export 'drink_tab_model.dart';

class DrinkTabWidget extends StatefulWidget {
  const DrinkTabWidget({
    super.key,
    required this.tab,
  });

  final DrinkTabsRecord? tab;

  @override
  State<DrinkTabWidget> createState() => _DrinkTabWidgetState();
}

class _DrinkTabWidgetState extends State<DrinkTabWidget> {
  late DrinkTabModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrinkTabModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 416.4,
          height: 92.88,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12.0),
          ),
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.tabVisible = !_model.tabVisible;
                            safeSetState(() {});
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                bottomLeft: Radius.circular(12.0),
                              ),
                            ),
                            child: Container(
                              width: 182.9,
                              height: 65.2,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    FlutterFlowTheme.of(context).secondaryText,
                                    FlutterFlowTheme.of(context).customColor3
                                  ],
                                  stops: [0.0, 1.0],
                                  begin: AlignmentDirectional(0.0, -1.0),
                                  end: AlignmentDirectional(0, 1.0),
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  bottomLeft: Radius.circular(12.0),
                                ),
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  widget!.tab?.name,
                                  'tab1',
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.merriweather(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: Colors.black,
                                      fontSize: 25.0,
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
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                            ),
                          ),
                          child: Container(
                            height: 65.2,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  FlutterFlowTheme.of(context).secondaryText,
                                  FlutterFlowTheme.of(context).customColor3
                                ],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(0.0, -1.0),
                                end: AlignmentDirectional(0, 1.0),
                              ),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                              ),
                              shape: BoxShape.rectangle,
                            ),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.tabVisible = !_model.tabVisible;
                                safeSetState(() {});
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color:
                                    FlutterFlowTheme.of(context).customColor1,
                                size: 45.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
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
                                return Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: CloseTabConfirmationWidget(
                                    drinkTab: widget!.tab!,
                                  ),
                                );
                              },
                            ).then((value) => safeSetState(() {}));
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Container(
                              width: 100.0,
                              height: 65.2,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    color: Color(0x33000000),
                                    offset: Offset(
                                      0.0,
                                      2.0,
                                    ),
                                    spreadRadius: 5.0,
                                  )
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    FlutterFlowTheme.of(context).customColor2,
                                    FlutterFlowTheme.of(context).customColor5
                                  ],
                                  stops: [0.0, 1.0],
                                  begin: AlignmentDirectional(0.0, -1.0),
                                  end: AlignmentDirectional(0, 1.0),
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                'Close Tab',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.merriweather(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ].addToStart(SizedBox(height: 25.0)),
          ),
        ),
        Container(
          width: 411.03,
          decoration: BoxDecoration(),
          child: Visibility(
            visible: _model.tabVisible,
            child: StreamBuilder<List<DrinkTotalsRecord>>(
              stream: queryDrinkTotalsRecord(
                queryBuilder: (drinkTotalsRecord) => drinkTotalsRecord
                    .where(
                      'ownerUid',
                      isEqualTo: currentUserReference?.id,
                    )
                    .where(
                      'tabName',
                      isEqualTo: widget!.tab?.name,
                    )
                    .where(
                      'removed',
                      isEqualTo: false,
                    )
                    .where(
                      'lastAddedAt',
                      isGreaterThanOrEqualTo: functions.fourteenHoursAgo(),
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
                          'Keyocr_${listViewIndex}_of_${listViewDrinkTotalsRecordList.length}'),
                      drinksTotalsDoc: listViewDrinkTotalsRecord,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
