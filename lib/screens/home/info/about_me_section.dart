import 'package:blog_web_site/core/constants.dart';
import 'package:blog_web_site/widgets/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({super.key});

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
          // SECTION LABEL
          _buildSectionLabel(context, '04 / IDENTITY'),
          const SizedBox(height: 20),

          // TITLE
          Text(
            'Beyond the Code.',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -2,
                ),
          ),
          const SizedBox(height: 40),

          // MAIN CONTENT SPLIT
          isSmall
              ? Column(
                  children: [
                    _buildStory(context),
                    const SizedBox(height: 60),
                    _buildPhilosophy(context),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildStory(context)),
                    const SizedBox(width: 80),
                    Expanded(child: _buildPhilosophy(context)),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.spaceMono(
            textStyle: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Yolculuk.',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
              ),
        ),
        const SizedBox(height: 32),
        _buildTimelineItem(context, '2024', 'Yazılım Geliştirici', 'Talsen Team GmbH Şirketinde aktif olarak çalışmaktayım.'),
        _buildTimelineItem(context, '2023', 'React Native & Erasmus', 'SameUp bünyesinde mobil uygulama geliştirme ve Litvanya\'da 5 aylık mühendislik eğitimi.'),
        _buildTimelineItem(context, '2021', 'Genesis', 'Bilgisayar Mühendisliği (ÇAP) başlangıcı ve Flutter ile tanışma.'),
      ],
    );
  }

  Widget _buildPhilosophy(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Felsefe.',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
              ),
        ),
        const SizedBox(height: 32),
        _buildPhilosophyCard(context, 'Performans Estetiktir', 'Hız bir özellik değil, bir histir. Hızlı değilse, güzel değildir.'),
        _buildPhilosophyCard(context, 'Zarif Karmaşıklık', 'Sistemler gerektiği kadar karmaşık olmalı. Yalınlık, en yüksek gelişmişlik düzeyidir.'),
      ],
    );
  }

  Widget _buildTimelineItem(BuildContext context, String year, String title, String desc) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.primary, width: 2),
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.white.withOpacity(0.1),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  year,
                  style: GoogleFonts.spaceMono(
                    textStyle: TextStyle(color: colorScheme.primary, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  desc,
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhilosophyCard(BuildContext context, String title, String desc) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.secondary,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            desc,
            style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}
