import 'package:get/get.dart';
import '../models/resultModel.dart';
import '../utils/apicServices.dart';

class ExamResultsController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<ResultModel?> resultData = Rx<ResultModel?>(null);
  RxList<String> uniqueExamDates = <String>[].obs;
  RxDouble averageMarks = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchExamResults();
  }

  Future<void> fetchExamResults() async {
    try {
      isLoading.value = true;
      final apiService = Get.find<ApiService>();
      final response = await apiService.get("/student/student-results/");
      print("Result here--- $response");

      if (response is Map && response.containsKey("error")) {
        print("error result -- $response");
        Get.snackbar("Error", response["error"]);
        return;
      }

      final data = ResultModel.fromJson(response);
      resultData.value = data;

      // Extract unique exam dates
      uniqueExamDates.value =
          data.results.map((result) => result.examDate).toSet().toList();

      // ✅ Compute the average marks
      calculateAverageMarks();
    } catch (e) {
      print("error result -- $e");
      Get.snackbar("Error", "Failed to load exam results");
    } finally {
      isLoading.value = false;
    }
  }

  void calculateAverageMarks() {
    if (resultData.value == null || resultData.value!.results.isEmpty) {
      averageMarks.value = 0.0;
      return;
    }

    double totalMarks =
        resultData.value!.results.fold(0.0, (sum, item) => sum + item.marks);
    int subjectCount = resultData.value!.results.length;

    averageMarks.value = subjectCount > 0 ? totalMarks / subjectCount : 0.0;
  }

  List<Results> getResultsByDate(String date) {
    return resultData.value?.results
            .where((result) => result.examDate == date)
            .toList() ??
        [];
  }

  //for showing the avg % in the graph
  double getExamPercentage(String examDate) {
    List<Results> examResults = getResultsByDate(examDate);

    if (examResults.isEmpty) return 0.0;

    double totalMarks = examResults.fold(0.0, (sum, item) => sum + item.marks);
    int subjectCount = examResults.length;

    return (subjectCount > 0) ? (totalMarks / subjectCount) : 0.0;
  }
}
