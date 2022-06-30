import 'package:blog_web_site/app_theme.dart';
import 'package:blog_web_site/values/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization =
      Firebase.initializeApp(options: firebaseOptions);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeData,
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              // ignore: avoid_print
              print("error");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return const MyHomePage();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ahmet Emir Kalafat",
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "HEy Ben Emir seni lanet olası",
        ),
      ),
    );
  }
}
