import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:academyapp/views/widget/BaseScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/logincontroller.dart';
import '../../controllers/resultController.dart';
import '../../controllers/studentData_Controller.dart';
import '../../utils/appTheme.dart';
import '../widget/examList.dart';
import '../widget/examOverall.dart';

class ExamResultsScreen extends StatelessWidget {
  final ExamResultsController controller = Get.put(ExamResultsController());
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.height;

    final student = studentController.student.value;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.uniqueExamDates.isEmpty) {
          return const BaseScreen(
            title: "Exam Report",
            child: Center(child: Text("No exam results available.")),
          );
        }

        return Column(
          children: [
            Stack(
              children: [
                Container(
                  height: screenHeight * 0.28,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/topSectioin.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: -screenWidth * 0.4,
                  right: 0,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.blue,
                      )),
                ),
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: OverallPerformanceWidget(
                        averageMarks: controller.averageMarks.value),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Bottom White Card for List
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Container(
                  width: double.infinity,
                  // color: Colors.white,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hi ${student?.name}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " Your Results...",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ExamListWidget(controller: controller)
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

// class ExamResultsScreen extends StatelessWidget {
//   final ExamResultsController controller = Get.put(ExamResultsController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(
//         title: "Student Results",
//         showBackButton: true,
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (controller.uniqueExamDates.isEmpty) {
//           return Center(child: Text("No exam results available."));
//         }
//
//         return SingleChildScrollView(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             children: [
//               SizedBox(height: 10),
//               OverallPerformanceWidget(
//                   averageMarks: controller.averageMarks.value),
//               SizedBox(height: 20),
//               SizedBox(height: 20),
//               ExamListWidget(controller: controller),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
