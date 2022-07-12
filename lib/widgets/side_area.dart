import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';

import '../values/values.dart';

class SideArea extends StatelessWidget {
  const SideArea({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AnimateIconController controller;

  @override
  Widget build(BuildContext context) {
    bool onThemePressed() {
      AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
          ? AdaptiveTheme.of(context).setLight()
          : AdaptiveTheme.of(context).setDark();
      return true;
      //Navigator.of(context).pop();
    }

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimateIcons(
                      startIcon: AdaptiveTheme.of(context).mode ==
                              AdaptiveThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.sunny,
                      endIcon: AdaptiveTheme.of(context).mode ==
                              AdaptiveThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.sunny,
                      controller: controller,
                      onStartIconPress: onThemePressed,
                      onEndIconPress: onThemePressed,
                      duration: const Duration(milliseconds: 500),
                      clockwise: false,
                      startIconColor:
                          Theme.of(context).colorScheme.onBackground,
                      endIconColor: Theme.of(context).colorScheme.onBackground,
                    ),
                    const Text("Temayı Değiştir"),
                  ],
                ),
                //ElevatedButton.icon(
                //  icon:
                //  onPressed: onThemePressed,
                //  label: const Text("Temayı Değiştir"),
                //),
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
}
