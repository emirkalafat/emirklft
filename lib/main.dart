import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:blog_web_site/app.dart';
import 'package:blog_web_site/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);

  FirebaseAnalytics.instance.logAppOpen();

  FirebaseUIAuth.configureProviders([
    GoogleProvider(clientId: '1015551801756-rtls12icqg2o0k9f5hssgm5nk5sc52gl.apps.googleusercontent.com'),
  ]);

  runApp(const ProviderScope(child: WebApp()));
}


