
import 'package:blog_web_site/widgets/animated_opacity_when_hovered.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:blog_web_site/core/constants.dart';

import 'package:blog_web_site/core/utils.dart';

class LandingFooter extends StatelessWidget {
  const LandingFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // GitHub repository reference.
        AnimatedOpacityWhenHovered(
          child: TextButton(
            onPressed: () {
              Utils.startUrl(AppConstants.openSourceRepoURL);
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Icon(
                FontAwesomeIcons.github,
                color: colorScheme.onBackground,
                size: 44.0,
              ),
            ),
            // iconSize: 120.0,
          ),
        ),
      ],
    );
  }
}
