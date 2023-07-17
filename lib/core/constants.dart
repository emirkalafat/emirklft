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
      'Flutter Mobil ve Web Uygulama Geliştirici\nElektrik-Elektronik Mühendisi - Bilgisayar Mühendisi';

  static const webSiteURL = 'emirklftweb.web.app';
  static const gitHubProfileURL = 'https://github.com/emirkalafat';
  static const linkedInProfileURL = 'https://www.linkedin.com/in/emir-kalafat/';
  static const twitterURL = 'localhost';
  static const instagramProfileURL = 'https://www.instagram.com/aeklft/';
  static const youtubeProfileURL = 'https://www.youtube.com/@emirklft';
  static const eMail = 'mailto:emirklft@outlook.com';
  static const flutterWebSiteURL = 'https://flutter.dev';
  static const openSourceRepoURL = 'https://github.com/emirkalafat/emirklft';
  static const publicCVurl =
      "https://docs.google.com/document/d/1YRE8eCepquyiYQR0dgThBx3gFZak302e/edit?usp=sharing&ouid=102026540238976098790&rtpof=true&sd=true";

  static const aboutMeText =
      'Merhaba, Ben Ahmet Emir Kalafat.\n21 yaşındayım. Fatih Sultan Mehmet Vakıf Üniversitesi\'nde Elektrik-Elektronik Mühendisliği bölümünde okuyorum. Python, Java, Dart-Flutter, C ve C# dillerini biliyorum. İlk kodumu 12 yaşımda Python ile yazdım. Basit bir hesap makinesiydi. Aktif olarak Flutter Mobil ve Web uygulamaları yazıyorum. En son yazdığım uygulamamı Play Store\'da "Yemek Deposu" adıyla bulabilirsiniz.';

  static const Map<String, String> timeline = {
    '2023':
        'Erasmus eğitimim için Litvanya\'ya gittim. Buradaki terübelerimi bu sitede blog bölümünde paylaşıyorum.',
    '2022': 'İlk büyük ölçekli uygulamamı Play Store\'da yayınladım.',
    '2021':
        'Flutter ile bir çok uygulama geliştirdim. Bu uygulamayı da Flutter ile yazıyorum.',
    '2020':
        'Fatih Sultan Mehmet Vakıf Üniversitesi\'nde lisans eğitimime başladım. Flutter ile ilk uygulamamı yazdım. Bu uygulamayı da Flutter ile yazıyorum.',
    '2016':
        'Şehremini Anadolu Lisesi\'nde eğitime başladım.\nVisual Basic ile ilk uygulamamı yazdım. TicTacToe oyunuydu. Visual Basic\'i çok sevemedim.',
    '2013':
        'İlk uygulamamı Python ile yazdım. Basit bir hesap makinesi uygulamasıydı.',
  };
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

const _colorGradientDark = [
  Color.fromARGB(255, 18, 18, 20),
  Color.fromARGB(255, 25, 25, 27),
  Color.fromARGB(255, 18, 18, 20),
];

const _colorGradientLight = [
  Color(0xFFEBEBF4),
  Color(0xFFF4F4F4),
  Color(0xFFEBEBF4),
];

const shimmerGradientLight = LinearGradient(
  colors: _colorGradientLight,
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

const shimmerGradientDark = LinearGradient(
  colors: _colorGradientDark,
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
