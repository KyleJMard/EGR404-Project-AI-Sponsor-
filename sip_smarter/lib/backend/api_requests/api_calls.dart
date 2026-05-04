import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class BarcodeInfoFetchCall {
  static Future<ApiCallResponse> call({
    String? barcode = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'BarcodeInfoFetch',
      apiUrl:
          'https://world.openfoodfacts.org/api/v0/product/{barcode}.json?fields=product_name,brands,quantity,product_quantity',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'barcode': barcode,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? title(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.products[:].title''',
      ));
  static String? brand(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.products[:].brand''',
      ));
  static String? description(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.products[:].description''',
      ));
  static List<String>? images(dynamic response) => (getJsonField(
        response,
        r'''$.products[:].images''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static String? barcodenumber(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.products[:].barcode_number''',
      ));
  static String? manufacturer(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.products[:].manufacturer''',
      ));
}

class OpenFoodFactsCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'OpenFoodFacts',
      apiUrl: 'https://world.openfoodfacts.org/api/v0/product/{{barcode}}.json',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UPCItemDBCall {
  static Future<ApiCallResponse> call({
    String? barcode = '049000012781',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'UPCItemDB',
      apiUrl: 'https://api.upcitemdb.com/prod/trial/lookup',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
      },
      params: {
        'upc': barcode,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? title(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.items[:].title''',
      ));
  static List<String>? images(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].images''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<double>? prices(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].offers[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
}

class WeeklyMlCall {
  static Future<ApiCallResponse> call({
    String? uid = '04sI0qeLrpbWhFJKganWvSOYHhC2',
  }) async {
    final ffApiRequestBody = '''
{
  "uid": "${escapeStringForJson(uid)}",
  "tzOffsetMinutes": -300
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'weeklyMl',
      apiUrl: 'https://weeklymltest-qwkgyf6chq-uc.a.run.app',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SponsorAskCall {
  static Future<ApiCallResponse> call({
    String? uid = 'z5HcwpsHnpSfc830hSuek4Ee0yO2',
    String? userPrompt = 'How am I doing this week?',
  }) async {
    final ffApiRequestBody = '''
{
  "uid": "${escapeStringForJson(uid)}",
  "prompt": "${escapeStringForJson(userPrompt)}",
  "mode": "supportive",
  "tzOffsetMinutes": -300
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'sponsorAsk',
      apiUrl: 'https://sponsorask-l2ykvc2zlq-uc.a.run.app',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class GetUserDrinkTotalsCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "uid": "${escapeStringForJson(userId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getUserDrinkTotals',
      apiUrl: 'https://getuserdrinktotals-l2ykvc2zlq-uc.a.run.app',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? aisummary(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.ai_summary''',
      ));
}

class GenerateInsightCall {
  static Future<ApiCallResponse> call({
    String? uid = '',
  }) async {
    final ffApiRequestBody = '''
{
  "user_id": "${escapeStringForJson(uid)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'generateInsight',
      apiUrl: 'https://generate-insight-l2ykvc2zlq-uc.a.run.app',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
