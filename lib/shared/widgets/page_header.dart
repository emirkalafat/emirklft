import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageHeader extends StatelessWidget {
  final String bigTitle;
  final String subtitle;
  final String title;
  final String description;

  const PageHeader({
    super.key,
    required this.bigTitle,
    required this.subtitle,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(
        bottom: isSmall ? 60 : 100,
        top: isSmall ? 40 : 60,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // GHOST TITLE (Absolute background)
          Positioned(
            top: -60,
            left: -20,
            child: Opacity(
              opacity: 0.03,
              child: Text(
                bigTitle.toUpperCase(),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: isSmall ? 100 : 220,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -15,
                    ),
              ),
            ),
          ),

          // CONTENT
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SUBTITLE WITH INDICATOR
              Row(
                children: [
                  Container(
                    height: 1,
                    width: 40,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    subtitle.toUpperCase(),
                    style: GoogleFonts.spaceMono(
                      textStyle: TextStyle(
                        color: colorScheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // MAIN TITLE
              Text(
                title,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: isSmall ? 48 : 96,
                      fontWeight: FontWeight.bold,
                      height: 0.9,
                      letterSpacing: -4,
                    ),
              ),
              const SizedBox(height: 32),

              // DESCRIPTION WITH BORDER
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                padding: const EdgeInsets.only(left: 24),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: colorScheme.primary.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontWeight: FontWeight.w300,
                        fontSize: isSmall ? 16 : 20,
                        height: 1.6,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
