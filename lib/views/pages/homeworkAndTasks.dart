import 'package:academyapp/views/fragments/appbarFrag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/HwController.dart';
import '../../models/HwModel.dart';
import '../fragments/HomeworkListView.dart';
import '../fragments/RankingListView.dart';
import '../widget/HwCard.dart';

class HomeworkRankingPage extends StatelessWidget {
  final HomeworkController homeworkController = Get.put(HomeworkController());

  HomeworkRankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "HomeWork & Rankings",
        showBackButton: true,
      ),
      body: Obx(() {
        if (homeworkController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return homeworkController.showHomework.value
            ? HomeworkListView()
            : RankingListView();
      }),
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
    );
  }
}

class HomeworkCard extends StatelessWidget {
  final Homework homework;

  const HomeworkCard({super.key, required this.homework});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => HomeworkDetailPopup(homework: homework),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.book, color: Colors.white),
          ),
          title: Text(homework.subject.toString(),
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(homework.description.toString()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Chip(
                label: Text(homework.status.toString()),
                backgroundColor: getStatusColor(homework.status.toString()),
              ),
              SizedBox(width: 8), // Space between chip and icon
              getStatusIcon(homework.status.toString()),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Function to get the status color
  Color? getStatusColor(String status) {
    switch (status) {
      case "PENDING":
        return Colors.yellow[100];
      case "DONE":
        return Colors.green[100];
      case "NOT DONE":
        return Colors.red[100];
      default:
        return Colors.grey[200];
    }
  }

  // ✅ Function to get the corresponding status icon
  Icon getStatusIcon(String status) {
    switch (status) {
      case "PENDING":
        return Icon(Icons.access_time,
            color: Colors.yellow[700]); // Yellow clock
      case "DONE":
        return Icon(Icons.check_circle,
            color: Colors.green[700]); // Green check
      case "NOT DONE":
        return Icon(Icons.error, color: Colors.red[700]); // Red exclamation
      default:
        return Icon(Icons.help_outline, color: Colors.grey); // Default icon
    }
  }
}
