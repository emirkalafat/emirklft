import 'package:blog_web_site/core/utils/center_error.dart';
import 'package:blog_web_site/features/projects/viewmodels/projects_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/showcase_app_item.dart';

class ProjectsView extends ConsumerWidget {
  const ProjectsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final projectsState = ref.watch(projectsProvider);

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        color: colorScheme.surface,
        child: projectsState.when(
          data: (projects) => LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                direction: Axis.horizontal,
                spacing: 24.0,
                runSpacing: 24.0,
                alignment: WrapAlignment.center,
                children: projects.map((project) {
                  return SizedBox(
                    width: 300,
                    child: ShowcaseAppItem(project),
                  );
                }).toList(),
              );
            },
          ),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => CenterLoading(withText: true)
        ),
      ),
    );
  }
}
