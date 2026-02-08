import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF00ACC1); // Teal
  static const Color secondary = Color(0xFF00796B);
  static const Color distress = Color(0xFFE53935); // Red
  static const Color success = Color(0xFF43A047); // Green
  static const Color warning = Color(0xFFFB8C00); // Orange
  static const Color info = Color(0xFF1E88E5); // Blue
  
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00ACC1), Color(0xFF00796B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppStrings {
  static const String appName = "Ani-Care";
  static const String vision = "Community-driven stray animal care and health monitoring.";
}
