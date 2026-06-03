import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/tech_item.dart';

class TechBadge extends StatefulWidget {
  final TechItem tech;
  const TechBadge({super.key, required this.tech});

  @override
  State<TechBadge> createState() => _TechBadgeState();
}

class _TechBadgeState extends State<TechBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.01),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: _isHovered ? colorScheme.primary.withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.1),
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.1),
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
                color: _isHovered ? colorScheme.primary : Colors.white.withValues(alpha: 0.4),
              ),
              const SizedBox(width: 12),
              Text(
                widget.tech.name.toUpperCase(),
                style: GoogleFonts.spaceMono(
                  textStyle: TextStyle(
                    color: _isHovered ? Colors.white : Colors.white.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
