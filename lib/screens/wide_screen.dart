import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/my_body.dart';
import '../widgets/side_area.dart';

class NarrowScreen extends StatefulWidget {
  const NarrowScreen({
    Key? key,
    required this.isim,
  }) : super(key: key);

  final String isim;

  @override
  State<NarrowScreen> createState() => _NarrowScreenState();
}

class _NarrowScreenState extends State<NarrowScreen> {
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
      body: Row(
        children: [
          buildDrawer(context),
          Expanded(child: const MyBody()),
        ],
      ),
    );
  }

  SideArea buildDrawer(BuildContext context) {
    AnimateIconController controller = AnimateIconController();
    return SideArea(controller: controller);
  }
}
