import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:beamer/beamer.dart';
import 'package:blog_web_site/color_schemes.dart';
import 'package:blog_web_site/router/location_builder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WebApp());
}

class WebApp extends StatefulWidget {
  const WebApp({Key? key}) : super(key: key);

  @override
  State<WebApp> createState() => _WebAppState();
}

class _WebAppState extends State<WebApp> {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
  }

  final routerDelegate = BeamerDelegate(
    locationBuilder: locationBuilder,
  );

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      dark: ThemeData(
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp.router(
        scaffoldMessengerKey: messengerKey,
        routerDelegate: routerDelegate,
        routeInformationParser: BeamerParser(),
        backButtonDispatcher:
            BeamerBackButtonDispatcher(delegate: routerDelegate),
        theme: theme,
        darkTheme: darkTheme,
        title: 'Ahmet Emir Kalafat',
      ),
    );
  }
}
