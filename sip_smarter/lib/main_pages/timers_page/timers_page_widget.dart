import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/timer_components/time_since_last_drink/time_since_last_drink_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'timers_page_model.dart';
export 'timers_page_model.dart';

class TimersPageWidget extends StatefulWidget {
  const TimersPageWidget({super.key});

  static String routeName = 'TimersPage';
  static String routePath = '/timersPage';

  @override
  State<TimersPageWidget> createState() => _TimersPageWidgetState();
}

class _TimersPageWidgetState extends State<TimersPageWidget> {
  late TimersPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TimersPageModel());

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
        body: wrapWithModel(
          model: _model.timeSinceLastDrinkModel,
          updateCallback: () => safeSetState(() {}),
          child: TimeSinceLastDrinkWidget(),
        ),
      ),
    );
  }
}
