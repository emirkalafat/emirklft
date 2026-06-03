import 'package:blog_web_site/shared/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blog_web_site/core/utils/utils.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 24.0 : 80.0,
              vertical: 60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HEADER
                const PageHeader(
                  bigTitle: 'IDENTITY',
                  subtitle: '01 / Background',
                  title: 'Kodun\nÖtesinde.',
                  description:
                      'Ben performansa ve estetiğe takıntılı bir sistem mimarı ve dijital zanaatkarım. Sadece uygulama geliştirmiyorum; dijital gerçeklikler tasarlıyorum.',
                ),

                const SizedBox(height: 80),

                // 2. CORE VALUES / PRINCIPLES
                _buildSectionLabel(context, '02 / PRINCIPLES'),
                const SizedBox(height: 40),
                LayoutBuilder(builder: (context, constraints) {
                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: [
                      _buildPrincipleCard(
                        context,
                        'Performans Estetiktir',
                        'Hız bir özellik değil, bir histir. Eğer hızlı değilse, güzel de değildir.',
                        constraints.maxWidth,
                      ),
                      _buildPrincipleCard(
                        context,
                        'Zarif Karmaşıklık',
                        'Sistemler gerektiği kadar karmaşık olmalı, daha fazlası değil. Yalınlık en yüksek gelişmişlik düzeyidir.',
                        constraints.maxWidth,
                      ),
                      _buildPrincipleCard(
                        context,
                        'Dijital Zanaatkarlık',
                        'Her kod satırı bir imzadır. Ona bir zanaatkarın titizliğiyle yaklaşırım.',
                        constraints.maxWidth,
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 100),

                // 3. CONNECT SECTION (CTA)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'HAYDİ İNŞA EDELİM.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: isSmall ? 40 : 80,
                              letterSpacing: -2,
                            ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Anlamlı iş birlikleri veya teknik mimari üzerine derin sohbetler için buradayım.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 60),
                      
                      // SOCIAL LINKS
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 40,
                        runSpacing: 30,
                        children: [
                          _buildSocialLink(context, 'GITHUB', 'https://github.com'),
                          _buildSocialLink(context, 'LINKEDIN', 'https://linkedin.com'),
                          _buildSocialLink(context, 'TWITTER', 'https://twitter.com'),
                        ],
                      ),
                      
                      const SizedBox(height: 80),
                      
                      // EMAIL BUTTON
                      InkWell(
                        onTap: () => Utils.startUrl('mailto:hello@emir.dev'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            'MESAJ GÖNDER',
                            style: GoogleFonts.spaceMono(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Text(
      label,
      style: GoogleFonts.spaceMono(
        textStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildPrincipleCard(BuildContext context, String title, String desc, double maxWidth) {
    final isSmall = maxWidth < 800;
    return Container(
      width: isSmall ? maxWidth : (maxWidth - 48) / 3,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.01),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            desc,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLink(BuildContext context, String label, String url) {
    return InkWell(
      onTap: () => Utils.startUrl(url),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.arrow_outward, size: 16, color: Colors.white54),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.spaceMono(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
