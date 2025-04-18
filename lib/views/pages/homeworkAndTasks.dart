import 'package:academyapp/utils/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/HwController.dart';
import '../../models/HwModel.dart';
import '../fragments/RankingListView.dart';
import '../widget/BaseScreen.dart';

class HomeworkRankingPage extends StatelessWidget {
  final HomeworkController homeworkController = Get.put(HomeworkController());

  HomeworkRankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "HomeWork & Rankings",
      floatingActionButton: Obx(() => FloatingActionButton.extended(
            onPressed: () {
              homeworkController.toggleView();
            },
            label: Text(homeworkController.showHomework.value
                ? "View Rankings"
                : "View Homework"),
            icon: Icon(homeworkController.showHomework.value
                ? Icons.leaderboard
                : Icons.book),
            backgroundColor: Colors.blueAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          )),
      child: Obx(() {
        if (homeworkController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: homeworkController.showHomework.value
              ? HomeworkListView()
              : RankingListView(),
        );
      }),
    );

    // return Scaffold(
    //   backgroundColor: Colors.blue[50],
    //   appBar: AppBar(
    //     backgroundColor: Colors.blue,
    //     leading: IconButton(
    //       icon: Icon(Icons.arrow_back, color: Colors.white),
    //       onPressed: () => Get.back(),
    //     ),
    //     title:
    //         Text('HomeWork & Rankings', style: TextStyle(color: Colors.white)),
    //   ),
    //   body: Obx(() {
    //     if (homeworkController.isLoading.value) {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //     return Padding(
    //       padding: const EdgeInsets.all(16.0),
    //       child: homeworkController.showHomework.value
    //           ? HomeworkListView()
    //           : RankingListView(),
    //     );
    //   }),
    //   floatingActionButton: Obx(() => FloatingActionButton.extended(
    //         onPressed: () {
    //           homeworkController.toggleView();
    //         },
    //         label: Text(homeworkController.showHomework.value
    //             ? "View Rankings"
    //             : "View Homework"),
    //         icon: Icon(homeworkController.showHomework.value
    //             ? Icons.leaderboard
    //             : Icons.book),
    //         backgroundColor: Colors.blueAccent,
    //         shape:
    //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    //       )),
    // );
  }
}

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

class HomeworkCard extends StatelessWidget {
  final Homework homework;

  const HomeworkCard({super.key, required this.homework});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                homework.subject.toString(),
                style: TextStyle(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              homework.description.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Assign Date',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Text(
                  homework.assignedDate.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Last Submission Date',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                // Text(
                //   homework.lastSubmissionDate,
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 14,
                //     fontWeight: FontWeight.w500,
                //   ),
                //),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 36),
              ),
              child: Text(
                'TO BE SUBMITTED',
                style: TextStyle(
                  color: AppColors.surface,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
