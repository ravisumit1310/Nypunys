import 'package:get/get.dart';
import '../models/quizModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/apicServices.dart';

class QuizController extends GetxController {
  RxList<Quiz> quizzes = <Quiz>[].obs;
  RxInt selectedOption = (-1).obs;
  RxBool isSubmitted = false.obs;
  RxBool isCorrect = false.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuizzes();
  }

  Future<void> fetchQuizzes() async {
    try {
      isLoading.value = true;
      final apiService = Get.find<ApiService>();
      final response = await apiService.get("/class/student/quizzes");
      print("this is the quizzes $response");

      if (response != null && response.containsKey("quizzes")) {
        quizzes.value = (response["quizzes"] as List)
            .map((quiz) => Quiz.fromJson(quiz))
            .toList();
      } else {
        Get.snackbar("Error", "Failed to load quizzes");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false; // Hide loading state
    }
  }

  Future<void> submitAnswer(int quizId, int optionIndex) async {
    try {
      isSubmitted.value = true;
      selectedOption.value = optionIndex;

      final apiService = Get.find<ApiService>();

      final response = await apiService.post(
        "/class/submit",
        {
          "quiz_id": quizId,
          "selected_option_index": optionIndex,
        },
      );
      print("this is the results submitted --  $response");

      print("This is the submit $response");

      if (response != null && response.containsKey("is_correct")) {
        isCorrect.value = response['is_correct'];
      } else {
        Get.snackbar("Error", "Invalid response from server");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
}
