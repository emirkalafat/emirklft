import 'package:beamer/beamer.dart';
import 'package:blog_web_site/color_schemes.dart';
import 'package:blog_web_site/firebase_options.dart';
import 'package:blog_web_site/router/location_builder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
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
    return MaterialApp.router(
      scaffoldMessengerKey: messengerKey,
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher:
          BeamerBackButtonDispatcher(delegate: routerDelegate),
      theme: ThemeData(
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      title: 'Ahmet Emir Kalafat',
    );
  }
}
