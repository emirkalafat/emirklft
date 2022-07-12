import 'package:animate_icons/animate_icons.dart';
import 'package:blog_web_site/widgets/first_page.dart';
import 'package:blog_web_site/widgets/side_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class WideScreen extends StatefulWidget {
  const WideScreen({
    Key? key,
    required this.isim,
    required this.selectedPageNameProvider,
  }) : super(key: key);
  final String isim;
  final StateProvider<String> selectedPageNameProvider;
  @override
  State<WideScreen> createState() => _WideScreenState();
}

class _WideScreenState extends State<WideScreen> {
  AnimateIconController controller = AnimateIconController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          widget.isim,
          style: GoogleFonts.getFont("Ubuntu"),
        ),
        centerTitle: true,
      ),
      body: FirstPage(),
      drawer: SideArea(
        controller: controller,
        selectedPageNameProvider: widget.selectedPageNameProvider,
      ),
    );
  }
}
