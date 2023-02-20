import 'package:flutter/material.dart';
import 'about_me_section.dart';
import 'external_links_section.dart';
import 'home_funcs_section.dart';
import 'my_skills_section.dart';
import 'timeline_section.dart';
import 'welcome_section.dart';

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
      backgroundColor: Colors.transparent,
      body: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            // ignore: avoid_print
            print(scroll.position.pixels);
            setState(() {
              showButton = scroll.position.pixels > 100;
            });
          }
          return true;
        },
        child: SingleChildScrollView(
          controller: scroll,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WelcomeSection(scroll: scroll),
                const AboutMeSection(),
                const SizedBox(height: 20),
                const TimelineSection(),
                MySkillsSection(verticalScroll: verticalScroll),
                const HomeScreenFunctionsSection(),
                const MyLinksSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
