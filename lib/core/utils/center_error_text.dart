import 'package:flutter/material.dart';

class CenterErrorText extends StatelessWidget {
  final String error;
  const CenterErrorText(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}