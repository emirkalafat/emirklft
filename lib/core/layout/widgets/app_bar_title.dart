import 'package:flutter/material.dart';
import '../../../widgets/animated_opacity_when_hovered.dart';

class AppBarTitle extends StatelessWidget {
  final VoidCallback onTap;

  const AppBarTitle({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacityWhenHovered(
      child: GestureDetector(
        onTap: onTap,
        child: const Text(
          "Ahmet Emir Kalafat",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
