import 'package:flutter/material.dart';

// Shared theme constants used across the app for gradients and common colors.
// Pink ↔ Blue gradient ("pushti va ko'k")
const LinearGradient kAppGradient = LinearGradient(
  colors: [Color(0xFFEC4899), Color(0xFF3B82F6)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

extension ColorAlpha on Color {
  /// Returns the same color with alpha from 0.0 to 1.0 like withOpacity.
  Color withValues({required double alpha}) => withAlpha((alpha * 255).round());
}
