import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../models/talk_models/gemini_talk_model.dart';
import 'http_helper.dart';

class Network {
  static String SERVER_GEMINI = "generativelanguage.googleapis.com";

  static final client = InterceptedClient.build(
    interceptors: [HttpInterceptor()],
    retryPolicy: HttpRetryPolicy(),
  );

  /* Http Requests */

  static Future<String?> POST(String api, Map<String, dynamic> body) async {
    try {
      var uri = Uri.https(SERVER_GEMINI, api, paramsApiKey());
      var response = await client.post(uri, body: jsonEncode(body));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        _throwException(response);
      }
    } on SocketException catch (_) {
      // if the network connection fails
      rethrow;
    }
  }

  static _throwException(Response response) {
    String reason = response.reasonPhrase!;
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(reason);
      case 401:
        throw InvalidInputException(reason);
      case 403:
        throw UnauthorisedException(reason);
      case 404:
        throw FetchDataException(reason);
      case 500:
      default:
        throw FetchDataException(reason);
    }
  }

  /* Http Apis*/
  static String API_GEMINI_TALK = "/v1beta/models/gemini-1.5-flash:generateContent";

  /* Http Params */

  static Map<String, String> paramsApiKey() {
    Map<String, String> params = {};
    params.addAll({'key': "AIzaSyCr43M13h6um3I_Bt8G1w3Z2xBfIE8e2YM"});
    return params;
  }

  static Map<String, dynamic> paramsTextOnly(String text) {
    Map<String, dynamic> params = {
      'contents': [
        {
          'parts': [
            {'text': text},
          ]
        }
      ]
    };
    return params;
  }

  static Map<String, dynamic> paramsTextAndImage(String text, String base64Image) {
    Map<String, dynamic> params = {
      'contents': [
        {
          'parts': [
            {'text': text},
            {
              'inlineData': {
                'mimeType': 'image/png',
                'data': base64Image,
              }
            }
          ]
        }
      ]
    };
    return params;
  }

  /* Http Parsing */

  static GeminiTalkModel parseGeminiTalk(String response) {
    dynamic json = jsonDecode(response);
    return GeminiTalkModel.fromJson(json);
  }
}