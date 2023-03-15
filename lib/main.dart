import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:blog_web_site/core/router/location_builder.dart';
import 'package:blog_web_site/core/theme.dart';
import 'package:blog_web_site/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  runApp(const ProviderScope(child: WebApp()));
}

class WebApp extends ConsumerStatefulWidget {
  const WebApp({Key? key}) : super(key: key);

  @override
  ConsumerState<WebApp> createState() => _WebAppState();
}

class _WebAppState extends ConsumerState<WebApp> {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  final routerDelegate = BeamerDelegate(
    initialPath: '/',
    locationBuilder: locationBuilder,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: const Locale('tr', 'TR'),
      scaffoldMessengerKey: messengerKey,
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: routerDelegate,
        alwaysBeamBack: true,
      ),
      theme: ref.watch(themeNotifierProvider),
      title: 'Ahmet Emir Kalafat',
    );
  }
}
