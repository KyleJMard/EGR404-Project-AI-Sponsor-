import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'volume_progress_meter_model.dart';
export 'volume_progress_meter_model.dart';

class VolumeProgressMeterWidget extends StatefulWidget {
  const VolumeProgressMeterWidget({super.key});

  @override
  State<VolumeProgressMeterWidget> createState() =>
      _VolumeProgressMeterWidgetState();
}

class _VolumeProgressMeterWidgetState extends State<VolumeProgressMeterWidget> {
  late VolumeProgressMeterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VolumeProgressMeterModel());

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
      child: Container(
        width: 390.8,
        height: 578.92,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(0.0, -0.4),
              child: Transform.rotate(
                angle: 270.0 * (math.pi / 180),
                child: AuthUserStreamWidget(
                  builder: (context) => LinearPercentIndicator(
                    percent: () {
                      if (FFAppState().limitType == 'dollars') {
                        return functions.progressRatio(
                            FFAppState().totalCost,
                            valueOrDefault(
                                currentUserDocument?.volumeLimit, ''));
                      } else if (FFAppState().limitType == 'calories') {
                        return functions.progressRatio(
                            FFAppState().totalCalories.toDouble(),
                            valueOrDefault(
                                currentUserDocument?.volumeLimit, ''));
                      } else {
                        return functions.progressRatio(
                            FFAppState().totalMl,
                            valueOrDefault(
                                currentUserDocument?.volumeLimit, ''));
                      }
                    }(),
                    width: 200.0,
                    lineHeight: 150.0,
                    animation: true,
                    animateFromLastPercent: true,
                    progressColor: Color(0xFFB75B00),
                    backgroundColor: FlutterFlowTheme.of(context).accent4,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Container(
                width: 283.93,
                height: 283.93,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: Image.asset(
                      Theme.of(context).brightness == Brightness.dark
                          ? 'assets/images/WMGq001_(4).png'
                          : 'assets/images/WMGq001_(5).png',
                    ).image,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.transparent,
                    width: 8.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
