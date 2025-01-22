import 'dart:convert';
import 'package:academyapp/utils/server.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class ApiService {
  // final String baseUrl =
  //     "https://3198-2401-4900-1f27-f92b-fdf2-6dab-6b29-9850.ngrok-free.app";
  final GetStorage storage = GetStorage();

  //Api for login
  Future<Map<String, dynamic>> studentLogin(
      String email, String password) async {
    final url = Uri.parse('${ServerConfig.baseUrl}/student/login/');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      storage.write("student_token", responseData['access_token']);
      print(
          "this is the token in the apiServices page -> ${storage.read("student_token")}");
      return responseData;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> refreshAccessToken(String refreshToken) async {
    final url = Uri.parse('$baseUrl/token/refresh/');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'current_refresh_token': refreshToken,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  //Api for student data
  Future<Map<String, dynamic>> getStudentProfile() async {
    final token = getStudentToken();
    if (token == null) {
      throw Exception('No token found');
    }

    final url = Uri.parse('$baseUrl/student/profile/');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      if (response.statusCode == 401) {
        // Token expired, attempt to refresh it
        final refreshToken = getStudentRefreshToken();
        final newTokens = await refreshAccessToken(refreshToken!);
        // Save the new tokens to storage
        storage.write('access_token', newTokens['access_token']);
        storage.write('refresh_token', newTokens['refresh_token']);

        // Retry the original request with the new access token
        final newAccessToken = newTokens['access_token'];
        final retryResponse = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $newAccessToken',
          },
        );

        if (retryResponse.statusCode == 200) {
          return json.decode(retryResponse.body);
        } else {
          throw Exception('Failed to fetch profile after token refresh');
        }
      }
      throw Exception('Failed to fetch profile');
    }
  }

  // Get stored token from GetStorage
  String? getStudentToken() {
    return storage.read("access_token");
  }

  String? getStudentRefreshToken() {
    return storage.read("refresh_token");
  }

// Logout function to remove the token
  void logoutStudent() {
    storage.remove("access_token");
    storage.remove("refresh_token");
  }
}
