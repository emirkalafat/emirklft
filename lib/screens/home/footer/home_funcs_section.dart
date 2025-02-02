import 'package:blog_web_site/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomeScreenFunctionsSection extends StatelessWidget {
  const HomeScreenFunctionsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      constraints: BoxConstraints(
          minWidth: screenSize.width, maxHeight: 150, minHeight: 150),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                showTopSnackBar(
                  Overlay.of(context),
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
                context.go('/yemekdeposu');
              },
              child: const Text("Yemek Deposu Gizlilik Sözleşmesi"),
            ),
          ),
        ],
      ),
    );
  }
}
