import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import '../widgets/home/about_widget.dart';
import '../widgets/home/external_links_widget.dart';
import '../widgets/home/home_funcs_widget.dart';
import '../widgets/home/my_skills_widget.dart';
import '../widgets/home/welcome_widget.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.of(context).size;
    final currentTheme = AdaptiveTheme.of(context);

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
      backgroundColor: colorScheme.onPrimary,
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
                WelcomeSection(screenSize: screenSize, scroll: scroll),
                HomeScreenFunctionsSection(
                    screenSize: screenSize,
                    colorScheme: colorScheme,
                    currentTheme: currentTheme),
                //!AboutSection(screenSize: screenSize, colorScheme: colorScheme),
                //TODO: hakkında bölümü hazırlanacak.
                MySkillsSection(
                    colorScheme: colorScheme,
                    screenSize: screenSize,
                    verticalScroll: verticalScroll),
                const MyLinksSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
