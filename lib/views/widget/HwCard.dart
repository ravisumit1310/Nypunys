import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../models/HwModel.dart';

class HomeworkDetailPopup extends StatelessWidget {
  final Homework homework;

  const HomeworkDetailPopup({super.key, required this.homework});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(homework.subject ?? "No Subject",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(homework.description ?? "No Description",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text("Assigned Date: ${homework.assignedDate}",
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            Text("Status: ${homework.status}",
                style: const TextStyle(color: Colors.redAccent)),
            if (homework.marks != null)
              Text("Marks: ${homework.marks}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        ),
      ),
    );
  }
}
