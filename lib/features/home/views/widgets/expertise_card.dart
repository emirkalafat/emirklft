import 'package:flutter/material.dart';

class ExpertiseCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;
  final double width;
  final double marginTop;

  const ExpertiseCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
    required this.width,
    this.marginTop = 0,
  });

  @override
  State<ExpertiseCard> createState() => _ExpertiseCardState();
}

class _ExpertiseCardState extends State<ExpertiseCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuart,
          width: widget.width,
          margin: EdgeInsets.only(top: widget.marginTop),
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.white.withValues(alpha: 0.04) : Colors.white.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? widget.accentColor.withValues(alpha: 0.4) : Colors.white.withValues(alpha: 0.05),
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: widget.accentColor.withValues(alpha: 0.05),
                  blurRadius: 40,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: widget.accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.icon,
                  color: widget.accentColor,
                  size: 28,
                ),
              ),
              const SizedBox(height: 32),
              
              // Title
              Text(
                widget.title.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 16),
              
              // Description
              Text(
                widget.description,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Animated Bottom Line
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: _isHovered ? widget.width * 0.4 : 0,
                height: 2,
                color: widget.accentColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
