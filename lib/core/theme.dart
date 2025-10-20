import 'package:flutter/material.dart';

// Shared theme constants used across the app for gradients and common colors.
const LinearGradient kAppGradient = LinearGradient(
  colors: [Color(0xFF6D28D9), Color(0xFFF472B6)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

extension ColorAlpha on Color {
  /// Returns the same color with alpha from 0.0 to 1.0 like withOpacity.
  Color withValues({required double alpha}) => withAlpha((alpha * 255).round());
}
