import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFD4AF37); // Minimalist Gold
  static const Color secondaryColor = Color(0xFF1A1A1A);
  static const Color accentColor = Color(0xFFFFFFFF);
  
  static const Color darkBg = Color(0xFF000000); // Pure Black
  static const Color darkCard = Color(0xFF0A0A0A); // Deep Charcoal
  static const Color lightBg = Color(0xFFF5F5F5);
  static const Color lightCard = Color(0xFFFFFFFF);
  
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFA0A0A0);
  static const Color textPrimaryLight = Color(0xFF000000);
  static const Color textSecondaryLight = Color(0xFF404040);

  static const List<Color> gradientColors = [
    primaryColor,
    Color(0xFF8A6D3B), // Bronze/Dark Gold
  ];
}

class AppConstants {
  static const String name = "Muhammed Arshad mc";
  static const String role = "Flutter Developer";
  static const String intro = "Building beautiful, performant, and cross-platform applications with Flutter.";
  
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
}
