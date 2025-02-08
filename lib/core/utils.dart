import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'color_schemes.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text, {bool isError = true}) {
    if (text == null) {
      return;
    }

    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: isError ? darkColorScheme.error : Colors.white,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static startUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }

  static List<String> daysTR = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar'
  ];
}
