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

class CustomNotification extends StatelessWidget {
  const CustomNotification({
    super.key,
    required this.message,
    this.isError = false,
  });

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10, color: colorScheme.onPrimaryContainer),
            ),
          ),
        ),
      ),
    );
  }
}

class DiagonalPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height - 112.0)
      ..lineTo(size.width, 0.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

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

class CenterLoading extends StatelessWidget {
  final bool withText;
  const CenterLoading({super.key, this.withText = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator.adaptive(),
          if (withText) const Text('Yükleniyor...'),
        ],
      ),
    );
  }
}
