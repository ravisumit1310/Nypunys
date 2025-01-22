import 'dart:convert';
import 'package:http/http.dart' as http;

class ServerConfig {
  static const String baseUrl =
      "https://3198-2401-4900-1f27-f92b-fdf2-6dab-6b29-9850.ngrok-free.app";
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };

  static Future<Map<String, dynamic>> getStudentAttendanceReport(
      String token, int studentId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/attendance/report/student/$studentId'),
      headers: {
        ...defaultHeaders,
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Student not found');
    } else {
      throw Exception('Failed to fetch attendance report');
    }
  }
}
