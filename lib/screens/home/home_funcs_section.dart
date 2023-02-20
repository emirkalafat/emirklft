import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../widgets/custom_notification.dart';
import '../../widgets/default_widgets.dart';

class HomeScreenFunctionsSection extends StatelessWidget {
  const HomeScreenFunctionsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      constraints: buildDefaultConstraints(
          minWidth: screenSize.width, maxHeight: 150, minHeight: 150),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //const Padding(
          //  padding: EdgeInsets.all(8.0),
          //  child: Text("Hello World!"),
          //),
          //Padding(
          //  padding: const EdgeInsets.all(8.0),
          //  child: ElevatedButton(
          //    onPressed: () {
          //      if (currentTheme.mode != AdaptiveThemeMode.light) {
          //        currentTheme.setThemeMode(AdaptiveThemeMode.light);
          //      } else {
          //        currentTheme.setThemeMode(AdaptiveThemeMode.dark);
          //      }
          //    },
          //    child: const Text("Temayı Değiştir"),
          //  ),
          //),
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
              child: const Text("Yemek Deposu Gizlilik Sözleşmesi"),
            ),
          ),
        ],
      ),
    );
  }
}
