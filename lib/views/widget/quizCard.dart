// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class QuizCard extends StatelessWidget {
//   final QuizController quizController = Get.put(QuizController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Quiz"),
//       ),
//       body: Obx(() {
//         var currentQuestion = quizController.questions[quizController.currentQuestionIndex.value];
//
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//           Text(
//           "Question ${quizController.currentQuestionIndex.value + 1}/${quizController.questions.length}",
//             style: TextStyle(fontSize: 24),
//           ),
//           SizedBox(height: 20),
//           Text(currentQuestion.question,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           SizedBox(height: 20),
//           Expanded(
//             child: Column(
//                 children: List.generate(currentQuestion.options.length, (index) {
//                   return ListTile(
//                     title: Text(currentQuestion.options[index]),
//                     leading: Radio<String>(
//                       value: currentQuestion.options[index],
//                       groupValue: quizController.selectedAnswer.value,
//                       onChanged: (value) {
//                         quizController.selectAnswer(value!);
//                       },
//                     ),
//                   );
//                 })),
//           ),
//         ),
//         ElevatedButton(
//         onPressed: () {
//         quizController.nextQuestion();
//         },
//         child: const Text("Next Question"),
//         ),
//         ],
//         ),
//         );
//         }),
//     );
//   }
// }
