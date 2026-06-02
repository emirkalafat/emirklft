import 'package:blog_web_site/core/constants.dart';
import 'package:blog_web_site/widgets/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedHeaderItems extends StatelessWidget {
  const AnimatedHeaderItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        vertical: isSmall ? 60.0 : 120.0,
        horizontal: isSmall ? 24.0 : 80.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SYSTEM.READY Label
          DelayedWidget(
            delayDuration: const Duration(milliseconds: 500),
            from: DelayFrom.left,
            child: Row(
              children: [
                Container(
                  height: 1,
                  width: 50,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 16),
                Text(
                  'SYSTEM.READY',
                  style: GoogleFonts.spaceMono(
                    textStyle: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // HUGE TYPOGRAPHY
          DelayedWidget(
            delayDuration: const Duration(milliseconds: 800),
            from: DelayFrom.bottom,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CREATE',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: isSmall ? 80 : 160,
                          height: 0.8,
                          letterSpacing: -5,
                        ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 40),
                      Text(
                        'Digital',
                        style: GoogleFonts.playfairDisplay(
                          textStyle: TextStyle(
                            fontSize: isSmall ? 80 : 160,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.9),
                            height: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      // Outline Text
                      Text(
                        'REALITIES.',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: isSmall ? 80 : 160,
                              height: 0.8,
                              letterSpacing: -5,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 1
                                ..color = Colors.white.withOpacity(0.2),
                            ),
                      ),
                      // Hover overlay could be added here if needed
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 60),

          // PROFESSION & ABOUT BUTTON
          isSmall
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfessionText(context),
                    const SizedBox(height: 40),
                    _buildAboutButton(context),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(child: _buildProfessionText(context)),
                    const SizedBox(width: 40),
                    _buildAboutButton(context),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildProfessionText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.white.withOpacity(0.1),
        ),
        const SizedBox(height: 24),
        Text(
          'Bilgisayar ve Elektrik-Elektronik Mühendisi',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 18,
            fontWeight: FontWeight.w300,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Ahmet Emir Kalafat',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Navigation logic
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'HAKKIMDA',
                style: GoogleFonts.spaceMono(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(
                Icons.arrow_outward,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
