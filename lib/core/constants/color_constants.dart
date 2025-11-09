import 'package:flutter/material.dart';

class ColorConstants {
  // Primary Colors (Extracted from the provided hexagonal logo's gradient)
  // These represent the main hues in your logo, moving from blue-purple to orange-red.
  static const Color primaryBlue = Color(
    0xFF4C7FFF,
  ); // Starting blue-purple shade
  static const Color accentPurple = Color(0xFF8B4DFF); // Mid-range purple shade
  static const Color highlightOrange = Color(
    0xFFFF8C4C,
  ); // Ending orange-red shade

  // UI Specific Colors based on the logo's aesthetic for better harmony
  // These are derived from the logo's style to give a modern, techy feel.
  static const Color textDark = Color(0xFF2C3E50); // Dark text for readability
  static const Color textLight = Color(
    0xFFECF0F1,
  ); // Light text for dark backgrounds
  static const Color backgroundLight = Color(
    0xFFF8F9FA,
  ); // A very light, almost white background
  static const Color backgroundDark = Color(
    0xFF2C3E50,
  ); // A dark background for contrasting sections

  // Complementary / Neutral Colors
  static const Color white = Color(0xFFFFFFFF); // Standard white
  static const Color lightGray = Color(
    0xFFE0E0E0,
  ); // General light gray for borders, dividers
  static const Color mediumGray = Color(
    0xFF95A5A6,
  ); // For secondary text, subtle accents
  static const Color darkGray = Color(
    0xFF34495E,
  ); // For slightly darker elements, subtle backgrounds

  // Hover / Active States - Derived by slightly adjusting primary colors
  static const Color primaryBlueDark = Color(
    0xFF3A6AD0,
  ); // Darker shade of primaryBlue
  static const Color accentPurpleDark = Color(
    0xFF7A3AD0,
  ); // Darker shade of accentPurple
  static const Color highlightOrangeDark = Color(
    0xFFD06D3A,
  ); // Darker shade of highlightOrange

  // Status / Action Colors (examples, adjust as needed)
  static const Color successGreen = Color(0xFF2ECC71);
  static const Color errorRed = Color(0xFFE74C3C);
  static const Color infoBlue = Color(0xFF3498DB);
  static const Color warningYellow = Color(0xFFF1C40F);
}
