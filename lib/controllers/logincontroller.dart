import 'package:academyapp/controllers/sessionController.dart';
import 'package:get/get.dart';
import 'package:academyapp/utils/apicServices.dart';

import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final sessionController = Get.find<SessionController>();
  final storage = GetStorage();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadEmail();
  }

  // Load saved email when the app starts
  void loadEmail() {
    String? savedEmail = storage.read('saved_email');
    if (savedEmail != null && savedEmail.isNotEmpty) {
      emailController.text = savedEmail;
      rememberMe.value = true;
    }
  }

  void saveEmail() {
    if (rememberMe.value) {
      storage.write('saved_email', emailController.text.trim());
    } else {
      storage.remove('saved_email');
    }
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  Future<bool> login() async {
    final apiService = Get.find<ApiService>();

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showSnackbar("Error", "Email and password cannot be empty.", Colors.red);
      return false;
    }

    try {
      var resp = await apiService.post('/student/login/', {
        'id': email,
        'password': password,
      });

      if (resp != null && resp.containsKey('access_token')) {
        sessionController.saveSession(
          resp['access_token'],
          resp['refresh_token'],
          resp['student_profile'],
        );
        print("Login response == > $resp");
        saveEmail();
        return true;
      } else {
        showSnackbar(
            "Login Failed", "Invalid credentials or server error.", Colors.red);
        return false;
      }
    } catch (e) {
      showSnackbar("Login Error", e.toString(), Colors.red);
      return false;
    }
  }

  void showSnackbar(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      backgroundColor: color,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(10),
      borderRadius: 10,
    );
  }
}
