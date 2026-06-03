import 'package:blog_web_site/core/utils/center_error.dart';
import 'package:blog_web_site/features/projects/viewmodels/projects_view_model.dart';
import 'package:blog_web_site/shared/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/project_card.dart';

class ProjectsView extends ConsumerWidget {
  const ProjectsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final projectsState = ref.watch(projectsProvider);
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: projectsState.when(
        data: (projects) => SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1400),
              padding: EdgeInsets.symmetric(
                horizontal: isSmall ? 24.0 : 80.0,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageHeader(
                    bigTitle: 'WORKS',
                    subtitle: 'Selected Works',
                    title: 'Seçilmiş Çalışmalar',
                    description:
                        'Yüksek sadakatli uygulamalar, deneysel arayüzler ve teknik keşiflerden oluşan küratörlü bir arşiv. İşlevsellik ile estetiğin birleşimi.',
                  ),
                  
                  // Filter Bar Placeholder (can be implemented later)
                  const SizedBox(height: 40),

                  // GRID OF PROJECTS
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 1200
                          ? 3
                          : constraints.maxWidth > 800
                              ? 2
                              : 1;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          mainAxisExtent: 500,
                        ),
                        itemCount: projects.length,
                        itemBuilder: (context, index) {
                          final project = projects[index];
                          // Simple logic to assign variants if not present in DB
                          final displayProject = project.copyWith(
                            variant: index == 0 ? 'featured' : 'tile',
                            stack: project.stack ?? ['Flutter', 'Firebase'],
                          );
                          
                          return ProjectCard(project: displayProject);
                        },
                      );
                    },
                  ),
                  
                  const SizedBox(height: 100),
                  
                  // CTA SECTION
                  _buildCTA(context),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => CenterLoading(withText: true),
      ),
    );
  }

  Widget _buildCTA(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 800;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sıradaki projeye\nbaşlamaya hazır mısın?',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                  fontSize: isSmall ? 32 : 48,
                ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              _buildCTAButton(context, 'İLETİŞİME GEÇ', true),
              _buildCTAButton(context, 'ÖZGEÇMİŞİ İNDİR', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButton(BuildContext context, String label, bool isPrimary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      decoration: BoxDecoration(
        color: isPrimary ? Colors.white : Colors.transparent,
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isPrimary ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          fontSize: 12,
        ),
      ),
    );
  }
}
