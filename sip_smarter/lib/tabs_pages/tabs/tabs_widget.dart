import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/drink_tabs_components/create_tab/create_tab_widget.dart';
import '/drink_tabs_components/drink_tab/drink_tab_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'tabs_model.dart';
export 'tabs_model.dart';

class TabsWidget extends StatefulWidget {
  const TabsWidget({super.key});

  static String routeName = 'Tabs';
  static String routePath = '/tabs';

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
  late TabsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TabsModel());

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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset(
                Theme.of(context).brightness == Brightness.dark
                    ? 'assets/images/ChatGPT_Image_Dec_25,_2025,_02_59_55_AM.png'
                    : 'assets/images/ChatGPT_Image_Dec_25,_2025,_02_57_37_AM.png',
              ).image,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).width <
                                  kBreakpointSmall
                              ? 500.0
                              : 700.0,
                          decoration: BoxDecoration(),
                          child: StreamBuilder<List<DrinkTabsRecord>>(
                            stream: queryDrinkTabsRecord(
                              queryBuilder: (drinkTabsRecord) => drinkTabsRecord
                                  .where(
                                    'ownerUid',
                                    isEqualTo: currentUserReference?.id,
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
                                  listViewDrinkTabsRecordList = snapshot.data!;

                              return ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: listViewDrinkTabsRecordList.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 5.0),
                                itemBuilder: (context, listViewIndex) {
                                  final listViewDrinkTabsRecord =
                                      listViewDrinkTabsRecordList[
                                          listViewIndex];
                                  return DrinkTabWidget(
                                    key: Key(
                                        'Keykfl_${listViewIndex}_of_${listViewDrinkTabsRecordList.length}'),
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
                Container(
                  width: double.infinity,
                  height: 95.79,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              '__transition_info__': TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.rightToLeft,
                              ),
                            },
                          );
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          child: Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  FlutterFlowTheme.of(context).customColor2,
                                  FlutterFlowTheme.of(context).customColor3
                                ],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(0.0, -1.0),
                                end: AlignmentDirectional(0, 1.0),
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            alignment: AlignmentDirectional(0.0, 0.0),
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
                          context.pushNamed(
                            HomeWidget.routeName,
                            extra: <String, dynamic>{
                              '__transition_info__': TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.bottomToTop,
                              ),
                            },
                          );
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          child: Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  FlutterFlowTheme.of(context).customColor2,
                                  FlutterFlowTheme.of(context).customColor3
                                ],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(0.0, -1.0),
                                end: AlignmentDirectional(0, 1.0),
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Icon(
                              Icons.home,
                              color: Colors.black,
                              size: 80.0,
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
                                  FocusScope.of(context).unfocus();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: CreateTabWidget(),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          child: Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  FlutterFlowTheme.of(context).customColor2,
                                  FlutterFlowTheme.of(context).customColor3
                                ],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(0.0, -1.0),
                                end: AlignmentDirectional(0, 1.0),
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            alignment: AlignmentDirectional(0.0, 0.0),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
