import 'package:blog_web_site/screens/home/footer/home_funcs_section.dart';
import 'package:blog_web_site/screens/home/footer/landing_footer.dart';
import 'package:blog_web_site/screens/home/header/landing_header.dart';
import 'package:blog_web_site/screens/home/info/about_me_section.dart';
import 'package:blog_web_site/screens/home/info/timeline_section.dart';

import 'package:flutter/material.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  ScrollController scroll = ScrollController();
  ScrollController verticalScroll = ScrollController();
  bool showButton = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300), //scroll.offset == 0,
        child: showButton
            ? FloatingActionButton(
                onPressed: () {
                  scroll.animateTo(
                    0,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.ease,
                  );
                },
                child: const Icon(Icons.arrow_upward))
            : null,
      ),
      backgroundColor: colorScheme.background,
      body: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            setState(() {
              showButton = scroll.position.pixels > 100;
            });
          }
          return true;
        },
        child: Scrollbar(
          controller: scroll,
          child: SingleChildScrollView(
            controller: scroll,
            child: Column(
              children: [
                LandingHeader(
                  scroll: scroll,
                ),
                const SizedBox(height: 56),
                const AboutMeSection(),
                const SizedBox(height: 20),
                const TimelineSection(),
                const HomeScreenFunctionsSection(),
                const SizedBox(height: 60.0),
                // 2 Buttons at bottom of landing: flutter.dev, github.com.
                const LandingFooter(),
                const SizedBox(height: 60.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
