import 'package:blog_web_site/screens/admin/dialogs/activity_form_dialog.dart';
import 'package:blog_web_site/screens/recap/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blog_web_site/services/firestore/activities/activities_controller.dart';

// Arama ve filtreleme için provider'lar
final activitySearchQueryProvider = StateProvider<String>((ref) => '');
final activityTypeFilterProvider = StateProvider<ActivityType?>((ref) => null);

// Filtrelenmiş aktiviteler için provider
final filteredActivitiesProvider = Provider<AsyncValue<List<Activity>>>((ref) {
  final activitiesAsync = ref.watch(activitiesProvider);
  final searchQuery = ref.watch(activitySearchQueryProvider).toLowerCase();
  final typeFilter = ref.watch(activityTypeFilterProvider);

  return activitiesAsync.when(
    data: (activities) {
      return AsyncValue.data(activities.where((activity) {
        // Tip filtresini kontrol et
        if (typeFilter != null && activity.type != typeFilter) {
          return false;
        }
        // Arama sorgusunu kontrol et
        if (searchQuery.isNotEmpty) {
          return activity.title.toLowerCase().contains(searchQuery) ||
              activity.description.toLowerCase().contains(searchQuery);
        }
        return true;
      }).toList());
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

class ActivityManagementTab extends ConsumerWidget {
  const ActivityManagementTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredActivities = ref.watch(filteredActivitiesProvider);
    final isLoading = ref.watch(activitiesControllerProvider);
    final selectedType = ref.watch(activityTypeFilterProvider);

    return Stack(
      children: [
        Column(
          children: [
            // Filter Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Arama çubuğu
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search activities...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        ref.read(activitySearchQueryProvider.notifier).state = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Tip filtresi
                  DropdownButton<ActivityType?>(
                    value: selectedType,
                    hint: const Text('Filter by type'),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('All Types'),
                      ),
                      ...ActivityType.values
                          .where((type) => type != ActivityType.unknown)
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type.name),
                              ))
                    ],
                    onChanged: (value) {
                      ref.read(activityTypeFilterProvider.notifier).state = value;
                    },
                  ),
                ],
              ),
            ),
            // Activities List
            Expanded(
              child: filteredActivities.when(
                data: (activityList) => activityList.isEmpty
                    ? const Center(
                        child: Text('No activities found'),
                      )
                    : ListView.builder(
                        itemCount: activityList.length,
                        itemBuilder: (context, index) {
                          final activity = activityList[index];
                          return ActivityListItem(
                            activity: activity,
                            onEdit: () =>
                                _showActivityDialog(context, ref, activity),
                            onDelete: () =>
                                _deleteActivity(context, ref, activity.id),
                          );
                        },
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Error: $error')),
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

  void _showActivityDialog(BuildContext context, WidgetRef ref,
      [Activity? activity]) {
    showDialog(
      context: context,
      builder: (context) => ActivityFormDialog(activity: activity),
    );
  }

  void _deleteActivity(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Activity'),
        content: const Text('Are you sure you want to delete this activity?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(activitiesControllerProvider.notifier)
                  .deleteActivity(id);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class ActivityListItem extends StatelessWidget {
  final Activity activity;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ActivityListItem({
    super.key,
    required this.activity,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading:
            activity.imageUrl != null
            ?
            Image.network(
          activity.imageUrl!,
          width: 40,
          height: 40,
          errorBuilder: (context, error, stackTrace) =>
              Text('error loading image'),
        )
        : null,
        title: Text(activity.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activity.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Status: ${activity.status.name} | Type: ${activity.type.name}',
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
