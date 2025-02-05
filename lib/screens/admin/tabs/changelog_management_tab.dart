import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blog_web_site/services/firestore/changelogs/changelogs_controller.dart';
import 'package:blog_web_site/models/changelog_model.dart';
import 'package:blog_web_site/screens/admin/dialogs/changelog_form_dialog.dart';

final changelogSearchQueryProvider = StateProvider<String>((ref) => '');

final filteredChangelogsProvider = Provider<AsyncValue<List<Changelog>>>((ref) {
  final changelogsAsync = ref.watch(changelogAllProvider);
  final searchQuery = ref.watch(changelogSearchQueryProvider).toLowerCase();

  return changelogsAsync.when(
    data: (changelogs) {
      if (searchQuery.isEmpty) return AsyncValue.data(changelogs);

      return AsyncValue.data(changelogs.where((changelog) {
        return changelog.name.toLowerCase().contains(searchQuery) ||
            changelog.explanation.toLowerCase().contains(searchQuery) ||
            changelog.storageID.toLowerCase().contains(searchQuery);
      }).toList());
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

class ChangelogManagementTab extends ConsumerWidget {
  const ChangelogManagementTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredChangelogs = ref.watch(filteredChangelogsProvider);
    final isLoading = ref.watch(changelogsControllerProvider);

    return Stack(
      children: [
        Column(
          children: [
            // Search Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search projects...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  ref.read(changelogSearchQueryProvider.notifier).state = value;
                },
              ),
            ),
            // Changelogs List
            Expanded(
              child: filteredChangelogs.when(
                data: (data) => data.isEmpty
                    ? const Center(child: Text('No projects found'))
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final changelog = data[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            child: ListTile(
                              leading: changelog.image != null
                                  ? Image.network(
                                      changelog.image!,
                                      width: 40,
                                      height: 40,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error),
                                    )
                                  : const Icon(Icons.apps),
                              title: Text(changelog.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    changelog.explanation,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (changelog.googlePlayLink != null ||
                                      changelog.appStoreLink != null ||
                                      changelog.githubLink != null)
                                    Wrap(
                                      spacing: 8,
                                      children: [
                                        if (changelog.googlePlayLink != null)
                                          const Icon(Icons.android, size: 16),
                                        if (changelog.appStoreLink != null)
                                          const Icon(Icons.apple, size: 16),
                                        if (changelog.githubLink != null)
                                          const Icon(Icons.code, size: 16),
                                      ],
                                    ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => _showChangelogDialog(
                                        context, ref, changelog),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => _deleteChangelog(
                                        context, ref, changelog.id),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
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

  void _showChangelogDialog(BuildContext context, WidgetRef ref,
      [Changelog? changelog]) {
    showDialog(
      context: context,
      builder: (context) => ChangelogFormDialog(changelog: changelog),
    );
  }

  void _deleteChangelog(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Changelog'),
        content: const Text('Are you sure you want to delete this changelog?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(changelogsControllerProvider.notifier)
                  .deleteChangelog(id);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
