import 'package:flutter/material.dart';

BoxConstraints buildDefaultConstraints({
  double maxWidth = double.infinity,
  double maxHeight = double.infinity,
  double minWidth = 0.0,

  //minHeight and minWidth is 0.0 by default
  double minHeight = 0.0,
}) {
  return BoxConstraints(
    minWidth: minWidth,
    maxWidth: maxWidth,
    minHeight: minHeight,
    maxHeight: maxHeight,
  );
}

class DefaultContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final double minWidth;
  final double maxHeight;
  final double minHeight;
  const DefaultContainer({
    Key? key,
    required this.child,
    required this.maxWidth,
    required this.minWidth,
    required this.maxHeight,
    required this.minHeight,
  }) : super(key: key);

  @override
  Container build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        minHeight: minHeight,
        minWidth: minWidth,
      ),
      child: child,
    );
  }
}
