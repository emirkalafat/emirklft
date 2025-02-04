import 'package:beamer/beamer.dart';
import 'package:blog_web_site/services/auth/auth_guard.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
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

  FirebaseAnalytics.instance.logAppOpen();

  FirebaseUIAuth.configureProviders(
    [
      GoogleProvider(
          clientId:
              '1015551801756-rtls12icqg2o0k9f5hssgm5nk5sc52gl.apps.googleusercontent.com'),
    ],
  );

  runApp(const ProviderScope(child: WebApp()));
}

class WebApp extends ConsumerStatefulWidget {
  const WebApp({super.key});

  @override
  ConsumerState<WebApp> createState() => _WebAppState();
}

class _WebAppState extends ConsumerState<WebApp> {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  final routerDelegate = BeamerDelegate(
      initialPath: '/linktree',
      locationBuilder: locationBuilder.call,
      guards: [
        AuthGuard(),
        BeamGuard(
          pathPatterns: ['/projects'],
          check: (context, location) => false,
          beamToNamed: (origin, target) => '/?tab=projects',
        ),
      ]);

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
