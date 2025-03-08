import 'package:get/get.dart';
import '../models/ttModel.dart';
import '../utils/apicServices.dart';

class TimetableController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Timetable> timetable = <Timetable>[].obs;
  RxString selectedDay = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchTimetable();
  }

  Future<void> fetchTimetable() async {
    try {
      isLoading.value = true;
      final apiService = Get.find<ApiService>();
      final response = await apiService.get("/student/get_time_table/");

      print("tt Response ----> $response");

      if (response is Map && response.containsKey("error")) {
        Get.snackbar("Error", response["error"]);
        return;
      }

      final data = TtModel.fromJson(response);

      timetable.value = data.timetable.cast<Timetable>().obs;

      // Set default selected day
      if (timetable.isNotEmpty) {
        selectedDay.value = timetable.first.day;
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load timetable");
    } finally {
      isLoading.value = false;
    }
  }

  // Filter timetable based on selected day
  List<Timetable> getFilteredTimetable() {
    return timetable.where((item) => item.day == selectedDay.value).toList();
  }

  // Update selected day
  void changeDay(String newDay) {
    selectedDay.value = newDay;
  }
}

// class TimetableController extends GetxController {
//   RxList<dynamic> timetable = <dynamic>[].obs;
//   RxBool isLoading = false.obs;
//
//   Future<void> fetchTimetable() async {
//     try {
//       isLoading.value = true;
//       final apiService = Get.find<ApiService>();
//
//       final response = await apiService.get("/student/get_time_table/");
//
//       if (response is Map && response.containsKey("timetable")) {
//         timetable.assignAll(response["timetable"]);
//       } else {
//         Get.snackbar("Error", "Failed to load timetable");
//       }
//     } catch (e) {
//       print("error -- e + $e");
//       Get.snackbar("Error", "Something went wrong");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchTimetable();
//   }
// }
