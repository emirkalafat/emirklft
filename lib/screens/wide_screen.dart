import 'package:flutter/material.dart';

class WideScreen extends StatelessWidget {
  const WideScreen({
    Key? key,
    required this.isim,
  }) : super(key: key);

  final String isim;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isim),
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
