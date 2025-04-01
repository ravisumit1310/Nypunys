import 'package:academyapp/utils/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OverallPerformanceWidget extends StatelessWidget {
  final double averageMarks;

  const OverallPerformanceWidget({required this.averageMarks, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percentage = (averageMarks / 100).clamp(0.0, 1.0);
    Color edgeColor = _getEdgeColor(percentage);

    return Column(
      children: [
        Text(
          "Overall Performance",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        CircularPercentIndicator(
          radius: 80.0,
          lineWidth: 12.0,
          animation: true,
          animationDuration: 1200, // Smooth animation
          percent: percentage,
          center: Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.lightBlueAccent, // Sky blue center
            ),
            child: Center(
              child: Text(
                "${(percentage * 100).toStringAsFixed(1)}%",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: edgeColor,
          backgroundColor: AppColors.background,
        ),
      ],
    );
  }

  Color _getEdgeColor(double percent) {
    if (percent < 0.45) {
      return Colors.red;
    } else if (percent <= 0.85) {
      return Colors.grey.shade400;
    } else {
      return Colors.amber;
    }
  }
}
