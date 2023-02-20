import 'package:flutter/material.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    //final screenSize = MediaQuery.of(context).size;
    //final currentTheme = AdaptiveTheme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 0, 24),
      child: Card(
          color: colorScheme.secondaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Hakkımda",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 150,
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                SelectableText(
                  'Merhaba, Ben Ahmet Emir Kalafat.\n 20 yaşındayım. Fatih Sultan Mehmet Vakıf Üniversitesi\'nde Elektrik-Elektronik Mühendisliği bölümünde okuyorum.\nPython, Java, Dart-Flutter, C ve C# dillerini biliyorum. İlk kodumu 12 yaşımda Python ile yazdım. Basit bir hesap makinesiydi.\nAktif olarak Flutter Mobil ve Web uygulamaları yazıyorum. En son yazdığım uygulamamı Play Store\'da "Yemek Deposu" adıyla bulabilirsiniz.',
                  //"Hi, I’m Ahmet Emir Kalafat.\nI’m 20 years old.\nI’m studying Elekctic-Electroincs Engineering at Fatih Sultan Mehmet University.\nI have experience with Java, Dart-Flutter, Python, C and C#.\nI started writing code with Python at 12 years old.\nI have experience with Flutter Android and Web app development.\nI have a mobil app called Enfes Yemek Tarifleri.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          )),
    );
  }
}
