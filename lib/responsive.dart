import 'package:blog_web_site/screens/narrow_screen.dart';
import 'package:blog_web_site/screens/wide_screen.dart';
import 'package:blog_web_site/values/values.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({Key? key}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth / constraints.maxHeight > 1.2) {
        return const NarrowScreen(isim: StringConst.appName);
      } else {
        return const WideScreen(isim: StringConst.appName);
      }
    });
  }
}
