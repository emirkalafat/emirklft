import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/first_page.dart';
import '../widgets/side_area.dart';

class NarrowScreen extends StatefulWidget {
  const NarrowScreen({
    Key? key,
    required this.isim,
    required this.selectedPageNameProvider,
  }) : super(key: key);

  final String isim;
  final StateProvider<String> selectedPageNameProvider;

  @override
  State<NarrowScreen> createState() => _NarrowScreenState();
}

class _NarrowScreenState extends State<NarrowScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildDrawer(context),
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: Text(
                widget.isim,
                style: GoogleFonts.getFont("Ubuntu"),
              ),
              centerTitle: true,
            ),
            body: FirstPage(),
          ),
        ),
      ],
    );
  }

  SideArea buildDrawer(BuildContext context) {
    AnimateIconController controller = AnimateIconController();
    return SideArea(
      controller: controller,
      selectedPageNameProvider: widget.selectedPageNameProvider,
    );
  }
}
