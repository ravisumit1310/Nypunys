import 'package:flutter/material.dart';

Widget buildInfoRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]),
        ),
        Text(
          value,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ],
    ),
  );
}

Widget buildDivider() {
  return Divider(
    color: Colors.grey[300],
    thickness: 1,
    height: 12,
  );
}
