import 'package:academyapp/controllers/sessionController.dart';
import 'package:get/get.dart';

import '../models/attendance_Model.dart';
import '../utils/apicServices.dart';

class AttendanceController extends GetxController {
  final sessionController = Get.find<SessionController>();
  RxBool isLoading = false.obs;
  Rx<AttendanceModel?> attendanceData = Rx<AttendanceModel?>(null);

  @override
  void onInit() {
    super.onInit();
    print("Fetching attendance...");

    ever(sessionController.studentProfile.obs, (_) {
      fetchAttendance();
    });

    fetchAttendance();
  }

  Future<void> fetchAttendance() async {
    try {
      isLoading.value = true;
      final apiService = Get.find<ApiService>();

      final studentId = sessionController.studentProfile?.id;
      print("Student ID from session ----------->  $studentId");

      if (studentId == null) {
        Get.snackbar("Error", "Student ID not found in session");
        return;
      }

      final response = await apiService.get("/student/attendance/$studentId");
      print("Raw API Response ----> ${response.runtimeType} - $response");

      if (response == null) {
        print("❌ API returned NULL response!");
      } else if (response is Map<String, dynamic>) {
        print("✅ Valid response received, parsing...");
        attendanceData.value = AttendanceModel.fromJson(response);
        print("Parsed Attendance Data: ${attendanceData.value}");
      } else {
        print("⚠️ Unexpected API response type: ${response.runtimeType}");
      }
    } catch (e) {
      print("Exception Caught ----> $e");
      Get.snackbar("Error", "Failed to load attendance");
    } finally {
      isLoading.value = false;
    }
  }
}

// class AttendanceController extends GetxController {
//   final sessionController = Get.find<SessionController>();
//   RxBool isLoading = false.obs;
//   Rx<AttendanceModel?> attendanceData = Rx<AttendanceModel?>(null);
//
//   @override
//   void onInit() {
//     super.onInit();
//     print("Fetching attendance...");
//     fetchAttendance();
//   }
//
//   Future<void> fetchAttendance() async {
//     try {
//       isLoading.value = true;
//       final apiService = Get.find<ApiService>();
//
//       final studentId = sessionController.studentProfile?.id;
//       print("Student ID from session ----------->  $studentId");
//
//       if (studentId == null) {
//         Get.snackbar("Error", "Student ID not found in session");
//         return;
//       }
//
//       final response = await apiService.get("/student/attendance/$studentId");
//       print("Raw API Response ----> ${response.runtimeType} - $response");
//
//       if (response == null) {
//         print("❌ API returned NULL response!");
//       } else if (response is Map<String, dynamic>) {
//         print("✅ Valid response received, parsing...");
//         attendanceData.value = AttendanceModel.fromJson(response);
//         print("Parsed Attendance Data: ${attendanceData.value}");
//       } else {
//         print("⚠️ Unexpected API response type: ${response.runtimeType}");
//       }
//     } catch (e) {
//       print("Exception Caught ----> $e");
//       Get.snackbar("Error", "Failed to load attendance");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
