import 'package:flutter/material.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({
    Key? key,
    required this.menu,
    required this.content,
    this.breakpoint = 600,
    this.menuWidth = 240,
  }) : super(key: key);
  final Widget menu;
  final Widget content;
  final double breakpoint;
  final double menuWidth;

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= widget.breakpoint) {
      return Row(
        children: [
          SizedBox(
            width: widget.menuWidth,
            child: widget.menu,
          ),
          Container(width: 0.5, color: Colors.black),
          Expanded(child: widget.content),
        ],
      );
    } else {
      // narrow screen: show content, menu inside drawer
      return Scaffold(
        body: widget.content,
        drawer: SizedBox(
          width: widget.menuWidth,
          child: Drawer(
            child: widget.menu,
          ),
        ),
      );
      /*LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth / constraints.maxHeight >
              1.2 /*&&
          screenWidth >= breakpoint*/
          ) {
        return const NarrowScreen(isim: StringConst.appName);
      } else {
        return const WideScreen(isim: StringConst.appName);
      }
    });*/
    }
  }
}
