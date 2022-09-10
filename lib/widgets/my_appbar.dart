import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: InkWell(
      child: const Text("Ahmet Emir Kalafat"),
      onTap: () {
        context.popToNamed('/');
      },
    ),
    actions: [
      TextButton(
        onPressed: () {
          context.beamToNamed('/about');
        },
        child: const Text('Hakkımda'),
      ),
      TextButton(
        onPressed: () {},
        child: const Text('Projelerim'),
      ),
      TextButton(
        onPressed: () {},
        child: const Text('İletişim'),
      ),
      TextButton(
        onPressed: () {
          showAboutDialog(context: context);
        },
        child: const Text('Lisanslar'),
      ),
    ],
  );
}
