import 'package:flutter/material.dart';

const backgroundGradient = RadialGradient(
  colors: [
    Color.fromARGB(171, 56, 255, 238),
    Color.fromARGB(255, 0, 185, 25),
    Color.fromARGB(255, 0, 81, 255),
  ],
  focalRadius: 1.5,
  center: Alignment(1, -1),
  focal: Alignment(0.5, -0.2),
);

abstract class AppConstants {
  static const appTitle = 'Ahmet Emir Kalafat';

  static const landingTitle = 'Ahmet Emir Kalafat';
  static const landingMotto =
      'Flutter Mobil ve Web Uygulama Geliştirici - Elektrik-Elektronik Mühendisi - Bilgisayar Mühendisi';

  static const webSiteURL = 'emirklftweb.web.app';
  static const gitHubProfileURL = 'https://github.com/emirkalafat';
  static const linkedInProfileURL = 'https://www.linkedin.com/in/emir-kalafat/';
  static const twitterURL = 'localhost';
  static const instagramProfileURL = 'https://www.instagram.com/aeklft/';
  static const youtubeProfileURL = 'https://www.youtube.com/@emirklft';
  static const eMail = 'mailto:emirklft@outlook.com';
  static const flutterWebSiteURL = 'https://flutter.dev';
  static const openSourceRepoURL = 'https://github.com/emirkalafat/emirklft';

  static const aboutMeText =
      'Merhaba, Ben Ahmet Emir Kalafat.\n21 yaşındayım. Fatih Sultan Mehmet Vakıf Üniversitesi\'nde Elektrik-Elektronik Mühendisliği bölümünde okuyorum. Python, Java, Dart-Flutter, C ve C# dillerini biliyorum. İlk kodumu 12 yaşımda Python ile yazdım. Basit bir hesap makinesiydi. Aktif olarak Flutter Mobil ve Web uygulamaları yazıyorum. En son yazdığım uygulamamı Play Store\'da "Yemek Deposu" adıyla bulabilirsiniz.';
}

enum ColorSeed {
  baseColor('M3 Baseline', Color(0xff6750a4)),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;
}
