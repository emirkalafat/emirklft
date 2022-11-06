import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:beamer/beamer.dart';
import 'package:blog_web_site/color_schemes.dart';
import 'package:blog_web_site/router/location_builder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_strategy/url_strategy.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAZGyMZW6ozuvYdRXc6hS0kdvCHUCYqmyc",
        authDomain: "emirklftweb.firebaseapp.com",
        projectId: "emirklftweb",
        storageBucket: "emirklftweb.appspot.com",
        messagingSenderId: "765811960780",
        appId: "1:765811960780:web:9b1bb4279c315bedab0b69",
        measurementId: "G-YPP105Q358"),
  );
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
