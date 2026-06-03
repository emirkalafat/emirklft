import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/tech_item.dart';
import 'tech_badge.dart';

class TechArsenalSection extends StatelessWidget {
  const TechArsenalSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 24.0 : 80.0,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '05 / ARSENAL',
                    style: GoogleFonts.spaceMono(
                      textStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'TECH STACK.',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: -2,
                        ),
                  ),
                ],
              ),
              if (!isSmall)
                Text(
                  '// 12+ TECHNOLOGIES',
                  style: GoogleFonts.spaceMono(
                    textStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.2),
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 60),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.05)),
          const SizedBox(height: 80),

          // TECH BADGES GRID
          Center(
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: _techItems.map((tech) => TechBadge(tech: tech)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

const _techItems = [
  TechItem(name: 'Flutter', icon: Icons.bolt),
  TechItem(name: 'Dart', icon: Icons.terminal),
  TechItem(name: 'React', icon: Icons.code),
  TechItem(name: 'Next.js', icon: Icons.layers),
  TechItem(name: 'TypeScript', icon: Icons.integration_instructions),
  TechItem(name: 'Firebase', icon: Icons.cloud_queue),
  TechItem(name: 'Node.js', icon: Icons.dns),
  TechItem(name: 'Python', icon: Icons.api),
  TechItem(name: 'Git', icon: Icons.commit),
  TechItem(name: 'GitHub', icon: Icons.hub),
  TechItem(name: 'C++', icon: Icons.settings_ethernet),
  TechItem(name: 'SQL', icon: Icons.storage),
];
