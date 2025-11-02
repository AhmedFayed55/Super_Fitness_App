import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/font_weight.dart';
import 'colors.dart';

abstract class AppTheme {
  static ThemeData getTheme(ColorScheme colorScheme) {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.grey,
      colorScheme: colorScheme,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: AppFontWeight.semiBold,
          color: AppColors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightOrange[10],
          disabledBackgroundColor: AppColors.grey[10],
          foregroundColor: AppColors.white,
          minimumSize: const Size(double.infinity, 38),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: AppFontWeight.extraBold,
            color: AppColors.white,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: AppColors.grey[90],
        suffixIconColor: AppColors.grey[90],
        errorStyle: const TextStyle(
          fontSize: 12,
          fontWeight: AppFontWeight.regular,
          color: AppColors.red,
        ),
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: AppFontWeight.regular,
          color: AppColors.grey[90],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.grey[90]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.grey[90]!),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.red),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.lightOrange,
      ),
      textTheme: TextTheme(
        // =======================
        // Display Texts (Main Titles)
        // =======================
        displayLarge: GoogleFonts.balooThambi2(
          color: AppColors.white,
          fontSize: 24,
          fontWeight: AppFontWeight.extraBold,
        ),
        displayMedium: GoogleFonts.balooThambi2(
          color: AppColors.white,
          fontSize: 20,
          fontWeight: AppFontWeight.bold,
        ),
        displaySmall: GoogleFonts.balooThambi2(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: AppFontWeight.semiBold,
        ),
        // =======================
        // Headline Texts (Section Titles)
        // =======================
        headlineLarge: GoogleFonts.balooThambi2(
          color: AppColors.white,
          fontSize: 22,
          fontWeight: AppFontWeight.extraBold,
        ),
        headlineMedium: GoogleFonts.balooThambi2(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: AppFontWeight.bold,
        ),
        headlineSmall: GoogleFonts.balooThambi2(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: AppFontWeight.medium,
        ),
        // =======================
        // Title Texts (Common Text)
        // =======================
        titleLarge: GoogleFonts.balooThambi2(
          color: AppColors.white,
          fontSize: 20,
          fontWeight: AppFontWeight.extraBold,
        ),
        titleMedium: GoogleFonts.balooThambi2(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: AppFontWeight.medium,
        ),
        titleSmall: GoogleFonts.balooThambi2(
          color: AppColors.white,
          fontSize: 14,
          fontWeight: AppFontWeight.regular,
        ),
        // =======================
        // Body Texts (Paragraphs)
        // =======================
        bodyLarge: GoogleFonts.balooThambi2(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: AppFontWeight.regular,
        ),
        bodyMedium: GoogleFonts.balooThambi2(
          color: AppColors.white,
          fontSize: 14,
          fontWeight: AppFontWeight.regular,
        ),
        bodySmall: GoogleFonts.balooThambi2(
          color: AppColors.white,
          fontSize: 12,
          fontWeight: AppFontWeight.regular,
        ),
        // =======================
        // Label Texts (Buttons, Captions)
        // =======================
        labelLarge: GoogleFonts.balooThambi2(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: AppFontWeight.medium,
        ),
        labelMedium: GoogleFonts.balooThambi2(
          color: AppColors.white,
          fontSize: 14,
          fontWeight: AppFontWeight.regular,
        ),
        labelSmall: GoogleFonts.balooThambi2(
          color: AppColors.white,
          fontSize: 12,
          fontWeight: AppFontWeight.regular,
        ),
      ),
    );
  }

  static ThemeData darkTheme = getTheme(
    ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.lightOrange[10]!,
      onPrimary: AppColors.white,
      secondary: AppColors.black,
      onSecondary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      shadow: AppColors.black,
      onSurface: AppColors.grey,
      outline: AppColors.grey[90],
    ),
  );
}
