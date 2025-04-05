import 'dart:convert';
import 'package:academyapp/controllers/sessionController.dart';
import 'package:http/http.dart' as http;

class ServerConfig {
  // static const String baseUrl =
  //     "https://nse-nypunya-service-1054208070778.asia-south1.run.app";
  static const String baseUrl = "http://192.168.1.2:8000";
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}

class ApiService {
  final SessionController _session;
  ApiService(this._session);
  Future<void> _checkValidToken() async {
    String? token = _session.accessToken;
    if (token == null || !(await _session.isAccessTokenValid(token))) {
      await _session.refreshAccessToken();
    }
  }

  Future get(String endpoint) async {
    await _checkValidToken();
    final url = Uri.parse('${ServerConfig.baseUrl}$endpoint');

    final resp = await http.get(url, headers: {
      'Authorization': 'Bearer ${_session.accessToken}',
      ...ServerConfig.defaultHeaders,
    });
    return handleResponse(resp);
  }

  Future post(String endpoint, Map<String, dynamic> body) async {
    await _checkValidToken();
    final url = Uri.parse('${ServerConfig.baseUrl}$endpoint');

    final resp = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${_session.accessToken}',
        ...ServerConfig.defaultHeaders,
      },
      body: jsonEncode(body),
    );
    return handleResponse(resp);
  }

  Future put(String endpoint, Map<String, dynamic> body) async {
    await _checkValidToken();
    final url = Uri.parse('${ServerConfig.baseUrl}$endpoint');

    final resp = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer ${_session.accessToken}',
        ...ServerConfig.defaultHeaders,
      },
      body: jsonEncode(body),
    );
    return handleResponse(resp);
  }

  dynamic handleResponse(http.Response resp) {
    print("🔍 API Response Status Code: ${resp.statusCode}");
    print("🔍 API Response Body: ${resp.body}");

    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    } else if (resp.statusCode == 401) {
      _session.logout();
      return {"error": "Unauthorized - Session expired"};
    } else {
      return {
        "error": "Something wrong in apiService handle response",
        "status_code": resp.statusCode,
        "response_body": resp.body
      };
    }
  }
}
