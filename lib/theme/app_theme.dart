import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colour palette from the design: midnight blue, marigold gold, peacock teal.
class AppColors {
  static const background = Color(0xFF101A3A);
  static const card = Color(0xFF1A2650);
  static const border = Color(0xFF2E3B6E);
  static const navBar = Color(0xFF0B1330);
  static const gold = Color(0xFFF2B84B);
  static const cream = Color(0xFFF3EBDD);
  static const muted = Color(0xFFA9B4D6);
  static const teal = Color(0xFF0E6B73);
  static const tealLight = Color(0xFF1B9AA6);
  static const navy = Color(0xFF14305F);
}

/// Heading font (Marcellus). Body text uses Mukta via the theme.
TextStyle headingStyle(double size, {Color color = AppColors.cream}) {
  return GoogleFonts.marcellus(fontSize: size, color: color, height: 1.15);
}

ThemeData buildAppTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  final textTheme = GoogleFonts.muktaTextTheme(base.textTheme).apply(
    bodyColor: AppColors.cream,
    displayColor: AppColors.cream,
  );

  return base.copyWith(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.gold,
      surface: AppColors.card,
      onSurface: AppColors.cream,
    ),
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.cream,
      elevation: 0,
      titleTextStyle: headingStyle(24),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.navBar,
      indicatorColor: AppColors.card,
      labelTextStyle: WidgetStatePropertyAll(
        GoogleFonts.mukta(fontSize: 12, color: AppColors.cream),
      ),
    ),
  );
}
