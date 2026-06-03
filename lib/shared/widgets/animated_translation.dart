import 'package:flutter/material.dart';

class AnimatedTranslation extends StatelessWidget {
  final Widget child;
  final Offset offset;

  const AnimatedTranslation({super.key, required this.child, required this.offset});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: Matrix4.translationValues(offset.dx, offset.dy, 0),
      child: child,
    );
  }
}
