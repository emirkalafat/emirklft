import 'package:flutter/material.dart';

import 'package:blog_web_site/widgets/delayed_widget.dart';
import 'package:blog_web_site/widgets/animated_opacity_when_hovered.dart';
import 'package:blog_web_site/core/utils.dart';

class SocialMediaButton extends StatelessWidget {
  final String url;
  final IconData iconData;
  final double size;
  final int index;

  const SocialMediaButton({
    required this.url,
    required this.iconData,
    required this.index,
    this.size = 30.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return DelayedWidget(
      delayDuration: Duration(milliseconds: 1500 + ((index + 1) * 125)),
      from: DelayFrom.bottom,
      child: AnimatedOpacityWhenHovered(
        child: IconButton(
          onPressed: () => Utils.startUrl(url),
          icon: Icon(
            iconData,
            color: colorScheme.onBackground,
            size: size,
          ),
        ),
      ),
    );
  }
}
