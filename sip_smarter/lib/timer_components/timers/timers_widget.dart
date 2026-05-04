import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/timer_components/time_since_last_drink/time_since_last_drink_widget.dart';
import '/timer_components/time_until_sober/time_until_sober_widget.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'timers_model.dart';
export 'timers_model.dart';

class TimersWidget extends StatefulWidget {
  const TimersWidget({super.key});

  @override
  State<TimersWidget> createState() => _TimersWidgetState();
}

class _TimersWidgetState extends State<TimersWidget> {
  late TimersModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TimersModel());

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
        elevation: 15.0,
        shape: const CircleBorder(),
        child: Container(
          width: 396.0,
          height: 396.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 4.0,
                color: Color(0xFFFBC02D),
                offset: Offset(
                  0.0,
                  2.0,
                ),
                spreadRadius: 2.0,
              )
            ],
            gradient: LinearGradient(
              colors: [Color(0xFFB6BEFF), Color(0x79DF13BA), Color(0x3CFBC02D)],
              stops: [0.0, 0.5, 1.0],
              begin: AlignmentDirectional(1.0, -1.0),
              end: AlignmentDirectional(-1.0, 1.0),
            ),
            shape: BoxShape.circle,
          ),
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 200.0,
                decoration: BoxDecoration(),
                child: wrapWithModel(
                  model: _model.timeSinceLastDrinkModel,
                  updateCallback: () => safeSetState(() {}),
                  child: TimeSinceLastDrinkWidget(),
                ),
              ),
              Container(
                width: 200.0,
                decoration: BoxDecoration(),
                child: wrapWithModel(
                  model: _model.timeUntilSoberModel,
                  updateCallback: () => safeSetState(() {}),
                  child: TimeUntilSoberWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
