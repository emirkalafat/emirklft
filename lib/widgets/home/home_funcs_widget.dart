import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../custom_notification.dart';
import '../default_widgets.dart';

class HomeScreenFunctionsSection extends StatelessWidget {
  const HomeScreenFunctionsSection({
    Key? key,
    required this.screenSize,
    required this.colorScheme,
    required this.currentTheme,
  }) : super(key: key);

  final Size screenSize;
  final ColorScheme colorScheme;
  final AdaptiveThemeManager<ThemeData> currentTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: buildDefaultConstraints(
          minWidth: screenSize.width, maxHeight: 500, minHeight: 500),
      color: colorScheme.tertiaryContainer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                if (currentTheme.mode != AdaptiveThemeMode.light) {
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
                  const CustomNotification(
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
