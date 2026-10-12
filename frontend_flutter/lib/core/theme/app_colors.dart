import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF2563EB);      // Blue
  static const Color secondary = Color(0xFF7C3AED);    // Purple

  // Semantic risk colors
  static const Color riskLow = Color(0xFF10B981);      // Green
  static const Color riskMedium = Color(0xFFF59E0B);   // Amber
  static const Color riskHigh = Color(0xFFEF4444);     // Red
  static const Color riskCritical = Color(0xFF991B1B); // Dark red

  // Status
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Neutrals (Light theme)
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE2E8F0);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF94A3B8);

  // Helpers
  static Color riskColor(double score) {
    if (score >= 0.85) return riskCritical;
    if (score >= 0.65) return riskHigh;
    if (score >= 0.35) return riskMedium;
    return riskLow;
  }

  static String riskLabel(double score) {
    if (score >= 0.85) return 'Critical';
    if (score >= 0.65) return 'High';
    if (score >= 0.35) return 'Medium';
    return 'Low';
  }
}
