import '/auth/firebase_auth/auth_util.dart';
import '/backend/ai_agents/ai_agent.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/drink_customization_components/add_drink_customization/add_drink_customization_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'drink_customization_a_i_model.dart';
export 'drink_customization_a_i_model.dart';

class DrinkCustomizationAIWidget extends StatefulWidget {
  const DrinkCustomizationAIWidget({
    super.key,
    this.drinkPhoto,
  });

  final FFUploadedFile? drinkPhoto;

  @override
  State<DrinkCustomizationAIWidget> createState() =>
      _DrinkCustomizationAIWidgetState();
}

class _DrinkCustomizationAIWidgetState
    extends State<DrinkCustomizationAIWidget> {
  late DrinkCustomizationAIModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DrinkCustomizationAIModel());

    _model.aiPromptTextController ??= TextEditingController();
    _model.aiPromptFocusNode ??= FocusNode();

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
        height: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).primary,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (_model.promptIndex > 0) {
                          _model.promptIndex = _model.promptIndex + -1;
                          safeSetState(() {});
                        } else {
                          _model.promptIndex = 2;
                          safeSetState(() {});
                        }
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        size: 24.0,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      if (_model.promptIndex == 2)
                        Container(
                          width: 135.0,
                          height: 135.9,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Visibility(
                            visible: _model.promptIndex == 2,
                            child: Container(
                              width: double.infinity,
                              child: TextFormField(
                                controller: _model.aiPromptTextController,
                                focusNode: _model.aiPromptFocusNode,
                                onFieldSubmitted: (_) async {
                                  _model.isPrompted = true;
                                  safeSetState(() {});
                                },
                                autofocus: false,
                                enabled: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.merriweather(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .accent1,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                  hintText: 'Prompt...',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.merriweather(
                                          fontWeight: FontWeight.w100,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .accent1,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w100,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.merriweather(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                enableInteractiveSelection: true,
                                validator: _model
                                    .aiPromptTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                        ),
                      if (_model.promptIndex == 1)
                        Container(
                          width: 135.0,
                          height: 135.0,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(24.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).info,
                            ),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            children: [
                              if (_model.isRecorderMounted)
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    _model.isRecorderMounted = false;
                                    safeSetState(() {});
                                    await startAudioRecording(
                                      context,
                                      audioRecorder: _model.audioRecorder ??=
                                          AudioRecorder(),
                                    );
                                  },
                                  child: Icon(
                                    Icons.mic,
                                    color: FlutterFlowTheme.of(context).info,
                                    size: 80.0,
                                  ),
                                ),
                              if (!_model.isRecorderMounted)
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    _model.isRecorderMounted = true;
                                    safeSetState(() {});
                                    await stopAudioRecording(
                                      audioRecorder: _model.audioRecorder,
                                      audioName: 'recordedFileBytes',
                                      onRecordingComplete:
                                          (audioFilePath, audioBytes) {
                                        _model.audioRecord = audioFilePath;
                                        _model.recordedFileBytes = audioBytes;
                                      },
                                    );

                                    {
                                      safeSetState(() => _model
                                              .isDataUploading_audioRecording =
                                          true);
                                      var selectedUploadedFiles =
                                          <FFUploadedFile>[];
                                      var selectedFiles = <SelectedFile>[];
                                      var downloadUrls = <String>[];
                                      try {
                                        selectedUploadedFiles = _model
                                                .recordedFileBytes
                                                .bytes!
                                                .isNotEmpty
                                            ? [_model.recordedFileBytes]
                                            : <FFUploadedFile>[];
                                        selectedFiles =
                                            selectedFilesFromUploadedFiles(
                                          selectedUploadedFiles,
                                        );
                                        downloadUrls = (await Future.wait(
                                          selectedFiles.map(
                                            (f) async => await uploadData(
                                                f.storagePath, f.bytes),
                                          ),
                                        ))
                                            .where((u) => u != null)
                                            .map((u) => u!)
                                            .toList();
                                      } finally {
                                        _model.isDataUploading_audioRecording =
                                            false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedFiles.length &&
                                          downloadUrls.length ==
                                              selectedFiles.length) {
                                        safeSetState(() {
                                          _model.uploadedLocalFile_audioRecording =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl_audioRecording =
                                              downloadUrls.first;
                                        });
                                      } else {
                                        safeSetState(() {});
                                        return;
                                      }
                                    }

                                    _model.audioRecording =
                                        _model.uploadedFileUrl_audioRecording;
                                    safeSetState(() {});

                                    safeSetState(() {});
                                  },
                                  child: Icon(
                                    Icons.mic,
                                    color: Color(0xFFFF0000),
                                    size: 100.0,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      if (_model.promptIndex == 0)
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            final selectedMedia =
                                await selectMediaWithSourceBottomSheet(
                              context: context,
                              allowPhoto: true,
                            );
                            if (selectedMedia != null &&
                                selectedMedia.every((m) => validateFileFormat(
                                    m.storagePath, context))) {
                              safeSetState(() =>
                                  _model.isDataUploading_aiDrinkUpload = true);
                              var selectedUploadedFiles = <FFUploadedFile>[];

                              try {
                                selectedUploadedFiles = selectedMedia
                                    .map((m) => FFUploadedFile(
                                          name: m.storagePath.split('/').last,
                                          bytes: m.bytes,
                                          height: m.dimensions?.height,
                                          width: m.dimensions?.width,
                                          blurHash: m.blurHash,
                                          originalFilename: m.originalFilename,
                                        ))
                                    .toList();
                              } finally {
                                _model.isDataUploading_aiDrinkUpload = false;
                              }
                              if (selectedUploadedFiles.length ==
                                  selectedMedia.length) {
                                safeSetState(() {
                                  _model.uploadedLocalFile_aiDrinkUpload =
                                      selectedUploadedFiles.first;
                                });
                              } else {
                                safeSetState(() {});
                                return;
                              }
                            }

                            safeSetState(() {});
                            _model.drinkPhotoLocal =
                                _model.uploadedLocalFile_aiDrinkUpload;
                            safeSetState(() {});
                          },
                          child: Container(
                            width: 135.0,
                            height: 135.0,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.memory(
                                  _model.uploadedLocalFile_aiDrinkUpload
                                          .bytes ??
                                      Uint8List.fromList([]),
                                ).image,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).info,
                              ),
                            ),
                            child: Visibility(
                              visible: _model.promptIndex == 0,
                              child: Stack(
                                children: [
                                  if (_model.uploadedLocalFile_aiDrinkUpload ==
                                          null ||
                                      (_model.uploadedLocalFile_aiDrinkUpload
                                              .bytes?.isEmpty ??
                                          true))
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Icon(
                                        Icons.camera_alt,
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        size: 60.0,
                                      ),
                                    ),
                                  if (_model.drinkPhotoLocal != null &&
                                      (_model.drinkPhotoLocal?.bytes
                                              ?.isNotEmpty ??
                                          false))
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.memory(
                                          _model.drinkPhotoLocal?.bytes ??
                                              Uint8List.fromList([]),
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (_model.promptIndex < 2) {
                          _model.promptIndex = _model.promptIndex + 1;
                          safeSetState(() {});
                        } else {
                          _model.promptIndex = 0;
                          safeSetState(() {});
                        }
                      },
                      child: Icon(
                        Icons.arrow_forward,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        size: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
              FFButtonWidget(
                onPressed: () async {
                  if ((_model.drinkPhotoLocal != null &&
                          (_model.drinkPhotoLocal?.bytes?.isNotEmpty ??
                              false)) ||
                      (_model.aiPromptTextController.text != null &&
                          _model.aiPromptTextController.text != '') ||
                      (_model.audioRecording != null &&
                          _model.audioRecording != '')) {
                    await callAiAgent(
                      context: context,
                      prompt: _model.aiPromptTextController.text,
                      imageAsset: _model.drinkPhotoLocal,
                      audioAsset: _model.recordedFileBytes,
                      threadId: currentUserUid,
                      agentCloudFunctionName: 'drinkParser',
                      provider: 'GOOGLE',
                      agentJson:
                          '{\"status\":\"LIVE\",\"identifier\":{\"name\":\"drinkParser\",\"key\":\"ecl1v\"},\"name\":\"DrinkParser\",\"description\":\"This agent takes an image, text description, or audio recording of a drink and extracts structured data about the drink the person is actively consuming. Text input always overrides image input for drink identity. Audio input overrides both text and images, except if it is null, or unset. The image is only used to estimate size when the text does not specify it. If the image shows a large container (such as a handle, bottle, or jug), the agent should infer a reasonable single serving instead of treating the whole container as the drink. The agent returns normalized JSON containing drink_name, drink_abv, drink_size, drink_size_type, and confidence, and drink_name must be formatted in clean title case.\\r\\n\",\"aiModel\":{\"provider\":\"GOOGLE\",\"model\":\"gemini-2.5-flash\",\"parameters\":{\"temperature\":{\"inputValue\":1},\"maxTokens\":{\"inputValue\":65535},\"topP\":{\"inputValue\":0.95}},\"messages\":[{\"role\":\"SYSTEM\",\"text\":\"You analyze text descriptions, images, and audio recordings of drinks and return a JSON object that represents the drink the person is actively consuming. Text input always overrides image input for identifying the drink. Use the image only to estimate size when the text does not specify it. \\n\\r\\nIf the image or text shows a large container (handle, bottle, jug, can, multipack, etc.) do NOT assume the user is drinking the entire container. Infer the most likely single serving based on the drink type. For example:\\r\\n- A handle of 40 percent vodka implies a typical bar shot (about 1.5 oz).\\r\\n- A large bottle of wine implies a single glass pour (5 oz).\\r\\n- A liquor bottle shown without context should default to a standard serving size (1.5 oz).\\r\\n\\r\\nOutput must follow this exact structure:\\r\\n\\r\\n{\\r\\n  \\\"drink_name\\\": string,\\r\\n  \\\"drink_abv\\\": number,\\r\\n  \\\"drink_size\\\": number,\\r\\n  \\\"drink_size_type\\\": \\\"oz\\\" or \\\"mL\\\" or \\\"cups\\\",\\n\\\"drink_calories\\\": number,\\n  \\\"confidence\\\": number\\r\\n}\\r\\n\\r\\nRules:\\r\\n- drink_calories is the number of calories in a single serving of the drink\\n- drink_name must be no greater than 25 characters\\n- Format drink_name in clean, presentable title case.\\r\\n- If information is missing, guess with lower confidence.\\r\\n- drink_abv is the percent ABV without the percent symbol.\\r\\n- drink_size is numeric only and should represent a realistic single serving.\\n- drink_size_type must be \\\"oz\\\", \\\"mL\\\", or \\\"cups\\\".\\r\\n- confidence is a number from 0 to 100.\\r\\n- Do not include any text outside the JSON.\"}]},\"requestOptions\":{\"requestTypes\":[\"PLAINTEXT\",\"AUDIO\",\"IMAGE\"]},\"responseOptions\":{\"responseType\":\"JSON\"}}',
                      responseType: 'JSON',
                    ).then((generatedText) {
                      safeSetState(() => _model.agentResponse2 = generatedText);
                    });

                    _model.drinkName2 = getJsonField(
                      _model.agentResponse2,
                      r'''$["drink_name"]''',
                    ).toString();
                    _model.audioRecording = null;
                    _model.resultsVis = true;
                    safeSetState(() {});
                  } else {
                    await showDialog(
                      context: context,
                      builder: (alertDialogContext) {
                        return AlertDialog(
                          title: Text('No Prompt Entered'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext),
                              child: Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                  }

                  safeSetState(() {});
                },
                text: 'Ask AI',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 55.3,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).secondaryText,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.merriweather(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).accent1,
                        fontSize: 25.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 5.0,
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).secondary,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              if (_model.resultsVis)
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your Results',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.merriweather(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                            ),
                            color: FlutterFlowTheme.of(context).info,
                            fontSize: 25.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ],
                ),
              if (_model.resultsVis)
                Material(
                  color: Colors.transparent,
                  elevation: 5.0,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          FlutterFlowTheme.of(context).primaryBackground,
                          FlutterFlowTheme.of(context).customColor2
                        ],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).secondary,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          valueOrDefault<String>(
                            getJsonField(
                              _model.agentResponse2,
                              r'''$["drink_name"]''',
                            )?.toString(),
                            'Drink Name',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.merriweatherSans(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                        Text(
                          '${valueOrDefault<String>(
                            getJsonField(
                              _model.agentResponse2,
                              r'''$["drink_size"]''',
                            )?.toString(),
                            'Serving',
                          )} ${valueOrDefault<String>(
                            getJsonField(
                              _model.agentResponse2,
                              r'''$["drink_size_type"]''',
                            )?.toString(),
                            'Size',
                          )}',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.merriweatherSans(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                        Text(
                          '${valueOrDefault<String>(
                            getJsonField(
                              _model.agentResponse2,
                              r'''$["drink_abv"]''',
                            )?.toString(),
                            'ABV',
                          )}%',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.merriweatherSans(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                        Text(
                          'Calories: ${getJsonField(
                            _model.agentResponse2,
                            r'''$["drink_calories"]''',
                          ).toString()}',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.merriweatherSans(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (_model.resultsVis)
                FFButtonWidget(
                  onPressed: () async {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: AddDrinkCustomizationWidget(
                            passedName: valueOrDefault<String>(
                              getJsonField(
                                _model.agentResponse2,
                                r'''$["drink_name"]''',
                              )?.toString(),
                              'Drink Name',
                            ),
                            passedSize: valueOrDefault<String>(
                              getJsonField(
                                _model.agentResponse2,
                                r'''$["drink_size"]''',
                              )?.toString(),
                              'Drink Name',
                            ),
                            passedSizeType: valueOrDefault<String>(
                              getJsonField(
                                _model.agentResponse2,
                                r'''$["drink_size_type"]''',
                              )?.toString(),
                              'Drink Name',
                            ),
                            passedABV: valueOrDefault<String>(
                              getJsonField(
                                _model.agentResponse2,
                                r'''$["drink_abv"]''',
                              )?.toString(),
                              'Drink Name',
                            ),
                            passedPrice: '0.00',
                            passedCount: '1',
                            passedCalories: getJsonField(
                              _model.agentResponse2,
                              r'''$["drink_calories"]''',
                            ),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  },
                  text: 'Edit/Save',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 65.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).customColor4,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.poppins(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).info,
                          fontSize: 25.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).secondary,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
            ]
                .divide(SizedBox(
                    height: MediaQuery.sizeOf(context).width < kBreakpointSmall
                        ? 20.0
                        : 40.0))
                .addToEnd(SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}
