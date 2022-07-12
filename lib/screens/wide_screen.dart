import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:blog_web_site/values/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WideScreen extends StatelessWidget {
  const WideScreen({
    Key? key,
    required this.isim,
  }) : super(key: key);

  final String isim;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: buildDrawer(context),
      body: buildBody(context),
    );
  }

  Column buildBody(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Center(
                    child: Text("Ahmet Emir Kalafat"),
                  ),
                  Center(
                    child: Text("Ahmet Emir Kalafat"),
                  ),
                ],
              ),
              const Center(
                child: Text("Ahmet Emir Kalafat"),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer),
            child: const Text("ahmet"),
          ),
        )
      ],
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                const DrawerHeader(
                  child: CircleAvatar(
                    maxRadius: 48,
                    backgroundImage: AssetImage('images/profile.jpg'),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                  ),
                  title: const Text('Page 1'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.train,
                  ),
                  title: const Text('Page 2'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Divider(),
                ElevatedButton(
                  onPressed: () {
                    AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                        ? AdaptiveTheme.of(context).setLight()
                        : AdaptiveTheme.of(context).setDark();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Temayı Değiştir"),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AboutListTile(
                    icon: Icon(Icons.favorite),
                    //applicationIcon: Icon(Icons.favorite),
                    applicationName: StringConst.appName,
                    applicationVersion: StringConst.appVersion,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(
        isim,
        style: GoogleFonts.getFont("Ubuntu"),
      ),
      centerTitle: true,
    );
  }
}
