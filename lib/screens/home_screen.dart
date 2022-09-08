import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = AdaptiveTheme.of(context);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hello World!"),
          ElevatedButton(
            onPressed: () {
              context.beamToNamed('/projects');
            },
            child: Text("Projelerim"),
          ),
          ElevatedButton(
            onPressed: () {
              if (currentTheme.mode == AdaptiveThemeMode.dark) {
                currentTheme.setThemeMode(AdaptiveThemeMode.light);
              } else {
                currentTheme.setThemeMode(AdaptiveThemeMode.dark);
              }
            },
            child: Text("Temayı Değiştir"),
          ),
          ElevatedButton(
            onPressed: () {
              context.beamToNamed('/enfestarifler');
            },
            child: Text("Enfes Tarifler Gizlilik Sözleşmesi"),
          ),
        ],
      ),
    ));
  }
}
