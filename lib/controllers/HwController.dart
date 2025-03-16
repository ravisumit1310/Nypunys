import 'package:academyapp/controllers/studentData_Controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/HwModel.dart';
import '../models/rankingModel.dart';
import '../utils/apicServices.dart';

class HomeworkController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Homework> homeworkList = <Homework>[].obs;
  RxList<StudentRank> rankingList = <StudentRank>[].obs;
  RxBool showHomework = true.obs;

  final StudentController studentController = Get.put(StudentController());

  @override
  void onInit() {
    super.onInit();
    fetchHomework();
    fetchRankings();
  }

  Future<void> fetchHomework() async {
    try {
      isLoading.value = true;
      final apiService = Get.find<ApiService>();
      final response = await apiService.get("/student/student/homework");
      print("Here is the Homeworks$response");

      if (response is List) {
        homeworkList.value =
            response.map((hw) => Homework.fromJson(hw)).toList();
      }
    } catch (e) {
      print("Error fetching homework: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRankings() async {
    try {
      isLoading.value = true;
      int classId = studentController.student.value?.classId ?? 0;
      final apiService = Get.find<ApiService>();
      final response =
          await apiService.get("/student/homework/rankings/$classId");
      print("Rankings: $response");

      if (response is List) {
        rankingList.value =
            response.map((r) => StudentRank.fromJson(r)).toList();
      }
    } catch (e) {
      print("Error fetching rankings: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void toggleView() {
    showHomework.value = !showHomework.value;
  }
}
