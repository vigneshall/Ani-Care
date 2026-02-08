import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary Colors - Soft Teal-Blue for Healthcare/Government
  static const Color primaryTeal = Color(0xFF00897B);
  static const Color primaryBlueGreen = Color(0xFF26A69A);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  
  // Accent Colors - Medical Grade
  static const Color emergencyRed = Color(0xFFD32F2F);
  static const Color successGreen = Color(0xFF388E3C);
  static const Color warningOrange = Color(0xFFF57C00);
  static const Color infoBlue = Color(0xFF1976D2);
  
  // Text Colors
  static const Color textDark = Color(0xFF212121);
  static const Color textMedium = Color(0xFF616161);
  static const Color textLight = Color(0xFF9E9E9E);
  
  // Backward compatibility aliases
  static const Color accentBlue = infoBlue;
  static const Color textGrey = textLight;
  
  // Gradient
  static final LinearGradient primaryGradient = const LinearGradient(
    colors: [primaryTeal, primaryBlueGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: primaryTeal,
    scaffoldBackgroundColor: backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: primaryTeal,
      secondary: infoBlue,
      error: emergencyRed,
      surface: backgroundWhite,
      onSurface: textDark,
    ),
    textTheme: GoogleFonts.interTextTheme().copyWith(
      displayLarge: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 32, color: textDark),
      headlineMedium: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 24, color: textDark),
      titleLarge: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 20, color: textDark),
      titleMedium: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16, color: textDark),
      bodyLarge: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 16, color: textDark),
      bodyMedium: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 14, color: textMedium),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: cardBackground,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryTeal,
      elevation: 0,
      centerTitle: false,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryTeal,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryTeal,
        side: const BorderSide(color: primaryTeal, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryTeal,
      unselectedItemColor: textLight,
      backgroundColor: backgroundWhite,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: backgroundWhite,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryTeal, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryTeal,
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: const ColorScheme.dark(
      primary: primaryTeal,
      secondary: infoBlue,
      error: emergencyRed,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white),
      headlineMedium: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
      titleLarge: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),
      titleMedium: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
      bodyLarge: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.white),
      bodyMedium: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white70),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryTeal,
      elevation: 0,
      centerTitle: false,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryTeal,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryTeal,
      unselectedItemColor: Colors.white54,
      backgroundColor: Color(0xFF1E1E1E),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    ),
  );
}
