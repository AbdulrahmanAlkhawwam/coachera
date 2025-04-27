import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  // Light Theme Text Styles
  static TextTheme get textTheme => TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 36,
          height: 44 / 36,
          letterSpacing: -0.022 * 36,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 36,
          height: 44 / 36,
          letterSpacing: -0.022 * 36,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: 36,
          height: 44 / 36,
          letterSpacing: -0.022 * 36,
          fontWeight: FontWeight.w500,
        ),
        headlineLarge: GoogleFonts.poppins(
          fontSize: 24,
          height: 32 / 24,
          letterSpacing: -0.021 * 24,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 24,
          height: 32 / 24,
          letterSpacing: -0.021 * 24,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontSize: 24,
          height: 32 / 24,
          letterSpacing: -0.021 * 24,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 20,
          height: 28 / 20,
          letterSpacing: -0.017 * 20,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 20,
          height: 28 / 20,
          letterSpacing: -0.017 * 20,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: GoogleFonts.poppins(
          fontSize: 20,
          height: 28 / 20,
          letterSpacing: -0.017 * 20,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 16,
          height: 28 / 16,
          letterSpacing: -0.011 * 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          height: 24 / 14,
          letterSpacing: -0.006 * 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 12,
          height: 24 / 12,
          letterSpacing: 0,
          fontWeight: FontWeight.w400,
        ),
        labelSmall: GoogleFonts.poppins(
          fontSize: 10,
          height: 16 / 10,
          letterSpacing: 0,
          fontWeight: FontWeight.w400,
        ),
      );
}
