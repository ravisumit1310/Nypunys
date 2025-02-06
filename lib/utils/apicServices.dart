import 'dart:convert';

import 'package:http/http.dart' as http;

class ServerConfig {
  static const String baseUrl = "http://192.168.1.17:8000";
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}

class ApiService {
  static Future post(String endpoint, Map<String, dynamic> body) async {
    try {
      final url = Uri.parse('${ServerConfig.baseUrl}$endpoint');
      final resp = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      } else {
        return null;
      }
    } catch (e) {
      print("here is some error $e");
      return e;
    }
  }
}
