import 'package:blog_web_site/core/constants.dart';
import 'package:flutter/foundation.dart';
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
  ColorSeed _colorSeed;

  ThemeNotifier({
    ThemeMode mode = ThemeMode.dark,
    ColorSeed colorSeed = ColorSeed.orange,
  })  : _mode = mode,
        _colorSeed = colorSeed,
        super(darkThemeMode(colorSeed)) {
    getTheme();
  }

  ThemeMode get theme {
    return _mode;
  }

  ColorSeed get colorSeed {
    return _colorSeed;
  }

  Future<void> setColorSeed(ColorSeed colorSeed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _colorSeed = colorSeed;
    prefs.setInt('colorSeed', colorSeed.index);
    if (_mode == ThemeMode.dark) {
      state = darkThemeMode(colorSeed);
    } else {
      state = lightThemeMode(colorSeed);
    }
  }

  Future<ThemeMode> getTheme() async {
    String? theme;
    int? colorSeed;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      theme = prefs.getString('theme');
      colorSeed = prefs.getInt('colorSeed');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      theme ??= 'dark';
    }

    _colorSeed = ColorSeed.values[colorSeed ?? 2];

    if (theme == 'light') {
      _mode = ThemeMode.light;
      state = lightThemeMode(_colorSeed);
    } else {
      _mode = ThemeMode.dark;
      state = darkThemeMode(_colorSeed);
    }
    return _mode;
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = lightThemeMode(_colorSeed);
      prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = darkThemeMode(_colorSeed);
      prefs.setString('theme', 'dark');
    }
  }
}

ThemeData darkThemeMode(ColorSeed seedColor) => ThemeData(
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: GoogleFonts.ubuntu().fontFamily,
      colorSchemeSeed: seedColor.color,
      useMaterial3: true,
    );

ThemeData lightThemeMode(ColorSeed seedColor) => ThemeData(
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: GoogleFonts.ubuntu().fontFamily,
      colorSchemeSeed: seedColor.color,
      useMaterial3: true,
    );

final darkGreenPalette = [
  const Color(0xFF35374B),
  const Color(0xFF344955),
  const Color(0xFF50727B),
];
final lightGreenPalette = [
  const Color(0xFFE1F0DA),
  const Color(0xFFD4E7C5),
  const Color(0xFFBFD8AF),
];
