import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final List<Map<String, dynamic>> options;

  const CustomBottomSheet({
    Key? key,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar for dragging
          Container(
            width: 50,
            height: 5,
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // Options
          ...options.map((option) {
            return ListTile(
              leading: Icon(option['icon'], color: Colors.blue),
              title: Text(option['label']),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                if (option['onTap'] != null) {
                  option['onTap'](); // Call the custom navigation function
                }
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
