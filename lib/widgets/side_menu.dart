import 'package:flutter/material.dart';
import 'info_text.dart';
import 'my_skills.dart';

class MainScreenSideMenu extends StatelessWidget {
  const MainScreenSideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(
        //maxHeight: screenSize.height,
        minHeight: screenSize.height,
      ),
      color: colorScheme.secondaryContainer,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AspectRatio(
            aspectRatio: 1.20,
            child: SideMenuAvatarAndName(
                colorScheme: colorScheme, screenSize: screenSize),
          ),
          const SingleChildScrollView(
            child: SideMenuSkills(),
          ),
        ],
      ),
    );
  }
}

class SideMenuSkills extends StatelessWidget {
  const SideMenuSkills({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              InfoText("Ülke", "Türkiye"),
              InfoText("Şehir", "İstanbul"),
              InfoText("Yaş", "20"),
            ],
          ),
        ),
        const Divider(),
        const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Yeteneklerim"),
          ),
        ),
        Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: const MySkills()),
        //Expanded(child: Container()),
      ],
    );
  }
}

class SideMenuAvatarAndName extends StatelessWidget {
  const SideMenuAvatarAndName({
    Key? key,
    required this.colorScheme,
    required this.screenSize,
  }) : super(key: key);

  final ColorScheme colorScheme;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorScheme.primaryContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          CircleAvatar(
            radius: screenSize.width > 1200 ? 75.0 : screenSize.width / 20,
            backgroundImage: const AssetImage('assets/images/profile.jpg'),
          ),
          const Spacer(),
          Text('Ahmet Emir Kalafat',
              style: Theme.of(context).textTheme.subtitle2),
          const Text(
            'Flutter Mobil ve Web Uygulama Geliştirici',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w200, height: 1.5),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
