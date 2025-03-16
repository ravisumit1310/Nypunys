import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controllers/quizController.dart';
import '../../models/quizModel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/quizController.dart';
import '../../models/quizModel.dart';

class QuizDetailScreen extends StatelessWidget {
  final Quiz quiz;

  const QuizDetailScreen({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    final QuizController quizController =
        Get.put(QuizController(), tag: 'quiz_${quiz.id}');

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: RefreshIndicator(
        onRefresh: () async {
          await quizController.fetchQuizzes();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(quiz.question, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              Obx(() => Column(
                    children: List.generate(quiz.options.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          if (!quizController.isSubmitted.value) {
                            quizController.submitAnswer(quiz.id, index);
                          }
                        },
                        child: Card(
                          color: quizController.isSubmitted.value
                              ? (quizController.selectedOption.value == index
                                  ? (quizController.isCorrect.value
                                      ? Colors.green
                                      : Colors.red)
                                  : Colors.white)
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(quiz.options[index].text, // Fix this line
                                    style: const TextStyle(fontSize: 16)),
                                if (quizController.isSubmitted.value)
                                  Icon(
                                    quizController.selectedOption.value == index
                                        ? (quizController.isCorrect.value
                                            ? Icons.check
                                            : Icons.close)
                                        : null,
                                    color: Colors.white,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

// class QuizDetailScreen extends StatelessWidget {
//   final Quiz quiz;
//
//   const QuizDetailScreen({super.key, required this.quiz});
//
//   @override
//   Widget build(BuildContext context) {
//     final QuizController quizController =
//         Get.put(QuizController(), tag: 'quiz_${quiz.id}');
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Quiz")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(quiz.question, style: const TextStyle(fontSize: 18)),
//             const SizedBox(height: 20),
//             Obx(() => Column(
//                   children: List.generate(quiz.options.length, (index) {
//                     return GestureDetector(
//                       onTap: () {
//                         if (!quizController.isSubmitted.value) {
//                           quizController.submitAnswer(quiz.id, index);
//                         }
//                       },
//                       child: Card(
//                         color: quizController.isSubmitted.value
//                             ? (quizController.selectedOption.value == index
//                                 ? (quizController.isCorrect.value
//                                     ? Colors.green
//                                     : Colors.red)
//                                 : Colors.white)
//                             : Colors.white,
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(quiz.options[index].toString(),
//                                   style: const TextStyle(fontSize: 16)),
//                               if (quizController.isSubmitted.value)
//                                 Icon(
//                                   quizController.selectedOption.value == index
//                                       ? (quizController.isCorrect.value
//                                           ? Icons.check
//                                           : Icons.close)
//                                       : null,
//                                   color: Colors.white,
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
