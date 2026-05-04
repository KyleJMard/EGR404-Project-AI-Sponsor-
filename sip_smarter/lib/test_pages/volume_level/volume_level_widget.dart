import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/progress_bar_and_b_a_c_limit/custom_volume_input/custom_volume_input_widget.dart';
import '/progress_bar_and_b_a_c_limit/volume_progress_meter/volume_progress_meter_widget.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'volume_level_model.dart';
export 'volume_level_model.dart';

class VolumeLevelWidget extends StatefulWidget {
  const VolumeLevelWidget({super.key});

  static String routeName = 'VolumeLevel';
  static String routePath = '/volumeLevel';

  @override
  State<VolumeLevelWidget> createState() => _VolumeLevelWidgetState();
}

class _VolumeLevelWidgetState extends State<VolumeLevelWidget> {
  late VolumeLevelModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VolumeLevelModel());

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
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryText,
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                wrapWithModel(
                  model: _model.volumeProgressMeterModel,
                  updateCallback: () => safeSetState(() {}),
                  child: VolumeProgressMeterWidget(),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your preferred consumption limit:  ',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.merriweatherSans(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).info,
                            fontSize: 15.0,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    AuthUserStreamWidget(
                      builder: (context) => Text(
                        valueOrDefault(currentUserDocument?.volumeLimit, ''),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.merriweatherSans(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).info,
                              fontSize: 20.0,
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
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 10.0,
                    shape: const CircleBorder(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFEEDEDE),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: InkWell(
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
                                  child: CustomVolumeInputWidget(),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        },
                        child: Icon(
                          Icons.settings_sharp,
                          color: Colors.black,
                          size: 85.0,
                        ),
                      ),
                    ),
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
