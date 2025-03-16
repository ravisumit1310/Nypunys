import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controllers/HwController.dart';
import '../pages/homeworkAndTasks.dart';

class HomeworkListView extends StatelessWidget {
  final HomeworkController homeworkController = Get.find<HomeworkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeworkController.homeworkList.isEmpty) {
        return const Center(child: Text("No homework available"));
      }

      return ListView.builder(
        itemCount: homeworkController.homeworkList.length,
        itemBuilder: (context, index) {
          final homework = homeworkController.homeworkList[index];
          return HomeworkCard(homework: homework);
        },
      );
    });
  }
}
