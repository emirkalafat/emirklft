import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:blog_web_site/core/router/location_builder.dart';
import 'package:blog_web_site/core/theme.dart';
import 'package:blog_web_site/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  FirebaseAnalytics.instance.logAppOpen();
  runApp(const ProviderScope(child: WebApp()));
}

class WebApp extends ConsumerStatefulWidget {
  const WebApp({super.key});

  @override
  ConsumerState<WebApp> createState() => _WebAppState();
}

class _WebAppState extends ConsumerState<WebApp> {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: const Locale('tr', 'TR'),
      scaffoldMessengerKey: messengerKey,
      routerConfig: router,
      theme: ref.watch(themeNotifierProvider),
      title: 'Ahmet Emir Kalafat',
    );
  }
}


