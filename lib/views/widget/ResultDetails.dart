import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../controllers/resultController.dart';
import '../../models/resultModel.dart';
import 'package:intl/intl.dart';

class ExamDetailScreen extends StatelessWidget {
  final String examDate;
  final ExamResultsController controller = Get.find();

  ExamDetailScreen({required this.examDate});

  @override
  Widget build(BuildContext context) {
    List<Results> results = controller.getResultsByDate(examDate);
    String formattedDate =
        DateFormat("dd MMM yyyy").format(DateTime.parse(examDate));

    return Scaffold(
      appBar: AppBar(
        title: Text("Results - $formattedDate"),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.refreshCw),
            onPressed: () {
              controller.fetchExamResults(); // Reloads the data
              Get.snackbar("Reload", "Refreshing Report...");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Report Title
            Text(
              "Exam Report",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Subject-Wise Report
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  var subject = results[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Subject Name & Date (Left)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                subject.subject,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),

                          // Marks & Percentage (Right)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${subject.marks} / ${subject.totalMarks}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: getColorForMarks(subject.marks),
                                ),
                              ),
                              Text(
                                "${subject.percentage.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: getColorForMarks(subject.marks),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Divider Line After Each Subject
                      Divider(
                          color: Colors.grey[300], thickness: 1, height: 20),
                    ],
                  );
                },
              ),
            ),

            // Action Buttons (Download, Recheck)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon:
                      Icon(LucideIcons.download, size: 28, color: Colors.blue),
                  onPressed: () {
                    Get.snackbar("Download", "Downloading Report...");
                  },
                ),
                IconButton(
                  icon: Icon(LucideIcons.checkCircle,
                      size: 28, color: Colors.orange),
                  onPressed: () {
                    Get.snackbar("Recheck", "Requesting Recheck...");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Color Based on Marks
  Color getColorForMarks(double marks) {
    if (marks < 20) return Colors.red[900]!; // Dark Red
    if (marks < 40) return Colors.red; // Red
    if (marks < 60) return Colors.orange; // Yellowish
    if (marks < 80) return Colors.green; // Green
    if (marks < 95) return Colors.green[700]!; // Dark Green
    return Colors.amber[700]!; // Golden
  }
}

// class ExamDetailScreen extends StatelessWidget {
//   final String examDate;
//   final ExamResultsController controller = Get.find();
//
//   ExamDetailScreen({required this.examDate});
//
//   @override
//   Widget build(BuildContext context) {
//     List<Results> results = controller.getResultsByDate(examDate);
//
//     return Scaffold(
//       appBar: AppBar(title: Text("Results for $examDate")),
//       body: ListView.builder(
//         itemCount: results.length,
//         itemBuilder: (context, index) {
//           var subject = results[index];
//
//           return Card(
//             child: ListTile(
//               title: Text(subject.subject),
//               subtitle: Text(
//                 "Marks: ${subject.marks} / ${subject.totalMarks}\n"
//                 "Percentage: ${subject.percentage}%",
//               ),
//               leading: Icon(Icons.school),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
