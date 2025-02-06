import 'package:academyapp/controllers/sessionController.dart';
import 'package:get/get.dart';

import '../models/studentDetails_Model.dart';
import '../utils/apicServices.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class StudentController extends GetxController {
  Rx<StudentDetailsModel?> student = Rx<StudentDetailsModel?>(null);
  RxBool isLoading = false.obs;

  Future<void> fetchStudentDetails() async {
    try {
      isLoading.value = true;

      final apiService = Get.find<ApiService>();

      final response = await apiService.get("/student/profile/");

      if (response is Map && response.containsKey("error")) {
        Get.snackbar("Error", response["error"]);
        return;
      }

      student.value = StudentDetailsModel.fromJson(response);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> fetchStudentDetails() async {
  //   try {
  //     isLoading.value = true;
  //
  //     final accessToken = Get.find<SessionController>().accessToken;
  //
  //     if (accessToken == null) {
  //       Get.snackbar("Error", "Student is not authenticated");
  //       return;
  //     }
  //
  //     final url = Uri.parse("${ServerConfig.baseUrl}/student/profile/");
  //
  //     final response = await http.get(
  //       url,
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //         ...ServerConfig.defaultHeaders,
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final jsonData = jsonDecode(response.body);
  //       print(jsonData);
  //       student.value = StudentDetailsModel.fromJson(jsonData);
  //       print(student.value);
  //     } else {
  //       Get.snackbar("Error", "Failed to fetch student details");
  //     }
  //   } catch (e) {
  //     print("Error fetching student details: $e");
  //     Get.snackbar("Error", "Something went wrong");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
