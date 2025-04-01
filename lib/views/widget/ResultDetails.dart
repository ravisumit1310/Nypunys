import 'package:academyapp/views/widget/examOverall.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../controllers/resultController.dart';
import '../../models/resultModel.dart';
import 'package:intl/intl.dart';

import '../../utils/appTheme.dart';

class ExamDetailScreen extends StatelessWidget {
  final String examDate;
  final ExamResultsController controller = Get.find();

  ExamDetailScreen({required this.examDate});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List<Results> results = controller.getResultsByDate(examDate);
    String formattedDate =
        DateFormat("dd MMM yyyy").format(DateTime.parse(examDate));

    // Compute Totals
    double totalObtained = results.fold(0, (sum, item) => sum + item.marks);
    double totalMaxMarks =
        results.fold(0, (sum, item) => sum + item.totalMarks);
    double overallPercentage = (totalObtained / totalMaxMarks) * 100;
    bool isPassed = overallPercentage >= 40;

    return Scaffold(
      body: Container(
        color: AppColors.skyBlue,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: screenHeight * 0.32,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/topSectioin.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon:
                        const Icon(Icons.arrow_back_ios, color: AppColors.blue),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: OverallPerformanceWidget(
                        averageMarks: overallPercentage),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Exam Results - $formattedDate",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),

                      // Circular Stats
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatCircle("Total Marks",
                              "$totalObtained / $totalMaxMarks", Colors.blue),
                          _buildStatCircle(
                              "Percentage",
                              "${overallPercentage.toStringAsFixed(1)}%",
                              getColorForMarks(overallPercentage)),
                          _buildStatCircle("Status", isPassed ? "Pass" : "Fail",
                              isPassed ? Colors.green : Colors.red),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Expanded(
                        child: ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            var subject = results[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          subject.subject,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          formattedDate,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${subject.marks} / ${subject.totalMarks}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: getColorForMarks(
                                                  subject.marks)),
                                        ),
                                        Text(
                                          "${subject.percentage.toStringAsFixed(1)}%",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: getColorForMarks(
                                                  subject.marks)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                    height: 20),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Circle Stat Widget
  Widget _buildStatCircle(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.2),
          ),
          child: Center(
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: color),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: const TextStyle(fontSize: 14, color: Colors.black54)),
      ],
    );
  }

  // Color Based on Marks
  Color getColorForMarks(double marks) {
    if (marks < 20) return Colors.red[900]!;
    if (marks < 40) return Colors.red;
    if (marks < 60) return Colors.orange;
    if (marks < 80) return Colors.green;
    if (marks < 95) return Colors.green[700]!;
    return Colors.amber[700]!;
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
//     String formattedDate =
//         DateFormat("dd MMM yyyy").format(DateTime.parse(examDate));
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Results - $formattedDate"),
//         actions: [
//           IconButton(
//             icon: Icon(LucideIcons.refreshCw),
//             onPressed: () {
//               controller.fetchExamResults(); // Reloads the data
//               Get.snackbar("Reload", "Refreshing Report...");
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Report Title
//             Text(
//               "Exam Report",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//
//             // Subject-Wise Report
//             Expanded(
//               child: ListView.builder(
//                 itemCount: results.length,
//                 itemBuilder: (context, index) {
//                   var subject = results[index];
//
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // Subject Name & Date (Left)
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 subject.subject,
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               SizedBox(height: 4),
//                               Text(
//                                 formattedDate,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ],
//                           ),
//
//                           // Marks & Percentage (Right)
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 "${subject.marks} / ${subject.totalMarks}",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: getColorForMarks(subject.marks),
//                                 ),
//                               ),
//                               Text(
//                                 "${subject.percentage.toStringAsFixed(1)}%",
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: getColorForMarks(subject.marks),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//
//                       // Divider Line After Each Subject
//                       Divider(
//                           color: Colors.grey[300], thickness: 1, height: 20),
//                     ],
//                   );
//                 },
//               ),
//             ),
//
//             // Action Buttons (Download, Recheck)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconButton(
//                   icon:
//                       Icon(LucideIcons.download, size: 28, color: Colors.blue),
//                   onPressed: () {
//                     Get.snackbar("Download", "Downloading Report...");
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(LucideIcons.checkCircle,
//                       size: 28, color: Colors.orange),
//                   onPressed: () {
//                     Get.snackbar("Recheck", "Requesting Recheck...");
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ✅ Color Based on Marks
//   Color getColorForMarks(double marks) {
//     if (marks < 20) return Colors.red[900]!; // Dark Red
//     if (marks < 40) return Colors.red; // Red
//     if (marks < 60) return Colors.orange; // Yellowish
//     if (marks < 80) return Colors.green; // Green
//     if (marks < 95) return Colors.green[700]!; // Dark Green
//     return Colors.amber[700]!; // Golden
//   }
// }
