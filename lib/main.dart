import 'package:flutter/material.dart';

void main() {
  runApp(const WebApp());
}

class WebApp extends StatelessWidget {
  const WebApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Ahmet Emir Kalafat"),
          centerTitle: true,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NameWidget(),
                NameWidget(),
                NameWidget(),
              ],
            ),
            const Center(
              child: Text("Ahmet Emir Kalafat"),
            ),
          ],
        ),
      ),
    );
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Ahmet Emir Kalafat"),
    );
  }
}
