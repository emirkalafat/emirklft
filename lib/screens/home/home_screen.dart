import 'package:blog_web_site/core/theme.dart';
import 'package:blog_web_site/screens/home/footer/home_funcs_section.dart';
import 'package:blog_web_site/screens/home/footer/landing_footer.dart';
import 'package:blog_web_site/screens/home/header/landing_header.dart';
import 'package:blog_web_site/screens/home/info/about_me_section.dart';
import 'package:blog_web_site/screens/home/info/timeline_section.dart';
import 'package:blog_web_site/screens/home/sider/left_side_section.dart';
import 'package:blog_web_site/screens/home/sider/right_side_section.dart';
import 'package:blog_web_site/widgets/delayed_widget.dart';
import 'package:blog_web_site/widgets/home/weather_side_card.dart';
import 'package:blog_web_site/widgets/home/currency_side_card.dart';  // Add this import
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
      backgroundColor: colorScheme.surface,
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //TODO: Bu boşluklar belli bir ekran boyutundan sonra görünmez yapılacak
                if (MediaQuery.of(context).size.width > 725)
                  LeftSideSection(sideSpacing: sideSpacing),
                Expanded(
                  child: Column(
                    children: [
                      LandingHeader(
                        scroll: scroll,
                      ),
                      //const SizedBox(height: 56),
                      const AboutMeSection(),
                      const SizedBox(height: 20),
                      if (MediaQuery.of(context).size.width <= 725)
                        const DelayedWidget(
                          from: DelayFrom.top,
                          delayDuration: Duration(milliseconds: 2000),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              WeatherSideCard(width: 200),
                              CurrencySideCard(width: 200),
                            ],
                          ),
                        ),

                      const TimelineSection(),
                      const HomeScreenFunctionsSection(),
                      const SizedBox(height: 60.0),
                      // 2 Buttons at bottom of landing: flutter.dev, github.com.
                      const LandingFooter(),
                      const SizedBox(height: 60.0),
                    ],
                  ),
                ),
                if (MediaQuery.of(context).size.width > 725)
                  const RightSideSection(sideSpacing: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
