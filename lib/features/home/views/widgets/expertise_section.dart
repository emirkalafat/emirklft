import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'expertise_card.dart';

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
                color: Colors.white.withValues(alpha: 0.4),
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
                  ExpertiseCard(
                    title: 'Frontend',
                    description: 'Modern, akıcı ve piksel hassasiyetinde arayüzler. Motion ve mikro-etkileşimler odaklı kullanıcı deneyimi.',
                    icon: Icons.data_thresholding_outlined,
                    accentColor: colorScheme.primary,
                    width: cardWidth,
                  ),
                  ExpertiseCard(
                    title: 'Backend',
                    description: 'Ölçeklenebilir mimariler, güvenli API tasarımları ve veritabanı optimizasyonları ile sistemin kalbi.',
                    icon: Icons.dns_outlined,
                    accentColor: colorScheme.secondary,
                    width: cardWidth,
                    marginTop: isSmall ? 0 : 60,
                  ),
                  ExpertiseCard(
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
