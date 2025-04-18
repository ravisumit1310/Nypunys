import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/studentDetails_Model.dart';
import 'package:academyapp/utils/apicServices.dart';

class SessionController extends GetxController {
  final _storage = GetStorage();

  // Reactive state
  var isLoggedIn = false.obs;
  Rx<StudentDetailsModel?> _studentProfile = Rx<StudentDetailsModel?>(null);

  // Session timers
  Timer? _logoutTimer;
  Timer? _refreshTimer;

  // Getters
  StudentDetailsModel? get studentProfile => _studentProfile.value;
  String? get accessToken => _storage.read('access_token');
  String? get refreshToken => _storage.read('refresh_token');

  // Setters
  set studentProfile(StudentDetailsModel? profile) {
    _studentProfile.value = profile;
    if (profile != null) {
      _storage.write('student_profile', jsonEncode(profile.toJson()));
      print("📥 Saved student profile: ${jsonEncode(profile.toJson())}");
    } else {
      _storage.remove('student_profile');
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadCurrentSession();
  }

  // ===========================
  // SESSION LOAD / SAVE
  // ===========================

  void _loadCurrentSession() {
    loadStudentProfile();
    if (_studentProfile.value != null) {
      isLoggedIn.value = true;
      _setupAutoTokenRefresh();
    }
  }

  void saveSession(String accessToken, String refreshToken,
      Map<String, dynamic> studentData) {
    _storage.write('access_token', accessToken);
    _storage.write('refresh_token', refreshToken);
    _storage.write('student_profile', jsonEncode(studentData));
    _storage.write('login_time', DateTime.now().millisecondsSinceEpoch);

    studentProfile = StudentDetailsModel.fromJson(studentData);
    isLoggedIn.value = true;
    _setupAutoTokenRefresh();
  }

  void loadStudentProfile() {
    String? storedProfile = _storage.read('student_profile');
    if (storedProfile != null) {
      studentProfile = StudentDetailsModel.fromJson(jsonDecode(storedProfile));
      isLoggedIn.value = true;
    }
  }

  void updateStudentProfile(Map<String, dynamic> studentData) {
    studentProfile = StudentDetailsModel.fromJson(studentData);
    isLoggedIn.value = true;
    print("🔄 Updated profile: ${studentProfile?.toJson()}");
  }

  // ===========================
  // TOKEN HANDLING
  // ===========================

  void _setupAutoTokenRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer =
        Timer.periodic(Duration(minutes: 55), (_) => refreshAccessToken());
  }

  Future<void> checkTokenOnStartUp() async {
    await Future.delayed(Duration(microseconds: 500));

    final token = accessToken;
    final loginTime = _storage.read('login_time');

    if (loginTime != null) {
      final elapsedSeconds =
          (DateTime.now().millisecondsSinceEpoch - loginTime) ~/ 1000;
      if (elapsedSeconds >= 3600) {
        logout();
        return;
      }
    }

    if (token == null || !(await isAccessTokenValid(token))) {
      await refreshAccessToken();
    } else {
      isLoggedIn.value = true;
    }
  }

  Future<void> refreshAccessToken() async {
    final rToken = refreshToken;
    if (rToken == null) return logout();

    try {
      final response = await http.post(
        Uri.parse("${ServerConfig.baseUrl}/student/token/refresh/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"current_refresh_token": rToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        saveSession(
          data['access_token'],
          data['refresh_token'],
          _studentProfile.value?.toJson() ?? {},
        );
      } else {
        logout();
      }
    } catch (e) {
      logout();
    }
  }

  Future<bool> isAccessTokenValid(String? token) async {
    return token != null && token.isNotEmpty;
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw Exception('Invalid JWT');
    final payload =
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    return json.decode(payload);
  }

  // ===========================
  // ACCOUNT SWITCHING / MULTI-LOGIN
  // ===========================

  void saveCurrentAccount() {
    if (studentProfile != null && accessToken != null && refreshToken != null) {
      final key = "account_user_${studentProfile!.id}";
      _storage.write(
          key,
          jsonEncode({
            "access_token": accessToken,
            "refresh_token": refreshToken,
            "student_profile": studentProfile!.toJson(),
          }));
    }
  }

  List<Map<String, dynamic>> getSavedAccounts() {
    final rawKeys = _storage.getKeys();
    print("🧪 All keys from storage: $rawKeys");

    final keys = rawKeys.where((key) {
      final isString = key is String;
      final startsCorrectly = isString && key.startsWith("account_user_");
      print(
          "🔍 Checking key: $key (isString: $isString, startsCorrectly: $startsCorrectly)");
      return startsCorrectly;
    }).toList();

    print("Filtered keys: $keys");

    return keys
        .map((key) {
          final raw = _storage.read(key);
          print("Reading $key -> $raw");
          if (raw == null) return null;

          final data = jsonDecode(raw);
          return {
            "key": key,
            "profile": data["student_profile"],
            "access_token": data["access_token"],
            "refresh_token": data["refresh_token"],
          };
        })
        .whereType<Map<String, dynamic>>()
        .toList();
  }

  void storeAccountWithOptionalName({
    required StudentDetailsModel profile,
    required String accessToken,
    required String refreshToken,
    String? nickname,
  }) {
    String fallbackKey;

    if (nickname != null && nickname.trim().isNotEmpty) {
      fallbackKey = "account_${nickname.trim()}";
    } else if (profile.id != null) {
      fallbackKey = "account_user_${profile.id}";
    } else if (profile.name != null && profile.name.isNotEmpty) {
      fallbackKey = "account_${profile.name}";
    } else {
      List<String> allKeys =
          _storage.getKeys().where((k) => k.startsWith("account_")).toList();
      fallbackKey = "account_${allKeys.length + 1}";
    }

    _storage.write(
        fallbackKey,
        jsonEncode({
          "access_token": accessToken,
          "refresh_token": refreshToken,
          "student_profile": profile.toJson(),
        }));

    print("Stored account [$fallbackKey]");
  }

  // ===========================
  // LOGOUT / CLEANUP
  // ===========================

  void logout() {
    _logoutTimer?.cancel();
    _refreshTimer?.cancel();

    final savedKeys = _storage
        .getKeys()
        .where((key) => key.startsWith("account_") || key == "saved_nicknames")
        .toList();

    final savedData = {
      for (var key in savedKeys) key: _storage.read(key),
    };

    final savedEmail = _storage.read('saved_email');

    _storage.erase();

    for (var entry in savedData.entries) {
      _storage.write(entry.key, entry.value);
    }
    if (savedEmail != null && savedEmail.isNotEmpty) {
      _storage.write('saved_email', savedEmail);
    }

    _studentProfile.value = null;
    isLoggedIn.value = false;

    Get.offAllNamed('/login');
  }
}
