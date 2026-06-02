import 'dart:ui';
import 'package:blog_web_site/core/theme.dart';
import 'package:blog_web_site/screens/home/footer/home_funcs_section.dart';
import 'package:blog_web_site/screens/home/footer/landing_footer.dart';
import 'package:blog_web_site/screens/home/header/landing_header.dart';
import 'package:blog_web_site/screens/home/info/about_me_section.dart';
import 'package:blog_web_site/screens/home/sider/left_side_section.dart';
import 'package:blog_web_site/screens/home/sider/right_side_section.dart';
import 'package:blog_web_site/widgets/delayed_widget.dart';
import 'package:blog_web_site/widgets/home/weather_side_card.dart';
import 'package:blog_web_site/widgets/home/currency_side_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnaSayfa extends ConsumerStatefulWidget {
  const AnaSayfa({super.key});

  @override
  ConsumerState<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends ConsumerState<AnaSayfa> {
  final double sideSpacing = 200;

  ScrollController scroll = ScrollController();
  ScrollController verticalScroll = ScrollController();
  bool showButton = false;

  bool get isDark =>
      ref.watch(themeNotifierProvider.notifier).theme == ThemeMode.dark;

  Widget _buildBlurCircle(Color color, double size) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 150, sigmaY: 150),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          // BACKGROUND EFFECTS
          Positioned(
            top: -200,
            right: -200,
            child: _buildBlurCircle(colorScheme.primary.withOpacity(0.08), 800),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: _buildBlurCircle(colorScheme.secondary.withOpacity(0.05), 600),
          ),
          Positioned(
            top: size.height * 0.4,
            left: -150,
            child: _buildBlurCircle(colorScheme.primary.withOpacity(0.04), 500),
          ),
          Positioned(
            top: size.height * 0.7,
            right: -100,
            child: _buildBlurCircle(colorScheme.secondary.withOpacity(0.03), 400),
          ),

          // SCROLLABLE CONTENT
          NotificationListener(
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
                    const AboutMeSection(),
                    const SizedBox(height: 100),
                    const HomeScreenFunctionsSection(),
                    const SizedBox(height: 60.0),
                    const LandingFooter(),
                    const SizedBox(height: 60.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
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
    );
  }
}
