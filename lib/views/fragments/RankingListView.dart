import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controllers/HwController.dart';

class RankingListView extends StatelessWidget {
  final HomeworkController homeworkController = Get.find<HomeworkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeworkController.rankingList.isEmpty) {
        return const Center(child: Text("No ranking data available"));
      }

      return ListView.builder(
        itemCount: homeworkController.rankingList.length,
        itemBuilder: (context, index) {
          final ranking = homeworkController.rankingList[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(ranking.rank.toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              title: Text(ranking.studentName.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Total Marks: ${ranking.totalMarks}"),
            ),
          );
        },
      );
    });
  }
}
