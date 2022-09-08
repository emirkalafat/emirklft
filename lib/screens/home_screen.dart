import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = AdaptiveTheme.of(context);
    return Scaffold(
        appBar: AppBar(title: const Text("Ahmet Emir Kalafat")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Hello World!"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    context.beamToNamed('/projects');
                  },
                  child: const Text("Projelerim"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (currentTheme.mode == AdaptiveThemeMode.dark) {
                      currentTheme.setThemeMode(AdaptiveThemeMode.light);
                    } else {
                      currentTheme.setThemeMode(AdaptiveThemeMode.dark);
                    }
                  },
                  child: const Text("Temayı Değiştir"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    context.beamToNamed('/enfestarifler');
                  },
                  child: const Text("Enfes Tarifler Gizlilik Sözleşmesi"),
                ),
              ),
            ],
          ),
        ));
  }
}
