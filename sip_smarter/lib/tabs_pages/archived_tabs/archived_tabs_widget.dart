import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/drink_tabs_components/drink_tab/drink_tab_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'archived_tabs_model.dart';
export 'archived_tabs_model.dart';

class ArchivedTabsWidget extends StatefulWidget {
  const ArchivedTabsWidget({super.key});

  static String routeName = 'ArchivedTabs';
  static String routePath = '/archivedTabs';

  @override
  State<ArchivedTabsWidget> createState() => _ArchivedTabsWidgetState();
}

class _ArchivedTabsWidgetState extends State<ArchivedTabsWidget> {
  late ArchivedTabsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ArchivedTabsModel());

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
        body: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Container(
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
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Align(
              alignment: AlignmentDirectional(0.0, -1.0),
              child: Padding(
                padding: EdgeInsets.all(valueOrDefault<double>(
                  MediaQuery.sizeOf(context).width < kBreakpointSmall
                      ? 12.0
                      : 24.0,
                  0.0,
                )),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Material(
                          color: Colors.transparent,
                          elevation: 1.0,
                          shape: const CircleBorder(),
                          child: Container(
                            width: 65.0,
                            height: 65.0,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x33000000),
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              gradient: LinearGradient(
                                colors: [Color(0x1BFFFFFF), Color(0x22FF0004)],
                                stops: [0.0, 0.75],
                                begin: AlignmentDirectional(0.94, -1.0),
                                end: AlignmentDirectional(-0.94, 1.0),
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                            child: FlutterFlowIconButton(
                              borderRadius: 8.0,
                              buttonSize: 50.0,
                              icon: Icon(
                                Icons.arrow_back,
                                color:
                                    FlutterFlowTheme.of(context).customColor3,
                                size: 35.0,
                              ),
                              onPressed: () async {
                                context.pushNamed(
                                  HomeWidget.routeName,
                                  extra: <String, dynamic>{
                                    '__transition_info__': TransitionInfo(
                                      hasTransition: true,
                                      transitionType:
                                          PageTransitionType.leftToRight,
                                    ),
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 606.82,
                            decoration: BoxDecoration(),
                            child: StreamBuilder<List<DrinkTabsRecord>>(
                              stream: queryDrinkTabsRecord(
                                queryBuilder: (drinkTabsRecord) =>
                                    drinkTabsRecord
                                        .where(
                                          'ownerUid',
                                          isEqualTo: currentUserReference?.id,
                                        )
                                        .where(
                                          'archived',
                                          isEqualTo: true,
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
                                          'Keyqeq_${listViewIndex}_of_${listViewDrinkTabsRecordList.length}'),
                                      tab: listViewDrinkTabsRecord,
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
          ),
        ),
      ),
    );
  }
}
