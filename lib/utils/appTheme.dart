import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6200EE);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF5F5F5);
  static const Color error = Color(0xFFB00020);
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Colors.grey;
  static const Color buttonColor = Color(0xFF6200EE);
  static const Color cardColor = Color(0xFFF1F1F1);
  static const Color borderColor = Color(0xFFE0E0E0);
  static const Color shadowColor = Color(0xFFBDBDBD);

  static const Color black = Color(0xFF000000);
  static const Color green = Color(0xFF2F6807);
  static const Color blue = Color(0xFF495ECA);
  static const Color skyBlue = Color(0xFF87CEEB);
  static const Color purple = Color(0xFFC05AFF);
  static const Color orange = Color(0xFFF89825);

  static const LinearGradient customGradient = LinearGradient(
    colors: [Color(0xFF2F6807), Color(0xFF495ECA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient customGradientHome = LinearGradient(
    colors: [
      Color(0xFFFFE5B4), // Light Orange (Peach-like)
      Colors.white, // White Gap
      Color(0xFFA7D8FF), // Light Sky Blue
    ],
    stops: [0.0, 0.5, 1.0], // White in the middle
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color primaryDark = Color(0xFFBB86FC);
  static const Color secondaryDark = Color(0xFF03DAC6);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color errorDark = Color(0xFFCF6679);
  static const Color textPrimaryDark = Colors.white;
  static const Color textSecondaryDark = Colors.grey;
  static const Color buttonColorDark = Color(0xFFBB86FC);
  static const Color cardColorDark = Color(0xFF1E1E1E);
  static const Color borderColorDark = Color(0xFF3E3E3E);
  static const Color shadowColorDark = Color(0xFF000000);
}
