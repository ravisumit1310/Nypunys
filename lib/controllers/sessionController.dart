import 'dart:async';
import 'dart:convert';

import 'package:academyapp/utils/apicServices.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/studentDetails_Model.dart';

class SessionController extends GetxController {
  final _storage = GetStorage();
  var isLoggedIn = false.obs;
  Timer? _logoutTimer;
  Rx<StudentDetailsModel?> _studentProfile = Rx<StudentDetailsModel?>(null);

  StudentDetailsModel? get studentProfile => _studentProfile.value;

  set studentProfile(StudentDetailsModel? profile) {
    _studentProfile.value = profile;
    if (profile != null) {
      _storage.write('student_profile', jsonEncode(profile.toJson()));
      print(
          "This is the Data in the session controller -->  ${jsonEncode(profile.toJson())}");
    } else {
      _storage.remove('student_profile');
    }
  }

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
    _storage.write('login_time', DateTime.now().millisecondsSinceEpoch);
    studentProfile = StudentDetailsModel.fromJson(studentData);
    isLoggedIn.value = true;

    _startAutoLogoutTimer();
  }

  void _startAutoLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = Timer(const Duration(hours: 1), () {
      logout();
      Get.snackbar("Session Expired", "You have been logged out after 1 hour.");
    });
  }

  String? get accessToken => _storage.read('access_token');
  String? get refreshToken => _storage.read('refresh_token');

  void logout() {
    _logoutTimer?.cancel(); // Fix: Stop auto-logout timer
    String? savedEmail = _storage.read('saved_email');
    _storage.erase();
    _studentProfile.value = null; // Fix: Correct way to clear reactive variable
    isLoggedIn.value = false;

    if (savedEmail != null && savedEmail.isNotEmpty) {
      _storage.write('saved_email', savedEmail);
    }

    Get.offAllNamed('/login');
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
    print("🔄 Updated Student Profile: ${studentProfile?.toJson()}");
  }

  Future<void> checkTokenOnStartUp() async {
    await Future.delayed(const Duration(microseconds: 500));

    String? token = accessToken;

    int? loginTime = _storage.read('login_time');
    if (loginTime != null) {
      int elapsedSeconds =
          (DateTime.now().millisecondsSinceEpoch - loginTime) ~/ 1000;
      if (elapsedSeconds >= 3600) {
        logout();
        return;
      }
      _startAutoLogoutTimer();
    }

    if (token == null || !(await isAccessTokenValid(token))) {
      await refreshAccessToken();
    } else {
      isLoggedIn.value = true;
    }
  }

  Future<bool> isAccessTokenValid(String? token) async {
    return token != null && token.isNotEmpty;
  }

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
            _studentProfile.value?.toJson() ?? {}); // Fix: Correct reference
      } else {
        logout();
      }
    } catch (e) {
      logout();
    }
  }
}

// class SessionController extends GetxController {
//   final _storage = GetStorage();
//   var isLoggedIn = false.obs;
//   StudentDetailsModel? _studentProfile;
//   Timer? _logoutTimer; // ⏳ Timer for auto-logout
//
//   @override
//   void onInit() {
//     super.onInit();
//     checkTokenOnStartUp();
//     loadStudentProfile();
//   }
//
//   void saveSession(String accessToken, String refreshToken,
//       Map<String, dynamic> studentData) {
//     _storage.write('access_token', accessToken);
//     _storage.write('refresh_token', refreshToken);
//     _storage.write('student_profile', jsonEncode(studentData));
//     _storage.write('login_time', DateTime.now().millisecondsSinceEpoch);
//     _studentProfile = StudentDetailsModel.fromJson(studentData);
//     isLoggedIn.value = true;
//
//     _startAutoLogoutTimer();
//   }
//
//   void _startAutoLogoutTimer() {
//     _logoutTimer?.cancel();
//     _logoutTimer = Timer(const Duration(hours: 1), () {
//       logout();
//       Get.snackbar("Session Expired", "You have been logged out after 1 hour.");
//     });
//   }
//
//   String? get accessToken => _storage.read('access_token');
//   String? get refreshToken => _storage.read('refresh_token');
//   // Map<String, dynamic>? get studentProfile => _storage.read('student_profile');
//   StudentDetailsModel? get studentProfile => _studentProfile;
//
//   void logout() {
//     String? savedEmail = _storage.read('saved_email');
//     _storage.erase();
//     _studentProfile = null;
//     isLoggedIn.value = false;
//
//     // Restore the saved email if it was set
//     if (savedEmail != null && savedEmail.isNotEmpty) {
//       _storage.write('saved_email', savedEmail);
//     }
//
//     Get.offAllNamed('/login');
//   }
//
//   void loadStudentProfile() {
//     String? storedProfile = _storage.read('student_profile');
//     if (storedProfile != null) {
//       _studentProfile = StudentDetailsModel.fromJson(jsonDecode(storedProfile));
//     }
//   }
//
//   //Check Token on startup
//   Future<void> checkTokenOnStartUp() async {
//     await Future.delayed(const Duration(microseconds: 500));
//
//     String? token = accessToken;
//
//     int? loginTime = _storage.read('login_time');
//     if (loginTime != null) {
//       int elapsedSeconds =
//           (DateTime.now().millisecondsSinceEpoch - loginTime) ~/ 1000;
//       if (elapsedSeconds >= 3600) {
//         logout();
//         return;
//       }
//       _startAutoLogoutTimer();
//     }
//
//     if (token == null || !(await isAccessTokenValid(token))) {
//       await refreshAccessToken();
//     } else {
//       isLoggedIn.value = true;
//     }
//   }
//
//   //checking token
//   Future<bool> isAccessTokenValid(String? token) async {
//     return token != null && token.isNotEmpty;
//   }
//
//   //if token expired the refresh
//   Future<void> refreshAccessToken() async {
//     String? refreshToken = _storage.read('refresh_token');
//     if (refreshToken == null) {
//       logout();
//       return;
//     }
//
//     try {
//       final url = Uri.parse("${ServerConfig.baseUrl}/auth/token/refresh/");
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"current_refresh_token": refreshToken}),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         saveSession(data["access_token"], data["refresh_token"],
//             _studentProfile?.toJson() ?? {});
//       } else {
//         logout();
//       }
//     } catch (e) {
//       logout();
//     }
//   }
// }
