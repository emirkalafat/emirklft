import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blog_web_site/core/router/location_builder.dart';
import 'package:blog_web_site/core/theme.dart';

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
