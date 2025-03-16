import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OverallPerformanceWidget extends StatelessWidget {
  final double averageMarks;

  const OverallPerformanceWidget({required this.averageMarks, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percentage = (averageMarks / 100).clamp(0.0, 1.0);

    return Column(
      children: [
        Text(
          "Overall Performance",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CircularPercentIndicator(
          radius: 80.0,
          lineWidth: 12.0,
          animation: true,
          animationDuration: 1200, // 1.2 seconds smooth animation
          percent: percentage,
          center: Text(
            "${(percentage * 100).toStringAsFixed(1)}%",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          linearGradient: _getGradient(percentage), // ✅ Dynamic color gradient
        ),
      ],
    );
  }

  // 🎨 Method to determine the gradient based on percentage
  LinearGradient _getGradient(double percent) {
    if (percent <= 0.5) {
      return LinearGradient(colors: [Colors.red, Colors.yellow]);
    } else if (percent <= 0.75) {
      return LinearGradient(colors: [Colors.yellow, Colors.green]);
    } else if (percent <= 0.95) {
      return LinearGradient(colors: [Colors.green, Colors.lightGreen]);
    } else {
      return LinearGradient(colors: [Colors.amber, Colors.orangeAccent]);
    }
  }
}

// class OverallPerformanceWidget extends StatelessWidget {
//   final ExamResultsController controller;
//
//   const OverallPerformanceWidget({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     double percentage = controller.averageMarks.value / 100;
//
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text("Overall Performance",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             CircularPercentIndicator(
//               radius: 60.0,
//               lineWidth: 10.0,
//               animation: true,
//               percent: percentage.clamp(0.0, 1.0),
//               center: Text(
//                 "${(percentage * 100).toStringAsFixed(1)}%",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               circularStrokeCap: CircularStrokeCap.round,
//               progressColor: Colors.blueAccent,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
