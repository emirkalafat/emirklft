import 'package:flutter/material.dart';

class AppAdsTxt extends StatelessWidget {
  const AppAdsTxt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SelectableText(
          'google.com, pub-9917370156164474, DIRECT, f08c47fec0942fa0'),
    );
  }
}
