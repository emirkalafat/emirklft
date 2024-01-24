import 'package:flutter/material.dart';

class RightSideSection extends StatelessWidget {
  final double sideSpacing;
  const RightSideSection({
    super.key,
    required this.sideSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sideSpacing,
    );
  }
}
