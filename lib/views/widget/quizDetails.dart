import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controllers/quizController.dart';
import '../../models/quizModel.dart';
import '../../utils/appTheme.dart';
import '../fragments/quizTile.dart';

class QuizDetailScreen extends StatelessWidget {
  final Quiz quiz;

  const QuizDetailScreen({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    final QuizController quizController =
        Get.put(QuizController(), tag: 'quiz_${quiz.id}');
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                  const Text('Play Quiz',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Skip',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Timer Bar
              Obx(() {
                double progress = quizController.timeLeft.value / 30;
                return Stack(
                  children: [
                    Container(
                      height: 30,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      height: 30,
                      width: screenWidth * progress,
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          '${quizController.timeLeft.value} Sec',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),

              const SizedBox(height: 10),

              Obx(() => Text(
                    'Question ${quizController.currentQuestionIndex.value + 1} / ${quizController.quizzes.length}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.surface,
                    ),
                  )),

              const SizedBox(height: 16),

              // Quiz Card
              Expanded(
                child: Container(
                  width: screenWidth * 0.95,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white, // White card background
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question
                      Text(
                        quiz.question,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      // Options List
                      Obx(() => Column(
                            children:
                                List.generate(quiz.options.length, (index) {
                              bool isSelected =
                                  quizController.selectedOption.value == index;
                              bool isCorrect = quizController.isCorrect.value;

                              return GestureDetector(
                                onTap: () {
                                  if (!quizController.isSubmitted.value &&
                                      quizController.timeLeft.value > 0) {
                                    quizController.submitAnswer(quiz.id, index);
                                  }
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 6.0),
                                  padding: const EdgeInsets.all(14.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? (isCorrect
                                            ? Colors.green[400]
                                            : Colors.red[400])
                                        : Colors
                                            .grey[200], // Default light color
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          quiz.options[index].text,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? Colors
                                                    .white // White text when selected
                                                : Colors
                                                    .black, // Black otherwise
                                          ),
                                        ),
                                      ),
                                      if (isSelected) // Show icons only if selected
                                        Icon(
                                          isCorrect
                                              ? Icons.check_circle
                                              : Icons.cancel,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )),
                    ],
                  ),
                ),
              ),
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
//       body: RefreshIndicator(
//         onRefresh: () async {
//           await quizController.fetchQuizzes();
//         },
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(quiz.question, style: const TextStyle(fontSize: 18)),
//               const SizedBox(height: 20),
//               Obx(() => Column(
//                     children: List.generate(quiz.options.length, (index) {
//                       return GestureDetector(
//                         onTap: () {
//                           if (!quizController.isSubmitted.value) {
//                             quizController.submitAnswer(quiz.id, index);
//                           }
//                         },
//                         child: Card(
//                           color: quizController.isSubmitted.value
//                               ? (quizController.selectedOption.value == index
//                                   ? (quizController.isCorrect.value
//                                       ? Colors.green
//                                       : Colors.red)
//                                   : Colors.white)
//                               : Colors.white,
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(quiz.options[index].text, // Fix this line
//                                     style: const TextStyle(fontSize: 16)),
//                                 if (quizController.isSubmitted.value)
//                                   Icon(
//                                     quizController.selectedOption.value == index
//                                         ? (quizController.isCorrect.value
//                                             ? Icons.check
//                                             : Icons.close)
//                                         : null,
//                                     color: Colors.white,
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
