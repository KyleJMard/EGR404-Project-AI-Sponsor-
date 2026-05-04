import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'image_for_empty_list_model.dart';
export 'image_for_empty_list_model.dart';

class ImageForEmptyListWidget extends StatefulWidget {
  const ImageForEmptyListWidget({super.key});

  @override
  State<ImageForEmptyListWidget> createState() =>
      _ImageForEmptyListWidgetState();
}

class _ImageForEmptyListWidgetState extends State<ImageForEmptyListWidget>
    with TickerProviderStateMixin {
  late ImageForEmptyListModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ImageForEmptyListModel());

    animationsMap.addAll({
      'containerOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: FlutterFlowTheme.of(context).primary,
            angle: 0.524,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

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
      child: Material(
        color: Colors.transparent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Container(
          width: 161.8,
          height: 211.3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                FlutterFlowTheme.of(context).primary,
                FlutterFlowTheme.of(context).secondary
              ],
              stops: [0.0, 1.0],
              begin: AlignmentDirectional(0.0, -1.0),
              end: AlignmentDirectional(0, 1.0),
            ),
            borderRadius: BorderRadius.circular(24.0),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Colors.transparent,
              width: 2.0,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? 'assets/images/ChatGPT_Image_Dec_25,_2025,_02_16_45_AM.png'
                  : 'assets/images/ChatGPT_Image_Dec_25,_2025,_02_45_14_AM.png',
              width: 238.0,
              height: 99.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ).animateOnActionTrigger(
        animationsMap['containerOnActionTriggerAnimation']!,
      ),
    );
  }
}
