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
import 'drink_customization_a_i_widget.dart' show DrinkCustomizationAIWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

class DrinkCustomizationAIModel
    extends FlutterFlowModel<DrinkCustomizationAIWidget> {
  ///  Local state fields for this component.

  DrinkPresetsRecord? activeDrinkPreset;

  List<DrinkPresetsRecord> availablePresets = [];
  void addToAvailablePresets(DrinkPresetsRecord item) =>
      availablePresets.add(item);
  void removeFromAvailablePresets(DrinkPresetsRecord item) =>
      availablePresets.remove(item);
  void removeAtIndexFromAvailablePresets(int index) =>
      availablePresets.removeAt(index);
  void insertAtIndexInAvailablePresets(int index, DrinkPresetsRecord item) =>
      availablePresets.insert(index, item);
  void updateAvailablePresetsAtIndex(
          int index, Function(DrinkPresetsRecord) updateFn) =>
      availablePresets[index] = updateFn(availablePresets[index]);

  String activeDrinkSizeType = 'oz';

  bool usedDefaultValues = false;

  FFUploadedFile? drinkPhotoLocal;

  String? drinkName2 = '';

  double? drinkSize2;

  String? drinkSizeType2;

  double? drinkABV2;

  String? audioRecording;

  bool isRecorderMounted = true;

  bool isPrompted = false;

  int promptIndex = 0;

  bool resultsVis = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for AiPrompt widget.
  FocusNode? aiPromptFocusNode;
  TextEditingController? aiPromptTextController;
  String? Function(BuildContext, String?)? aiPromptTextControllerValidator;
  AudioRecorder? audioRecorder;
  String? audioRecord;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  bool isDataUploading_audioRecording = false;
  FFUploadedFile uploadedLocalFile_audioRecording =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_audioRecording = '';

  bool isDataUploading_aiDrinkUpload = false;
  FFUploadedFile uploadedLocalFile_aiDrinkUpload =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [AI Agent - Send Message to DrinkParser] action in Button widget.
  Map<String, dynamic>? agentResponse2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    aiPromptFocusNode?.dispose();
    aiPromptTextController?.dispose();
  }
}
