import 'package:flutter/material.dart';

import '../default_widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({
    Key? key,
    required this.screenSize,
    required this.colorScheme,
  }) : super(key: key);

  final Size screenSize;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: buildDefaultConstraints(
          minWidth: screenSize.width,
          minHeight: (screenSize.height - 56),
          maxHeight: (screenSize.height - 56)),
      color: colorScheme.tertiaryContainer,
      child: const Text("Hakkımda"),
    );
  }
}
