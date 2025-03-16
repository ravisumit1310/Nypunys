import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/resultController.dart';
import '../widget/examList.dart';
import '../widget/examOverall.dart';

class ExamResultsScreen extends StatelessWidget {
  final ExamResultsController controller = Get.put(ExamResultsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Student Results",
        showBackButton: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.uniqueExamDates.isEmpty) {
          return Center(child: Text("No exam results available."));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 10),
              OverallPerformanceWidget(
                  averageMarks: controller.averageMarks.value),
              SizedBox(height: 20),
              SizedBox(height: 20),
              ExamListWidget(controller: controller),
            ],
          ),
        );
      }),
    );
  }
}
