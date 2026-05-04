import '/auth/firebase_auth/auth_util.dart';
import '/backend/ai_agents/ai_agent.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/barcode_components/barcode_result/barcode_result_widget.dart';
import '/drink_customization_components/add_drink_copy/add_drink_copy_widget.dart';
import '/drink_customization_components/drink/drink_widget.dart';
import '/drink_tabs_components/create_tab/create_tab_widget.dart';
import '/drink_tabs_components/drink_tab/drink_tab_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/miscellaneous_components/camera_image/camera_image_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  double? totalMl;

  bool timerOn = true;

  bool timersON = true;

  bool progressBarBAC = true;

  bool customDrinkVisibility = false;

  bool notifOn = true;

  bool navigatedFromCam = false;

  bool isRecording = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  List<DrinkTotalsRecord>? drinkTotals;
  // Stores action output result for [Custom Action - getTotalMl] action in Home widget.
  double? totalMlResult;
  // Stores action output result for [Custom Action - getTotalCost] action in Home widget.
  double? totCost;
  // Stores action output result for [Custom Action - getTotalCalories] action in Home widget.
  int? totCal;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Custom Action - getTotalMl] action in addDrinkButton widget.
  double? totalMlResult3;
  // Stores action output result for [Custom Action - getTotalAlcoholGrams] action in addDrinkButton widget.
  double? totGrams3;
  bool isDataUploading_uploadDataHox2 = false;
  FFUploadedFile uploadedLocalFile_uploadDataHox2 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [AI Agent - Send Message to DrinkImageParser] action in Container widget.
  Map<String, dynamic>? goldenAIAgent2;
  // Stores action output result for [Custom Action - getTotalMl] action in Container widget.
  double? totalMlCamera2;
  // Model for CameraImage component.
  late CameraImageModel cameraImageModel;
  bool isDataUploading_uploadDataHox = false;
  FFUploadedFile uploadedLocalFile_uploadDataHox =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [AI Agent - Send Message to DrinkImageParser] action in CameraImage widget.
  Map<String, dynamic>? goldenAIAgent;
  // Stores action output result for [Custom Action - getTotalMl] action in CameraImage widget.
  double? totalMlCamera;
  var qRCodeResult = '';
  // Stores action output result for [Backend Call - API (UPCItemDB)] action in BarcodeScanner widget.
  ApiCallResponse? apiResultfkx;
  AudioRecorder? audioRecorder;
  String? goldenPathRecording;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  bool isDataUploading_uploadDataDid = false;
  FFUploadedFile uploadedLocalFile_uploadDataDid =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataDid = '';

  // Stores action output result for [AI Agent - Send Message to DrinkAudioParser] action in Icon widget.
  Map<String, dynamic>? aIAudioRecord;
  // Stores action output result for [Custom Action - getTotalMl] action in Icon widget.
  double? totalMlAudio;

  @override
  void initState(BuildContext context) {
    cameraImageModel = createModel(context, () => CameraImageModel());
  }

  @override
  void dispose() {
    cameraImageModel.dispose();
  }
}
