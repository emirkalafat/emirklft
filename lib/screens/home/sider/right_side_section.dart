import 'package:flutter/material.dart';

class RightSideSection extends StatelessWidget {
  final double sideSpacing;
  const RightSideSection({
    Key? key,
    required this.sideSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sideSpacing,
    );
  }
}
