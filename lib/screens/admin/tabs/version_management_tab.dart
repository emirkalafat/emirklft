import 'package:blog_web_site/services/firestore/changelogs/changelogs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blog_web_site/services/firestore/versions/versions_controller.dart';
import 'package:blog_web_site/models/version.dart';
import 'package:blog_web_site/screens/projects/project_details_info_model.dart';
import 'package:blog_web_site/screens/admin/dialogs/version_form_dialog.dart';

// Provider moved from admin_page.dart
final selectedChangelogIdProvider = StateProvider<String?>((ref) => null);

class VersionManagementTab extends ConsumerStatefulWidget {
  const VersionManagementTab({super.key});

  @override
  ConsumerState<VersionManagementTab> createState() =>
      _VersionManagementTabState();
}

class _VersionManagementTabState extends ConsumerState<VersionManagementTab> {
  @override
  Widget build(BuildContext context) {
    final changelogs = ref.watch(changelogAllProvider);
    final isLoading = ref.watch(versionsControllerProvider);
    final selectedChangelogId = ref.watch(selectedChangelogIdProvider);

    return Stack(
      children: [
        Column(
          children: [
            // Changelog Selector
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: changelogs.when(
                data: (changelogList) => DropdownButtonFormField<String>(
                  value: selectedChangelogId,
                  decoration: const InputDecoration(
                    labelText: 'Select Project',
                    border: OutlineInputBorder(),
                  ),
                  items: changelogList.map((changelog) {
                    return DropdownMenuItem(
                      value: changelog.storageID,
                      child: Text(changelog.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    ref.read(selectedChangelogIdProvider.notifier).state =
                        value;
                  },
                ),
                loading: () => const CircularProgressIndicator(),
                error: (error, _) => Text('Error: $error'),
              ),
            ),
            // Versions List
            Expanded(
              child: selectedChangelogId == null
                  ? const Center(child: Text('Please select a project'))
                  : _buildVersionsList(selectedChangelogId),
            ),
          ],
        ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  Widget _buildVersionsList(String storageId) {
    final versions = ref.watch(versionsProvider(
      ProjectDetailsInfoModel(storageID: storageId, showBetaVersions: true),
    ));

    return versions.when(
      data: (versionList) => ListView.builder(
        itemCount: versionList.length,
        itemBuilder: (context, index) {
          final version = versionList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              title: Row(
                children: [
                  Text('v${version.version}'),
                  if (version.isBeta)
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'BETA',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                ],
              ),
              subtitle: Text(version.date),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showVersionDialog(
                      context,
                      storageId,
                      version,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteVersion(
                      context,
                      storageId,
                      version.version,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }

  void _showVersionDialog(BuildContext context, String storageId,
      [Version? version]) {
    showDialog(
      context: context,
      builder: (context) => VersionFormDialog(
        storageID: storageId,
        version: version,
        versionId: version?.version,
      ),
    );
  }

  void _deleteVersion(
      BuildContext context, String storageId, String versionId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Version'),
        content: const Text('Are you sure you want to delete this version?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(versionsControllerProvider.notifier)
                  .deleteVersion(storageId, versionId);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
