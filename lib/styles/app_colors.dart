// utils/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary brand color with a professional blue tone
  static const Color primary = Color(0xFF2563EB); // A strong blue

  // Secondary accent color
  static const Color secondary =
      Color(0xFF0EA5E9); // A lighter blue for accents

  // Neutral colors for backgrounds, cards, and text
  static const Color background =
      Color(0xFFF8FAFC); // Very light gray/white for backgrounds
  static const Color surface = Colors.white; // White for cards and surfaces
  static const Color textPrimary =
      Color(0xFF1E293B); // Dark slate for primary text
  static const Color textSecondary =
      Color(0xFF64748B); // Medium slate for secondary text

  // Status/feedback colors
  static const Color success = Color(0xFF22C55E); // Green for success states
  static const Color error = Color(0xFFEF4444); // Red for errors
  static const Color warning = Color(0xFFF59E0B); // Amber for warnings

  // Disabled state colors
  static const Color disabledButton = Color(0xFFE2E8F0);
  static const Color disabledText = Color(0xFF94A3B8);

  // Role-specific accent colors (optional)
  static const Color adminAccent =
      Color(0xFF8B5CF6); // Purple for admin-related UI
  static const Color recruiterAccent =
      Color(0xFF0891B2); // Teal for recruiter-related UI
  static const Color candidateAccent =
      Color(0xFF059669); // Green for candidate-related UI
}
