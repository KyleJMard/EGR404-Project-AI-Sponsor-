import '/backend/backend.dart';
import '/drink_history_components/drink_years_list/drink_years_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'drink_history_years_model.dart';
export 'drink_history_years_model.dart';

class DrinkHistoryYearsWidget extends StatefulWidget {
  const DrinkHistoryYearsWidget({
    super.key,
    required this.yearlyDrinkLog,
  });

  final YearlyDrinkLogRecord? yearlyDrinkLog;

  @override
  State<DrinkHistoryYearsWidget> createState() =>
      _DrinkHistoryYearsWidgetState();
}

class _DrinkHistoryYearsWidgetState extends State<DrinkHistoryYearsWidget> {
  late DrinkHistoryYearsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrinkHistoryYearsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 92.9,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12.0),
          ),
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Material(
                          color: Colors.transparent,
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              bottomLeft: Radius.circular(12.0),
                            ),
                          ),
                          child: Container(
                            width: 287.84,
                            height: 65.2,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  FlutterFlowTheme.of(context).secondaryText,
                                  FlutterFlowTheme.of(context).customColor3
                                ],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(0.0, -1.0),
                                end: AlignmentDirectional(0, 1.0),
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                bottomLeft: Radius.circular(12.0),
                              ),
                            ),
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                widget!.yearlyDrinkLog?.yearKey,
                                'year',
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.merriweather(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Colors.black,
                                    fontSize: 25.0,
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
                        ),
                        Material(
                          color: Colors.transparent,
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                            ),
                          ),
                          child: Container(
                            height: 65.2,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  FlutterFlowTheme.of(context).secondaryText,
                                  FlutterFlowTheme.of(context).customColor3
                                ],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(0.0, -1.0),
                                end: AlignmentDirectional(0, 1.0),
                              ),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                              ),
                              shape: BoxShape.rectangle,
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
                                    return Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: DrinkYearsListWidget(
                                        yearsLog: widget!.yearlyDrinkLog!,
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color:
                                    FlutterFlowTheme.of(context).customColor1,
                                size: 45.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ].addToStart(SizedBox(height: 25.0)),
          ),
        ),
      ],
    );
  }
}
