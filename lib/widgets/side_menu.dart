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
    return Container(
      color: colorScheme.secondaryContainer,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.23,
            child: Container(
              color: colorScheme.primaryContainer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  const CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
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
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      InfoText("Ülke", "Türkiye"),
                      InfoText("Şehir", "İstanbul"),
                      InfoText("Yaş", "20"),
                    ],
                  ),
                ),
                Divider(),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Yeteneklerim"),
                  ),
                ),
                MySkills(),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
