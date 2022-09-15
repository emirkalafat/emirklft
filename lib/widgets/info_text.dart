import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  final String title, text;
  const InfoText(
    this.title,
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(text),
        ],
      ),
    );
  }
}
