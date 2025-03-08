import 'package:flutter/material.dart';

import 'dart:math';

class TimetableCard extends StatelessWidget {
  final String title;
  final String time;

  const TimetableCard({
    super.key,
    required this.title,
    required this.time,
  });

  // 🔹 Kid-Friendly Colors
  static final List<Color> _colors = [
    Colors.red.shade200,
    Colors.blue.shade200,
    Colors.green.shade200,
    Colors.orange.shade200,
    Colors.purple.shade200,
    Colors.yellow.shade200,
    Colors.pink.shade200,
  ];

  // 🔹 Function to get a random color
  Color getRandomColor() {
    return _colors[Random().nextInt(_colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // 🔹 Ensures Full Width
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding:
            const EdgeInsets.all(20.0), // 🔹 More Padding for Better Layout
        height: 120, // 🔹 Consistent Height
        decoration: BoxDecoration(
          color: getRandomColor(), // 🔹 Assigns a Random Color
          borderRadius:
              BorderRadius.circular(16.0), // 🔹 Smooth Rounded Corners
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(2, 2), // 🔹 Soft Shadow for Depth
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 🔹 Center Align Text
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              time,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

// class TimetableCard extends StatelessWidget {
//   final String title;
//   final String time;
//   final Color color;
//
//   const TimetableCard({
//     super.key,
//     required this.title,
//     required this.time,
//     required this.color,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style:
//                   const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 5),
//           Text(time, style: const TextStyle(color: Colors.black54)),
//         ],
//       ),
//     );
//   }
// }
