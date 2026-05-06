import 'package:flutter/material.dart';
/// Premium color palette designed for a security application
/// Uses deep blues and cyans for trust, with accent colors for alerts
class AppColors {
  AppColors._();
  // ============ PRIMARY PALETTE ============
  // Deep blue gradient for primary actions - conveys security & trust
  static const Color primaryDark = Color(0xFF0A1628);
  static const Color primary = Color(0xFF1A365D);
  static const Color primaryLight = Color(0xFF2D4A7C);
  
  // Cyan accent for highlights and interactive elements
  static const Color accent = Color(0xFF00D9FF);
  static const Color accentLight = Color(0xFF7EEFFF);
  static const Color accentDark = Color(0xFF00A3BF);
  // ============ SURFACE COLORS ============
  // Dark mode surfaces with subtle blue undertones
  static const Color surfaceDark = Color(0xFF0D1B2A);
  static const Color surfaceElevated = Color(0xFF1B2838);
  static const Color surfaceCard = Color(0xFF162032);
  
  // Light mode surfaces
  static const Color surfaceLight = Color(0xFFF8FAFC);
  static const Color surfaceLightElevated = Color(0xFFFFFFFF);
  static const Color surfaceLightCard = Color(0xFFF1F5F9);
  // ============ ALERT SEVERITY COLORS ============
  // Carefully chosen for accessibility and quick recognition
  static const Color alertCritical = Color(0xFFFF3B5C);
  static const Color alertCriticalBg = Color(0x1AFF3B5C);
  
  static const Color alertHigh = Color(0xFFFF8C42);
  static const Color alertHighBg = Color(0x1AFF8C42);
  
  static const Color alertMedium = Color(0xFFFFD93D);
  static const Color alertMediumBg = Color(0x1AFFD93D);
  
  static const Color alertLow = Color(0xFF00E676);
  static const Color alertLowBg = Color(0x1A00E676);
  // ============ STATUS COLORS ============
  static const Color online = Color(0xFF00E676);
  static const Color offline = Color(0xFF78909C);
  static const Color warning = Color(0xFFFFAB00);
  static const Color error = Color(0xFFFF5252);
  // ============ TEXT COLORS ============
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textTertiaryDark = Color(0xFF64748B);
  
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF475569);
  static const Color textTertiaryLight = Color(0xFF94A3B8);
  // ============ GRADIENTS ============
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A365D), Color(0xFF0A1628)],
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00D9FF), Color(0xFF0077B6)],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1B2838), Color(0xFF0D1B2A)],
  );
  // Glassmorphism overlay gradient
  static LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withOpacity(0.15),
      Colors.white.withOpacity(0.05),
    ],
  );
}