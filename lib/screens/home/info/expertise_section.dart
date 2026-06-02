import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpertiseSection extends StatelessWidget {
  const ExpertiseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 24.0 : 80.0,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Text(
            '02 / EXPERTISE',
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
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -2,
                  ),
              children: [
                const TextSpan(text: 'TECHNICAL '),
                TextSpan(
                  text: 'TOOLKIT.',
                  style: GoogleFonts.playfairDisplay(
                    textStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),

          // EXPERTISE GRID
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = isSmall ? constraints.maxWidth : (constraints.maxWidth - 64) / 3;
              return Wrap(
                spacing: 32,
                runSpacing: 40,
                children: [
                  _ExpertiseCard(
                    title: 'Frontend',
                    description: 'Modern, akıcı ve piksel hassasiyetinde arayüzler. Motion ve mikro-etkileşimler odaklı kullanıcı deneyimi.',
                    icon: Icons.data_thresholding_outlined,
                    accentColor: colorScheme.primary,
                    width: cardWidth,
                  ),
                  _ExpertiseCard(
                    title: 'Backend',
                    description: 'Ölçeklenebilir mimariler, güvenli API tasarımları ve veritabanı optimizasyonları ile sistemin kalbi.',
                    icon: Icons.dns_outlined,
                    accentColor: colorScheme.secondary,
                    width: cardWidth,
                    marginTop: isSmall ? 0 : 60,
                  ),
                  _ExpertiseCard(
                    title: 'Mobile',
                    description: 'Flutter ve React Native ile hibrit, yüksek performanslı ve native hissettiren mobil çözümler.',
                    icon: Icons.smartphone_outlined,
                    accentColor: Colors.white,
                    width: cardWidth,
                    marginTop: isSmall ? 0 : 120,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ExpertiseCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;
  final double width;
  final double marginTop;

  const _ExpertiseCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
    required this.width,
    this.marginTop = 0,
  });

  @override
  State<_ExpertiseCard> createState() => _ExpertiseCardState();
}

class _ExpertiseCardState extends State<_ExpertiseCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuart,
        width: widget.width,
        margin: EdgeInsets.only(top: widget.marginTop),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.white.withOpacity(0.04) : Colors.white.withOpacity(0.02),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? widget.accentColor.withOpacity(0.4) : Colors.white.withOpacity(0.05),
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: widget.accentColor.withOpacity(0.05),
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
                color: widget.accentColor.withOpacity(0.1),
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
                color: Colors.white.withOpacity(0.4),
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
    );
  }
}
