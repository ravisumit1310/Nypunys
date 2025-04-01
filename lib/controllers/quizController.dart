import 'package:get/get.dart';
import '../models/quizModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/apicServices.dart';

import 'dart:async';

class QuizController extends GetxController {
  RxList<Quiz> quizzes = <Quiz>[].obs;
  RxInt selectedOption = (-1).obs;
  RxBool isSubmitted = false.obs;
  RxBool isCorrect = false.obs;
  RxBool isLoading = true.obs;
  RxInt currentQuestionIndex = 0.obs;
  RxInt timeLeft = 30.obs; // 30 seconds countdown (Modify as needed)
  Timer? _timer; // Timer instance

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
        currentQuestionIndex.value = 0;
        resetTimer(); // Start timer when quizzes are loaded
      } else {
        Get.snackbar("Error", "Failed to load quizzes");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  void resetTimer() {
    _timer?.cancel(); // Cancel existing timer
    timeLeft.value = 30; // Reset to 30 seconds
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        timer.cancel();
        // Handle timeout (e.g., auto-submit, move to next question)
        nextQuestion();
      }
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < quizzes.length - 1) {
      currentQuestionIndex.value++;
      selectedOption.value = -1;
      isSubmitted.value = false;
      isCorrect.value = false;
      resetTimer(); // Restart timer for next question
    } else {
      _timer?.cancel(); // Stop timer when quiz ends
    }
  }

  Future<void> submitAnswer(int quizId, int optionIndex) async {
    try {
      isSubmitted.value = true;
      selectedOption.value = optionIndex;
      _timer?.cancel(); // Stop timer when user submits

      final apiService = Get.find<ApiService>();
      final response = await apiService.post(
        "/class/submit",
        {
          "quiz_id": quizId,
          "selected_option_index": optionIndex,
        },
      );
      print("this is the results submitted --  $response");

      if (response != null && response.containsKey("is_correct")) {
        isCorrect.value = response['is_correct'];
      } else {
        Get.snackbar("Error", "Invalid response from server");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel timer when controller is destroyed
    super.onClose();
  }
}

// class QuizController extends GetxController {
//   RxList<Quiz> quizzes = <Quiz>[].obs;
//   RxInt selectedOption = (-1).obs;
//   RxBool isSubmitted = false.obs;
//   RxBool isCorrect = false.obs;
//   RxBool isLoading = true.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchQuizzes();
//   }
//
//   Future<void> fetchQuizzes() async {
//     try {
//       isLoading.value = true;
//       final apiService = Get.find<ApiService>();
//       final response = await apiService.get("/class/student/quizzes");
//       print("this is the quizzes $response");
//
//       if (response != null && response.containsKey("quizzes")) {
//         quizzes.value = (response["quizzes"] as List)
//             .map((quiz) => Quiz.fromJson(quiz))
//             .toList();
//       } else {
//         Get.snackbar("Error", "Failed to load quizzes");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Something went wrong");
//     } finally {
//       isLoading.value = false; // Hide loading state
//     }
//   }
//
//   Future<void> submitAnswer(int quizId, int optionIndex) async {
//     try {
//       isSubmitted.value = true;
//       selectedOption.value = optionIndex;
//
//       final apiService = Get.find<ApiService>();
//
//       final response = await apiService.post(
//         "/class/submit",
//         {
//           "quiz_id": quizId,
//           "selected_option_index": optionIndex,
//         },
//       );
//       print("this is the results submitted --  $response");
//
//       print("This is the submit $response");
//
//       if (response != null && response.containsKey("is_correct")) {
//         isCorrect.value = response['is_correct'];
//       } else {
//         Get.snackbar("Error", "Invalid response from server");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Something went wrong: $e");
//     }
//   }
// }
