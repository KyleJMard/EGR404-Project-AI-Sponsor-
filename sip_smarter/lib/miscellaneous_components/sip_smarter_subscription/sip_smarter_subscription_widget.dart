import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/revenue_cat_util.dart' as revenue_cat;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sip_smarter_subscription_model.dart';
export 'sip_smarter_subscription_model.dart';

class SipSmarterSubscriptionWidget extends StatefulWidget {
  const SipSmarterSubscriptionWidget({super.key});

  @override
  State<SipSmarterSubscriptionWidget> createState() =>
      _SipSmarterSubscriptionWidgetState();
}

class _SipSmarterSubscriptionWidgetState
    extends State<SipSmarterSubscriptionWidget> {
  late SipSmarterSubscriptionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SipSmarterSubscriptionModel());

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
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: 227.81,
        height: 371.1,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/ChatGPT_Image_Dec_21,_2025,_10_45_13_PM.png',
                      ).image,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  'SipSmarter ',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.merriweather(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).info,
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ].divide(SizedBox(width: 15.0)),
            ),
            Text(
              'Upgrade to Premium \n \$4.99 semi-annually',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.merriweather(
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).info,
                    fontSize: 20.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Get Unlimited Access',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.merriweather(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).info,
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ],
            ),
            Container(
              width: 159.01,
              decoration: BoxDecoration(),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    var _shouldSetState = false;
                    _model.premium =
                        await revenue_cat.purchasePackage('\$rc_six_month');
                    _shouldSetState = true;
                    if (_model.premium!) {
                      FFAppState().subscribed = true;
                      safeSetState(() {});
                      Navigator.pop(context);
                    } else {
                      if (_shouldSetState) safeSetState(() {});
                      return;
                    }

                    if (_shouldSetState) safeSetState(() {});
                  },
                  text: 'Subscribe',
                  options: FFButtonOptions(
                    width: 65.3,
                    height: 41.1,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).secondaryText,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.merriweather(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).info,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    elevation: 5.0,
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
          ].divide(SizedBox(height: 25.0)),
        ),
      ),
    );
  }
}
