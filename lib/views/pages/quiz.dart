import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controllers/quizController.dart';
import '../../models/quizModel.dart';
import '../widget/quizDetails.dart';

// class QuizListScreen extends StatelessWidget {
//   final QuizController quizController = Get.put(QuizController());
//
//   QuizListScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Quizzes")),
//       body: Obx(() => ListView.builder(
//             itemCount: quizController.quizzes.length,
//             itemBuilder: (context, index) {
//               final quiz = quizController.quizzes[index];
//               return ListTile(
//                 title: Text(quiz.question),
//                 trailing: Icon(Icons.arrow_forward_ios),
//                 onTap: () {
//                   Get.to(() => QuizDetailScreen(quiz: quiz));
//                 },
//               );
//             },
//           )),
//     );
//   }
// }

class QuizListScreen extends StatelessWidget {
  final QuizController quizController = Get.put(QuizController());

  QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quizzes")),
      body: Obx(() => ListView.builder(
            itemCount: quizController.quizzes.length,
            itemBuilder: (context, index) {
              final quiz = quizController.quizzes[index];

              // Determine the icon based on submission_status
              IconData icon;
              Color iconColor;
              if (quiz.submissionStatus == "correct") {
                icon = Icons.check_circle;
                iconColor = Colors.green;
              } else if (quiz.submissionStatus == "incorrect") {
                icon = Icons.cancel;
                iconColor = Colors.red;
              } else {
                icon = Icons.hourglass_empty;
                iconColor = Colors.grey;
              }

              return ListTile(
                title: Text(quiz.question),
                trailing: Icon(icon, color: iconColor),
                onTap: () {
                  Get.to(() => QuizDetailScreen(quiz: quiz));
                },
              );
            },
          )),
    );
  }
}
