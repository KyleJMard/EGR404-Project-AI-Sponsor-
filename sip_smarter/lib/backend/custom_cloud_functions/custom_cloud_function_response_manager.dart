import '/backend/schema/structs/index.dart';

class SponsorAskCloudFunctionCallResponse {
  SponsorAskCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
}
