import 'package:flutter/material.dart';

class AppTheme {
  // Modern Palette
  static const Color background = Color(0xFFF8FAFC);
  static const Color primary = Color(0xFF0F172A); // Deep Slate
  static const Color health = Color(0xFF2DD4BF);  // Sage Mint
  static const Color team = Color(0xFF818CF8);    // Soft Lavender
  static const Color home = Color(0xFFFB923C);    // Warm Sand
  static const Color surface = Colors.white;
  static const Color textMain = Color(0xFF1E293B);
  static const Color textSub = Color(0xFF64748B);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        background: background,
        surface: surface,
        secondary: health,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: textMain,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textMain,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textMain,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: textMain,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: textSub,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textMain,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: textMain),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
