import 'dart:ui';
import 'package:blog_web_site/core/theme.dart';
import 'package:blog_web_site/screens/home/footer/home_funcs_section.dart';
import 'package:blog_web_site/screens/home/footer/landing_footer.dart';
import 'package:blog_web_site/screens/home/header/landing_header.dart';
import 'package:blog_web_site/screens/home/info/about_me_section.dart';
import 'package:blog_web_site/screens/home/info/expertise_section.dart';
import 'package:blog_web_site/screens/home/info/tech_arsenal_section.dart';
import 'package:blog_web_site/screens/home/info/projects_preview_section.dart';
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
          // 1. GRID PATTERN (Subtle)
          Positioned.fill(
            child: Opacity(
              opacity: 0.03,
              child: CustomPaint(
                painter: _GridPainter(),
              ),
            ),
          ),

          // 2. ATMOSPHERIC BLURS
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

          // 3. MAIN SCROLLABLE CONTENT
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
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1600),
                    child: Column(
                      children: [
                        LandingHeader(
                          scroll: scroll,
                        ),
                        const ExpertiseSection(),
                        const ProjectsPreviewSection(),
                        const AboutMeSection(),
                        const TechArsenalSection(),
                        const SizedBox(height: 60.0),
                        const HomeScreenFunctionsSection(),
                        const SizedBox(height: 60.0),
                        const LandingFooter(),
                        const SizedBox(height: 60.0),
                      ],
                    ),
                  ),
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

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;

    const step = 80.0;

    for (double i = 0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
