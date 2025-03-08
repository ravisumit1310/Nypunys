import 'package:flutter/material.dart';

Widget buildInfoRow(BuildContext context, String title, dynamic value) {
  String displayValue = (value == null)
      ? "N/A"
      : (value is DateTime)
          ? "${value.toLocal()}".split(' ')[0]
          : value.toString();

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700]),
            ),
          ),
          Expanded(
            child: Text(
              displayValue,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
        ],
      ),
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
