import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF1E3A8A);      // Deep blue
  static const secondary = Color(0xFF10B981);    // Green (education/growth)
  static const accent = Color(0xFFF59E0B);       // Amber (achievement)
  static const background = Color(0xFFF8FAFC);
  static const cardBackground = Colors.white;
  static const textPrimary = Color(0xFF1E293B);
  static const textSecondary = Color(0xFF64748B);
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
  
  static const gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],  // Blue gradient
  );
  
  static const cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF10B981), Color(0xFF059669)],  // Green gradient
  );
}
