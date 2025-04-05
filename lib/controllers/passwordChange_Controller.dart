import 'package:academyapp/utils/apicServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProfileUpdateController extends GetxController {
  final emailController = TextEditingController();
  final contactNoController = TextEditingController();
  final whatsappController = TextEditingController();
  final addressController = TextEditingController();
  final fathersEmailController = TextEditingController();
  final fathersMobileController = TextEditingController();
  final mothersMobileController = TextEditingController();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  RxBool isUpdating = false.obs;
  RxBool isChangingPassword = false.obs;

  Future<bool> updateProfile(String fieldKey, String newValue) async {
    final apiService = Get.find<ApiService>();

    final body = {
      "email": emailController.text.trim(),
      "contact_no": contactNoController.text.trim(),
      "whatsapp_no": whatsappController.text.trim(),
      "contact_address": addressController.text.trim(),
      "fathers_email": fathersEmailController.text.trim(),
      "fathers_mobile": fathersMobileController.text.trim(),
      "mothers_mobile": mothersMobileController.text.trim(),
    };

    try {
      isUpdating.value = true;

      final resp = await apiService.put("/student/update-profile", body);

      isUpdating.value = false;

      return resp != null && resp["error"] == null;
    } catch (e) {
      isUpdating.value = false;
      print("❌ Update Profile Error: $e");
      return false;
    }
  }

  // 🔐 Change password only
  Future<bool> changePassword() async {
    final apiService = Get.find<ApiService>();

    final body = {
      "old_password": oldPasswordController.text.trim(),
      "new_password": newPasswordController.text.trim(),
    };

    try {
      isChangingPassword.value = true;

      final resp = await apiService.put("/student/update-profile", body);

      isChangingPassword.value = false;

      if (resp != null && resp["error"] == null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      isChangingPassword.value = false;
      print("❌ Change Password Error: $e");
      return false;
    }
  }
}

// class PasswordChangeController extends GetxController {
//   final oldPasswordController = TextEditingController();
//   final newPasswordController = TextEditingController();
//   RxBool isLoading = false.obs;
//
//   Future<bool> changePassword(String oldPassword, String newPassword) async {
//     final apiService = Get.find<ApiService>();
//
//     if (oldPassword.isEmpty || newPassword.isEmpty) return false;
//
//     try {
//       final body = {
//         "old_password": oldPassword,
//         "new_password": newPassword,
//       };
//
//       final resp = await apiService.put("/student/update-profile", body);
//
//       if (resp != null && resp["error"] == null) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print("❌ Change Password Error: $e");
//       return false;
//     }
//   }
// }
