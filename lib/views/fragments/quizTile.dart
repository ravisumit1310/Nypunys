import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String option;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onTap;

  const OptionTile({
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    IconData? icon;
    Color? iconColor;

    if (isSelected) {
      backgroundColor = isCorrect ? Colors.green[100]! : Colors.red[100]!;
      icon = isCorrect ? Icons.check : Icons.close;
      iconColor = isCorrect ? Colors.green : Colors.red;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(option),
            if (isSelected)
              Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 16.0),
              )
            else
              Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
