import 'package:get/get.dart';

import '../models/studentDetails_Model.dart';
import '../utils/apicServices.dart';

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
      Get.snackbar("Error", "$e");
    } finally {
      isLoading.value = false;
    }
  }
}
