import 'package:flutter/material.dart';

class CenterLoading extends StatelessWidget {
  final bool withText;
  const CenterLoading({super.key, this.withText = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator.adaptive(),
          if (withText) const Text('Yükleniyor...'),
        ],
      ),
    );
  }
}