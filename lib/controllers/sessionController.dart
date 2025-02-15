import 'dart:convert';

import 'package:academyapp/utils/apicServices.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/studentDetails_Model.dart';
import 'logincontroller.dart';

class SessionController extends GetxController {
  final _storage = GetStorage();
  var isLoggedIn = false.obs;
  StudentDetailsModel? _studentProfile;

  @override
  void onInit() {
    super.onInit();
    checkTokenOnStartUp();
    loadStudentProfile();
  }

  void saveSession(String accessToken, String refreshToken,
      Map<String, dynamic> studentData) {
    _storage.write('access_token', accessToken);
    _storage.write('refresh_token', refreshToken);
    _storage.write('student_profile', jsonEncode(studentData));
    _studentProfile = StudentDetailsModel.fromJson(studentData);
    isLoggedIn.value = true;
  }

  String? get accessToken => _storage.read('access_token');
  String? get refreshToken => _storage.read('refresh_token');
  // Map<String, dynamic>? get studentProfile => _storage.read('student_profile');
  StudentDetailsModel? get studentProfile => _studentProfile;

  void logout() {
    String? savedEmail = _storage.read('saved_email');
    _storage.erase();
    _studentProfile = null;
    isLoggedIn.value = false;

    // Restore the saved email if it was set
    if (savedEmail != null && savedEmail.isNotEmpty) {
      _storage.write('saved_email', savedEmail);
    }

    _studentProfile = null;
    isLoggedIn.value = false;
  }

  void loadStudentProfile() {
    String? storedProfile = _storage.read('student_profile');
    if (storedProfile != null) {
      _studentProfile = StudentDetailsModel.fromJson(jsonDecode(storedProfile));
    }
  }

  //Check Token on startup
  Future<void> checkTokenOnStartUp() async {
    await Future.delayed(const Duration(microseconds: 500));

    String? token = accessToken;
    if (token == null || !(await isAccessTokenValid(token))) {
      await refreshAccessToken();
    } else {
      isLoggedIn.value = true;
    }
  }

  //checking token
  Future<bool> isAccessTokenValid(String? token) async {
    return token != null && token.isNotEmpty;
  }

  //if token expired the refresh
  Future<void> refreshAccessToken() async {
    String? refreshToken = _storage.read('refresh_token');
    if (refreshToken == null) {
      logout();
      return;
    }

    try {
      final url = Uri.parse("${ServerConfig.baseUrl}/auth/token/refresh/");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"current_refresh_token": refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        saveSession(data["access_token"], data["refresh_token"],
            _studentProfile?.toJson() ?? {});
      } else {
        logout();
      }
    } catch (e) {
      logout();
    }
  }
}
