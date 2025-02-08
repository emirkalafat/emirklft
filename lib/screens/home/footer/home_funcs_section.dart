import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
