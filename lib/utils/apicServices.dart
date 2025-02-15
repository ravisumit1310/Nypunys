import 'dart:convert';
import 'package:academyapp/controllers/sessionController.dart';
import 'package:http/http.dart' as http;

class ServerConfig {
  // static const String baseUrl = "http://api.affilings.in";
  static const String baseUrl = "http://192.168.1.9:8000";
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

  dynamic handleResponse(http.Response resp) {
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    } else if (resp.statusCode == 401) {
      _session.logout();
    } else {
      return {"error", "Something wrong in apiService handle response"};
    }
  }
}
