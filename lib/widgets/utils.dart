import 'package:flutter/material.dart';
import '../color_schemes.dart';

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
}
