import 'package:blog_web_site/features/projects/viewmodels/projects_view_model.dart';
import 'package:blog_web_site/features/projects/views/widgets/project_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class ProjectsPreviewSection extends ConsumerWidget {
  const ProjectsPreviewSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsState = ref.watch(projectsProvider);
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '03 / PROJECTS',
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
                    'SELECTED WORKS.',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -2,
                        ),
                  ),
                ],
              ),
              if (!isSmall)
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => context.go('/projects'),
                    child: Row(
                      children: [
                        Text(
                          'TÜMÜNÜ GÖR',
                          style: GoogleFonts.spaceMono(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 60),

          // PREVIEW GRID
          projectsState.when(
            data: (projects) {
              final previewItems = projects.take(2).toList();
              return LayoutBuilder(builder: (context, constraints) {
                final crossAxisCount = isSmall ? 1 : 2;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 32,
                    mainAxisSpacing: 32,
                    mainAxisExtent: 500,
                  ),
                  itemCount: previewItems.length,
                  itemBuilder: (context, index) {
                    final project = previewItems[index].copyWith(
                      variant: 'tile',
                      stack: previewItems[index].stack ?? ['Flutter', 'Firebase'],
                    );
                    return ProjectCard(project: project);
                  },
                );
              });
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => const SizedBox.shrink(),
          ),
          
          if (isSmall) ...[
            const SizedBox(height: 40),
            Center(
              child: TextButton(
                onPressed: () => context.go('/projects'),
                child: const Text('TÜM PROJELERİ GÖR'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
