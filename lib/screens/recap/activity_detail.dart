import 'package:blog_web_site/core/utils/center_error.dart';
import 'package:blog_web_site/core/utils/utils.dart';
import 'package:blog_web_site/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blog_web_site/services/firestore/activities/activities_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import 'activity.dart';

class ActivityDetailScreen extends ConsumerWidget {
  final String activityId;
  final bool isDialog;

  const ActivityDetailScreen({
    super.key,
    required this.activityId,
    this.isDialog = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityAsync = ref.watch(activityProvider(activityId));
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;

    return activityAsync.when(
      data: (activity) {
        if (activity == null) {
          return const Scaffold(body: Center(child: Text('İçerik bulunamadı.')));
        }

        final mainContent = Stack(
          children: [
            // 1. Cinematic Background Image (Blurred)
            if (activity.imageUrl != null)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: size.height * 0.5,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        activity.imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                colorScheme.surface.withOpacity(0.4),
                                colorScheme.surface,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // 2. Scrollable Content
            Positioned.fill(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 900),
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmall ? 24.0 : 80.0,
                      vertical: 100,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        PageHeader(
                          bigTitle: activity.type.name.toUpperCase(),
                          subtitle: '${activity.startedDate?.year ?? 'N/A'} ARCHIVE',
                          title: activity.title,
                          description: 'İnceleme ve Kişisel Notlar',
                        ),

                        const SizedBox(height: 40),

                        // PERSONAL RATING & NOTE
                        if (activity.personalRating != null || activity.personalNote != null) ...[
                          _buildSectionLabel(context, 'MY PERSPECTIVE'),
                          const SizedBox(height: 24),
                          if (activity.personalRating != null)
                            _buildRating(context, activity.personalRating!),
                          const SizedBox(height: 24),
                          if (activity.personalNote != null)
                            TweenAnimationBuilder<double>(
                              duration: const Duration(milliseconds: 800),
                              tween: Tween(begin: 0.0, end: 1.0),
                              curve: Curves.easeOutCubic,
                              builder: (context, value, child) {
                                return Opacity(
                                  opacity: value,
                                  child: Transform.translate(
                                    offset: Offset(20 * (1 - value), 0),
                                    child: child,
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(32),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.02),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: colorScheme.primary.withOpacity(0.02),
                                      blurRadius: 40,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 24),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(color: colorScheme.primary, width: 3),
                                    ),
                                  ),
                                  child: Text(
                                    activity.personalNote!,
                                    style: GoogleFonts.playfairDisplay(
                                      textStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 22,
                                        fontStyle: FontStyle.italic,
                                        height: 1.6,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(height: 60),
                        ],

                        // OFFICIAL DESCRIPTION
                        _buildSectionLabel(context, 'SUMMARY'),
                        const SizedBox(height: 24),
                        Text(
                          activity.description,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 16,
                            height: 1.8,
                          ),
                        ),

                        const SizedBox(height: 40),

                        if (activity.url != null)
                          _buildLinkButton(context, 'OFFICIAL PAGE', Icons.link, activity.url!),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // 3. Back Button
            Positioned(
              top: 40,
              left: isSmall ? 20 : 40,
              child: Material(
                color: Colors.transparent,
                child: IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.05),
                  ),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/recap');
                    }
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),
          ],
        );

        if (isDialog) {
          return mainContent;
        }

        return Scaffold(
          backgroundColor: colorScheme.surface,
          body: mainContent,
        );
      },
      loading: () => CenterLoading(withText: true),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Text('Hata: $error'),
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

  Widget _buildRating(BuildContext context, double rating) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor()
              ? Icons.star
              : (index < rating ? Icons.star_half : Icons.star_outline),
          size: 28,
          color: index < rating ? colorScheme.primary : Colors.white.withOpacity(0.1),
        );
      }),
    );
  }

  Widget _buildLinkButton(BuildContext context, String label, IconData icon, String url) {
    return InkWell(
      onTap: () => Utils.startUrl(url),
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white.withOpacity(0.6), size: 18),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.spaceMono(
                textStyle: const TextStyle(
                  color: Colors.white,
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
