import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/progress_bar_and_b_a_c_limit/custom_b_a_c_limit/custom_b_a_c_limit_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bac_monitor_model.dart';
export 'bac_monitor_model.dart';

class BacMonitorWidget extends StatefulWidget {
  const BacMonitorWidget({super.key});

  @override
  State<BacMonitorWidget> createState() => _BacMonitorWidgetState();
}

class _BacMonitorWidgetState extends State<BacMonitorWidget> {
  late BacMonitorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BacMonitorModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.totalGrams6 = await actions.getTotalAlcoholGrams();
      _model.bac = functions.calculateBac(
          _model.totalGrams6!,
          valueOrDefault(currentUserDocument?.weightLbs, 0) > 0
              ? functions
                  .lbsToKg(valueOrDefault(currentUserDocument?.weightLbs, 0))!
              : valueOrDefault(currentUserDocument?.weightKg, 0),
          valueOrDefault(currentUserDocument?.gender, ''),
          functions.elapseSinceFirstDrinkMs(
              valueOrDefault(currentUserDocument?.firstDrinkTimestampMs, 0))!);
      safeSetState(() {});
      _model.bacLabel = functions.bacProgressLabel(_model.bac, '0.000')!;
      safeSetState(() {});
      await Future.wait([
        Future(() async {
          while (FFAppState().currentBAC >= 0.0) {
            _model.totalGrams7 = await actions.getTotalAlcoholGrams();
            _model.bac = functions.calculateBac(
                _model.totalGrams7!,
                valueOrDefault(currentUserDocument?.weightLbs, 0) > 0
                    ? functions.lbsToKg(
                        valueOrDefault(currentUserDocument?.weightLbs, 0))!
                    : valueOrDefault(currentUserDocument?.weightKg, 0),
                valueOrDefault(currentUserDocument?.gender, ''),
                functions.elapseSinceFirstDrinkMs(valueOrDefault(
                    currentUserDocument?.firstDrinkTimestampMs, 0))!);
            safeSetState(() {});
            _model.bacLabel = functions.bacProgressLabel(_model.bac, '0.000')!;
            safeSetState(() {});
            await Future.delayed(
              Duration(
                milliseconds: 1000,
              ),
            );
          }
        }),
      ]);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Stack(
        alignment: AlignmentDirectional(0.0, 0.0),
        children: [
          Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: 340.0,
              height: 600.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: AlignmentDirectional(0.0, 0.0),
                  image: Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/ChatGPT_Image_Dec_29,_2025,_06_24_29_PM.png'
                        : 'assets/images/ChatGPT_Image_Dec_29,_2025,_06_23_37_PM.png',
                  ).image,
                ),
              ),
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Align(
                alignment: AlignmentDirectional(-0.01, 0.12),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                  child: Container(
                    width: 235.2,
                    height: 104.79,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Visibility(
                      visible: _model.vis,
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 0.0, 0.0),
                              child: Text(
                                '0.000',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Segment7',
                                      color: Color(0x3AFF0000),
                                      fontSize: 100.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 0.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  _model.bacLabel,
                                  '0.000',
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Segment7',
                                  color: Color(0xFFFF0000),
                                  fontSize: 100.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  shadows: [
                                    Shadow(
                                      color: Color(0xFFFF0000),
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 5.0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Opacity(
            opacity: 0.0,
            child: Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(120.0, 0.0, 0.0, 345.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    _model.vis = !_model.vis;
                    safeSetState(() {});
                  },
                  child: Container(
                    width: 109.38,
                    height: 109.38,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 325.0, 0.0, 0.0),
              child: AuthUserStreamWidget(
                builder: (context) => Text(
                  'BAC Limit: ${valueOrDefault(currentUserDocument?.bacLimit, '')}',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: Colors.black,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
            ),
          ),
          Opacity(
            opacity: 0.0,
            child: Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 120.0, 345.0),
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
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: CustomBACLimitWidget(),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  },
                  child: Container(
                    width: 109.4,
                    height: 109.4,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
