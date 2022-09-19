import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../widgets/side_menu.dart';

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SingleChildScrollView(
        primary: true,
        child: Center(
          child: Container(
            constraints: BoxConstraints(
                maxWidth: 1500, minWidth: 1200, maxHeight: screenSize.height),
            child: screenSize.width < 800
                ? Column(
                    children: const [
                      HomeScreenMainSide(),
                    ],
                  )
                : Row(
                    children: const [
                      Expanded(
                        flex: 2,
                        child: MainScreenSideMenu(),
                      ),
                      Expanded(
                        flex: 7,
                        child: HomeScreenMainSide(),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class HomeScreenMainSide extends StatelessWidget {
  const HomeScreenMainSide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = AdaptiveTheme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.background,
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
                if (currentTheme.mode == AdaptiveThemeMode.dark) {
                  currentTheme.setThemeMode(AdaptiveThemeMode.light);
                } else {
                  currentTheme.setThemeMode(AdaptiveThemeMode.dark);
                }
              },
              child: const Text("Temayı Değiştir"),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                showTopSnackBar(
                  context,
                  const MyCustomTopBar(
                    message: 'Bildirim Testi',
                  ),
                );
              },
              child: const Text("Notification Test")),
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
    );
  }
}

class MyCustomTopBar extends StatelessWidget {
  const MyCustomTopBar({
    Key? key,
    required this.message,
    this.isError = false,
  }) : super(key: key);

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
                  fontSize: 24, color: colorScheme.onPrimaryContainer),
            ),
          ),
        ),
      ),
    );
  }
}
