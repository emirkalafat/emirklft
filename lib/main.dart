import 'package:flutter/material.dart';

import 'screens/wide_screen.dart';
import 'values/values.dart';

void main() {
  runApp(const WebApp());
}

class WebApp extends StatelessWidget {
  const WebApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConst.appName,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const WideScreen(isim: StringConst.appName),
    );
  }
}
