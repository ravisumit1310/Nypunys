import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/studentDetails_Model.dart';
import '../utils/apicServices.dart';

import 'package:http/http.dart' as http;

class StudentController extends GetxController {
  Rx<StudentDetailsModel?> student = Rx<StudentDetailsModel?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudentDetails();
  }

  Future<void> fetchStudentDetails() async {
    isLoading.value = true;
    try {
      final apiService = Get.find<ApiService>();
      final response = await apiService.get("/student/profile/");

      if (response is Map && response.containsKey("error")) {
        print("Error in Student Data Controller --- ${response["error"]}");
        Future.delayed(Duration.zero, () {
          Get.snackbar("Error", response["error"]);
        });
      } else {
        student.value = StudentDetailsModel.fromJson(response);
      }
    } catch (e) {
      print("Error in Student Data Controller --- $e");
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", "$e");
      });
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading.value = false;
      });
    }
  }

// Future<void> fetchStudentDetails() async {
  //   try {
  //     isLoading.value = true;
  //     final apiService = Get.find<ApiService>();
  //     final response = await apiService.get("/student/profile/");
  //     if (response is Map && response.containsKey("error")) {
  //       Future.delayed(Duration.zero, () {
  //         Get.snackbar("Error", response["error"]);
  //         print(
  //             "Error in the Student Data Controller --- ${response["error"]}");
  //       });
  //       return;
  //     }
  //     student.value = StudentDetailsModel.fromJson(response);
  //   } catch (e) {
  //     Future.delayed(Duration.zero, () {
  //       Get.snackbar("Error", "$e");
  //       print("Error in the Student Data Controller --- $e");
  //     });
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
