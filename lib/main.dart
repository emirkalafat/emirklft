import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:blog_web_site/color_schemes.dart';
import 'package:blog_web_site/responsive.dart';
import 'package:flutter/material.dart';

import 'values/values.dart';

void main() {
  runApp(const WebApp());
}

class WebApp extends StatelessWidget {
  const WebApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      dark: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        theme: theme,
        darkTheme: darkTheme,
        title: StringConst.appName,
        home: const ResponsiveLayout(),
      ),
    );
  }
}
