import 'package:blog_web_site/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;

  ThemeNotifier({
    ThemeMode mode = ThemeMode.dark,
    ColorSeed colorSeed = ColorSeed.blue,
  })  : _mode = mode,
        super(darkThemeMode) {
    getTheme();
  }

  ThemeMode get theme {
    return _mode;
  }

  Future<ThemeMode> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'light') {
      _mode = ThemeMode.light;
      state = lightThemeMode;
    } else {
      _mode = ThemeMode.dark;
      state = darkThemeMode;
    }
    return _mode;
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = lightThemeMode;
      prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = darkThemeMode;
      prefs.setString('theme', 'dark');
    }
  }
}

final darkThemeMode = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: GoogleFonts.ubuntu().fontFamily,
  colorSchemeSeed: ColorSeed.blue.color,
  useMaterial3: true,
);

final lightThemeMode = ThemeData(
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: GoogleFonts.ubuntu().fontFamily,
  colorSchemeSeed: ColorSeed.indigo.color,
  useMaterial3: true,
);
