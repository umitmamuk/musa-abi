import 'package:flutter/material.dart';

class AppColors {
  // Ana Renkler - Logonuza uygun
  static const Color primary = Color(0xFF6366F1);      // Ana mavi-mor
  static const Color primaryLight = Color(0xFF818CF8); // Açık mavi-mor
  static const Color primaryDark = Color(0xFF4F46E5);  // Koyu mavi-mor
  static const Color accent = Color(0xFF06B6D4);       // Cyan (gradient rengi)
  static const Color secondary = Color(0xFF0F172A);    // Koyu renk
  
  // Gradient Renkleri
  static const List<Color> primaryGradient = [
    Color(0xFF6366F1),
    Color(0xFF06B6D4),
  ];
  
  static const List<Color> blueGradient = [
    Color(0xFF6366F1),
    Color(0xFF3B82F6),
  ];
  
  // Arka Plan Renkleri
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFF1F5F9);
  
  // Border ve Divider
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  
  // Text Renkleri
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textLight = Color(0xFF94A3B8);
  
  // Durum Renkleri
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
  
  // Kategori Renkleri
  static const Color categoryPink = Color(0xFFEC4899);
  static const Color categoryBlue = Color(0xFF3B82F6);
  static const Color categoryGreen = Color(0xFF10B981);
  static const Color categoryOrange = Color(0xFFF97316);
  static const Color categoryPurple = Color(0xFF8B5CF6);
  static const Color categoryBrown = Color(0xFF92400E);
  static const Color categoryRed = Color(0xFFEF4444);
  static const Color categoryTeal = Color(0xFF14B8A6);
  
  // Gradient Oluşturucu
  static LinearGradient getGradient({
    List<Color>? colors,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    return LinearGradient(
      colors: colors ?? primaryGradient,
      begin: begin,
      end: end,
    );
  }
  
  // Box Shadow
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: primary.withOpacity(0.08),
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ];
  
  static List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: primary.withOpacity(0.25),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
}