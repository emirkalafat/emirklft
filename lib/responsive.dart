import 'package:flutter/material.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({
    Key? key,
    //responsive contents
    required this.menu,
    required this.content,
    //responsive values
    this.breakpoint = 750,
    this.menuWidth = 260,
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
      //wide screen : show content and drawer together
      return Row(
        children: [
          SizedBox(
            width: widget.menuWidth,
            child: widget.menu,
          ),
          Container(width: 0.5, color: Colors.grey),
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
    }
  }
}
