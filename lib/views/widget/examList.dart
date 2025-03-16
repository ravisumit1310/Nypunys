import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/resultController.dart';
import 'ResultDetails.dart';

class ExamListWidget extends StatelessWidget {
  final ExamResultsController controller;

  const ExamListWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controller.uniqueExamDates.map((examDate) {
        double examPercentage = controller.getExamPercentage(examDate);
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title: Text("Exam Date: $examDate",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle:
                Text("Total Percentage: ${examPercentage.toStringAsFixed(2)}%"),
            onTap: () {
              Get.to(() => ExamDetailScreen(examDate: examDate));
            },
          ),
        );
      }).toList(),
    );
  }
}
