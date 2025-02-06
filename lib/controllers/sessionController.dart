import 'dart:convert';

import 'package:academyapp/utils/apicServices.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class SessionController extends GetxController {
  final _storage = GetStorage();
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkTokenOnStartUp();
    // isLoggedIn.value = _storage.hasData('access_token');
  }

  void saveSession(String accessToken, String refreshToken) {
    _storage.write('access_token', accessToken);
    _storage.write('refresh_token', refreshToken);
    isLoggedIn.value = true;
  }

  String? get accessToken => _storage.read('access_token');
  String? get refreshToken => _storage.read('refresh_token');

  void logout() {
    _storage.erase();
    isLoggedIn.value = false;
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
        saveSession(data["access_token"], data["refresh_token"]);
      } else {
        logout();
      }
    } catch (e) {
      logout();
    }
  }
}
