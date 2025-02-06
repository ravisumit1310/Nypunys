import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../controllers/sessionController.dart';
import '../models/httpResponseModel.dart';

class ServerConfig {
  static const String baseUrl = "http://192.168.1.4:8000";
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };
}

class Connect {
  final GetStorage storage;
  final SessionController sessionController;
  Connect(this.storage, this.sessionController);

  Future<HttpResponseModel<dynamic>?> getReq({required String url}) async {
    try {
      String? accessToken = storage.read("access_token");
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        if (accessToken != null) 'Authorization': 'Bearer $accessToken',
      };

      log("GET Request: $url");
      var response = await http.get(Uri.parse("${ServerConfig.baseUrl}$url"),
          headers: headers);

      return processResponse(response);
    } catch (e) {
      log("GET Error: $e");
      return null;
    }
  }

  Future<HttpResponseModel<dynamic>?> postReq(
      {required Map<String, dynamic> body, required String url}) async {
    try {
      String? accessToken = storage.read("access_token");
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        if (accessToken != null) 'Authorization': 'Bearer $accessToken',
      };

      log("POST Request: $url");
      var response = await http.post(
        Uri.parse("${ServerConfig.baseUrl}$url"),
        body: jsonEncode(body),
        headers: headers,
      );

      return processResponse(response);
    } catch (e) {
      log("POST Error: $e");
      return null;
    }
  }

  HttpResponseModel<dynamic>? processResponse(http.Response response) {
    log("Response Code: ${response.statusCode}");
    log("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return HttpResponseModel(true, json['data'],
          message: json['message'], responseCode: response.statusCode);
    } else {
      var json = jsonDecode(response.body);
      return HttpResponseModel(false, json,
          message: json['message'], responseCode: response.statusCode);
    }
  }
}
