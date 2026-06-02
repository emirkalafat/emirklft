import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                        color: Colors.white.withOpacity(0.4),
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
                      color: Colors.white.withOpacity(0.2),
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 60),
          Container(height: 1, color: Colors.white.withOpacity(0.05)),
          const SizedBox(height: 80),

          // TECH BADGES GRID
          Center(
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: _techItems.map((tech) => _TechBadge(tech: tech)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TechBadge extends StatefulWidget {
  final _TechItem tech;
  const _TechBadge({required this.tech});

  @override
  State<_TechBadge> createState() => _TechBadgeState();
}

class _TechBadgeState extends State<_TechBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.01),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: _isHovered ? colorScheme.primary.withOpacity(0.5) : Colors.white.withOpacity(0.1),
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 2,
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.tech.icon,
              size: 18,
              color: _isHovered ? colorScheme.primary : Colors.white.withOpacity(0.4),
            ),
            const SizedBox(width: 12),
            Text(
              widget.tech.name.toUpperCase(),
              style: GoogleFonts.spaceMono(
                textStyle: TextStyle(
                  color: _isHovered ? Colors.white : Colors.white.withOpacity(0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechItem {
  final String name;
  final IconData icon;
  const _TechItem({required this.name, required this.icon});
}

const _techItems = [
  _TechItem(name: 'Flutter', icon: Icons.bolt),
  _TechItem(name: 'Dart', icon: Icons.terminal),
  _TechItem(name: 'React', icon: Icons.code),
  _TechItem(name: 'Next.js', icon: Icons.layers),
  _TechItem(name: 'TypeScript', icon: Icons.integration_instructions),
  _TechItem(name: 'Firebase', icon: Icons.cloud_queue),
  _TechItem(name: 'Node.js', icon: Icons.dns),
  _TechItem(name: 'Python', icon: Icons.api),
  _TechItem(name: 'Git', icon: Icons.commit),
  _TechItem(name: 'GitHub', icon: Icons.hub),
  _TechItem(name: 'C++', icon: Icons.settings_ethernet),
  _TechItem(name: 'SQL', icon: Icons.storage),
];
