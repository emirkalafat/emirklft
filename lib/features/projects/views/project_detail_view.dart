import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/project_detail_model.dart';
import '../models/project_version_filter_model.dart';
import '../viewmodels/project_details_view_model.dart';
import '../viewmodels/version_view_model.dart';
import 'widgets/app_version_card.dart';
import 'widgets/project_detail_content.dart';

class ProjectDetailView extends ConsumerStatefulWidget {
  final String projectId;
  const ProjectDetailView({super.key, required this.projectId});

  @override
  ConsumerState<ProjectDetailView> createState() => _ProjectDetailViewState();
}

class _ProjectDetailViewState extends ConsumerState<ProjectDetailView> {
  bool showBetaVersions = false;

  @override
  Widget build(BuildContext context) {
    final projectDetailState =
        ref.watch(projectDetailStreamProvider(widget.projectId));
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.go('/projects')),
      ),
      body: projectDetailState.when(
        data: (projects) {
          if (projects.isEmpty) {
            return const Center(child: Text('Proje bulunamadı'));
          }
          final project = projects.first;

          return SingleChildScrollView(
            child: Column(
              children: [
                ProjectDetailContent(project: project),
                const SizedBox(height: 32),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(width: 800, child: Divider()),
                ),
                _buildBetaSwitch(),
                _buildVersionsList(projects),
              ],
            ),
          );
        },
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildBetaSwitch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('Beta sürümlerini göster'),
            Switch(
              value: showBetaVersions,
              onChanged: (value) {
                setState(() {
                  showBetaVersions = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVersionsList(List<ProjectDetailModel> projects) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      child: ref.watch(versionsProvider(ProjectVersionFilterModel(
        storageID: projects.first.storageID,
        showBetaVersions: showBetaVersions,
      ))).when(
        data: (versions) => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: versions.length,
          itemBuilder: (context, index) => AppVersionCard(
            version: versions[index],
            latest: index == 0,
          ),
        ),
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
