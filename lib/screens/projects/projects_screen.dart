import 'package:blog_web_site/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blog_web_site/screens/projects/showcase_app_item.dart';
import 'package:blog_web_site/services/firestore/changelogs/changelogs_controller.dart';

class MyProjectsPage extends ConsumerStatefulWidget {
  const MyProjectsPage({
    super.key,
  });

  @override
  ConsumerState<MyProjectsPage> createState() => _MyProjectsPageState();
}

class _MyProjectsPageState extends ConsumerState<MyProjectsPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundC = colorScheme.surface;
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        color: backgroundC,
        child: ref.watch(changelogAllProvider).when(
              data: (data) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      children: data.map((e) {
                        //final availableWidth = constraints.maxWidth;

                        //final rowItemCount = kIsWeb ? 3 : 2;

                        //final itemWidth =
                        //    (availableWidth - ((rowItemCount - 1) * 16.0)) /
                        //        rowItemCount;

                        return SizedBox(
                          width: 250,
                          child: ShowcaseAppItem(e),
                        );
                      }).toList(),
                    );
                  },
                );
              },
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
              loading: () => CenterLoading(withText: true)
            ),
      ),
    );
  }
}
