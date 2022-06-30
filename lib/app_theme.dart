import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'values/values.dart';

class AppTheme {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);

  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      iconTheme: const IconThemeData(color: AppColors.white),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      //accentColor: colorScheme.primary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      focusColor: AppColors.primaryColor,
    );
  }

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFFB94D),
    onPrimary: Color(0xFF462B00),
    primaryContainer: Color(0xFF633F00),
    onPrimaryContainer: Color(0xFFFFDDAF),
    secondary: Color(0xFFDDC2A1),
    onSecondary: Color(0xFF3E2D16),
    secondaryContainer: Color(0xFF56442B),
    onSecondaryContainer: Color(0xFFFADEBC),
    tertiary: Color(0xFFB8CDA1),
    onTertiary: Color(0xFF243515),
    tertiaryContainer: Color(0xFF3A4C29),
    onTertiaryContainer: Color(0xFFD4EABB),
    error: Color(0xFFFFB4A9),
    errorContainer: Color(0xFF930006),
    onError: Color(0xFF680003),
    onErrorContainer: Color(0xFFFFDAD4),
    background: Color(0xFF1F1B16),
    onBackground: Color(0xFFEAE1D9),
    surface: Color(0xFF1F1B16),
    onSurface: Color(0xFFEAE1D9),
    surfaceVariant: Color(0xFF4F4539),
    onSurfaceVariant: Color(0xFFD3C4B4),
    outline: Color(0xFF9C8F80),
    onInverseSurface: Color(0xFF1F1B16),
    inverseSurface: Color(0xFFEAE1D9),
    inversePrimary: Color(0xFF835500),
    shadow: Color(0xFF000000),
  );

  static const lightColorScheme = ColorScheme(
    primary: AppColors.primaryColor,
    primaryContainer: AppColors.secondaryColor,
    secondary: AppColors.primaryColor,
    secondaryContainer: AppColors.primaryColor,
    background: Colors.white,
    surface: Color(0xFFFAFBFB),
    onBackground: AppColors.primaryColor,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  // static const _superBold = FontWeight.w900;
  static const _bold = FontWeight.w700;
  // static const _semiBold = FontWeight.w600;
  // static const _medium = FontWeight.w500;
  static const _regular = FontWeight.w400;
  static const _light = FontWeight.w300;

  static final TextTheme _textTheme = TextTheme(
    headline1: GoogleFonts.gloriaHallelujah(
      fontSize: Sizes.TEXT_SIZE_96,
      //color: AppColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline2: GoogleFonts.ibmPlexMono(
      fontSize: Sizes.TEXT_SIZE_60,
      //color: AppColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline3: GoogleFonts.ibmPlexMono(
      fontSize: Sizes.TEXT_SIZE_48,
      //color: AppColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline4: GoogleFonts.ibmPlexMono(
      fontSize: Sizes.TEXT_SIZE_34,
      //color: AppColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline5: GoogleFonts.ibmPlexMono(
      fontSize: Sizes.TEXT_SIZE_24,
      //color: AppColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    headline6: GoogleFonts.ibmPlexMono(
      fontSize: Sizes.TEXT_SIZE_20,
      //color: AppColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    subtitle1: GoogleFonts.ibmPlexMono(
      fontSize: Sizes.TEXT_SIZE_18,
      //color: AppColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    subtitle2: GoogleFonts.ibmPlexMono(
      fontSize: Sizes.TEXT_SIZE_14,
      //color: AppColors.black,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    bodyText1: GoogleFonts.lato(
      fontSize: Sizes.TEXT_SIZE_16,
      //color: AppColors.primaryText2,
      fontWeight: _regular,
      fontStyle: FontStyle.normal,
    ),
    bodyText2: GoogleFonts.ibmPlexMono(
      fontSize: Sizes.TEXT_SIZE_14,
      //color: AppColors.black,
      fontWeight: _light,
      fontStyle: FontStyle.normal,
    ),
    button: GoogleFonts.lato(
      fontSize: Sizes.TEXT_SIZE_16,
      color: AppColors.black,
      fontStyle: FontStyle.normal,
      fontWeight: _regular,
    ),
    caption: GoogleFonts.ibmPlexMono(
      fontSize: Sizes.TEXT_SIZE_12,
      //color: AppColors.primaryText1,
      fontWeight: _regular,
      fontStyle: FontStyle.normal,
    ),
  );
}
