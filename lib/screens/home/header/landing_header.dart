import 'package:blog_web_site/core/utils.dart';
import 'package:blog_web_site/screens/home/header/animated_header_items.dart';
import 'package:blog_web_site/screens/home/header/animated_background_image.dart';
import 'package:flutter/material.dart';

class LandingHeader extends StatelessWidget {
  final ScrollController scroll;

  const LandingHeader({
    super.key,
    required this.scroll,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DiagonalPathClipper(),
      child: Stack(
        fit: StackFit.loose,
        children: [
          //Ekran kaydırılırken hareket edebilen arkaplan resmi
          AnimatedBackgroundImage(scroll),

          //Arkaplan resminin üzerindeki bilgiler
          const Align(
            alignment: Alignment.center,
            child: AnimatedHeaderItems(),
          ),
        ],
      ),
    );
  }
}
