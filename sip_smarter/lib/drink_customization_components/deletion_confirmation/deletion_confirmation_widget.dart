import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'deletion_confirmation_model.dart';
export 'deletion_confirmation_model.dart';

class DeletionConfirmationWidget extends StatefulWidget {
  const DeletionConfirmationWidget({super.key});

  @override
  State<DeletionConfirmationWidget> createState() =>
      _DeletionConfirmationWidgetState();
}

class _DeletionConfirmationWidgetState
    extends State<DeletionConfirmationWidget> {
  late DeletionConfirmationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeletionConfirmationModel());

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
        width: 229.5,
        height: 195.52,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Are you sure you would like to delete your drink history (including progress)?',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.merriweather(
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).info,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 55.0,
                  height: 55.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).accent3,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await actions.deleteAllDrinkTotalsForUser(
                        context,
                      );
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.check,
                      color: FlutterFlowTheme.of(context).info,
                      size: 35.0,
                    ),
                  ),
                ),
                Container(
                  width: 55.0,
                  height: 55.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF0000),
                    borderRadius: BorderRadius.circular(12.0),
                    shape: BoxShape.rectangle,
                  ),
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.windowClose,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 35.0,
                    ),
                  ),
                ),
              ],
            ),
          ].divide(SizedBox(height: 25.0)),
        ),
      ),
    );
  }
}
