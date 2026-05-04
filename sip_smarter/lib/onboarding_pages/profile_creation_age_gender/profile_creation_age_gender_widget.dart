import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile_creation_age_gender_model.dart';
export 'profile_creation_age_gender_model.dart';

/// Weight Input Form
class ProfileCreationAgeGenderWidget extends StatefulWidget {
  const ProfileCreationAgeGenderWidget({super.key});

  static String routeName = 'ProfileCreationAgeGender';
  static String routePath = '/profileCreationAgeGender';

  @override
  State<ProfileCreationAgeGenderWidget> createState() =>
      _ProfileCreationAgeGenderWidgetState();
}

class _ProfileCreationAgeGenderWidgetState
    extends State<ProfileCreationAgeGenderWidget> {
  late ProfileCreationAgeGenderModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileCreationAgeGenderModel());

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
        backgroundColor: FlutterFlowTheme.of(context).secondary,
        body: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: 400.0,
            ),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondary,
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            key: ValueKey('Text_fusd'),
                            'What is your birthday?',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .displaySmall
                                        .fontStyle,
                                  ),
                                  color: Colors.black,
                                  fontSize: 24.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .fontStyle,
                                ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              final _datePickedDate = await showDatePicker(
                                context: context,
                                initialDate: getCurrentTimestamp,
                                firstDate: DateTime(1900),
                                lastDate: getCurrentTimestamp,
                                builder: (context, child) {
                                  return wrapInMaterialDatePickerTheme(
                                    context,
                                    child!,
                                    headerBackgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                    headerForegroundColor:
                                        FlutterFlowTheme.of(context).info,
                                    headerTextStyle:
                                        FlutterFlowTheme.of(context)
                                            .headlineLarge
                                            .override(
                                              font: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .fontStyle,
                                              ),
                                              fontSize: 32.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontStyle,
                                            ),
                                    pickerBackgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                    pickerForegroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                    selectedDateTimeBackgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                    selectedDateTimeForegroundColor:
                                        FlutterFlowTheme.of(context).info,
                                    actionButtonForegroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                    iconSize: 24.0,
                                  );
                                },
                              );

                              if (_datePickedDate != null) {
                                safeSetState(() {
                                  _model.datePicked = DateTime(
                                    _datePickedDate.year,
                                    _datePickedDate.month,
                                    _datePickedDate.day,
                                  );
                                });
                              } else if (_model.datePicked != null) {
                                safeSetState(() {
                                  _model.datePicked = getCurrentTimestamp;
                                });
                              }
                            },
                            text: 'Set Birthday',
                            icon: Icon(
                              Icons.calendar_today,
                              size: 15.0,
                            ),
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 70.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0xFFFBDF96),
                              textStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                          Text(
                            'What is your biological gender?',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .displaySmall
                                        .fontStyle,
                                  ),
                                  color: Colors.black,
                                  fontSize: 24.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .fontStyle,
                                ),
                          ),
                          FlutterFlowRadioButton(
                            options: ['Male', 'Female', 'Prefer not to answer']
                                .toList(),
                            onChanged: (val) => safeSetState(() {}),
                            controller: _model.radioButtonValueController ??=
                                FormFieldController<String>(null),
                            optionHeight: 32.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  color: Color(0xFFFFB300),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                            selectedTextStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: Colors.black,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            buttonPosition: RadioButtonPosition.left,
                            direction: Axis.vertical,
                            radioButtonColor: Colors.black,
                            inactiveRadioButtonColor: Color(0xFFFDBE22),
                            toggleable: false,
                            horizontalAlignment: WrapAlignment.start,
                            verticalAlignment: WrapCrossAlignment.start,
                          ),
                        ]
                            .divide(SizedBox(height: 50.0))
                            .addToStart(SizedBox(height: 50.0)),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: () async {
                                await currentUserReference!
                                    .update(createUsersRecordData(
                                  gender: _model.radioButtonValue,
                                  birthday: _model.datePicked,
                                ));
                                if ((_model.radioButtonValue != null &&
                                        _model.radioButtonValue != '') &&
                                    (functions
                                            .is21OrOlder(_model.datePicked)
                                            .toString() ==
                                        '1')) {
                                  context.pushNamed(
                                    ProfileCreationWeightWidget.routeName,
                                    extra: <String, dynamic>{
                                      '__transition_info__': TransitionInfo(
                                        hasTransition: true,
                                        transitionType:
                                            PageTransitionType.rightToLeft,
                                      ),
                                    },
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Gender or Age not valid.',
                                        style: GoogleFonts.merriweatherSans(
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondary,
                                    ),
                                  );
                                }
                              },
                              text: 'Next',
                              icon: Icon(
                                Icons.arrow_forward,
                                size: 24.0,
                              ),
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 56.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 16.0, 24.0, 16.0),
                                iconAlignment: IconAlignment.end,
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ].divide(SizedBox(height: 24.0)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
