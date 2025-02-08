import 'package:blog_web_site/core/utils/center_error.dart';
import 'package:blog_web_site/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blog_web_site/services/firestore/activities/activities_controller.dart';

import 'package:blog_web_site/screens/recap/recap.dart';

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

    return activityAsync.when(
      data: (activity) {
        if (activity == null) {
          return const Center(child: Text('Activity not found'));
        }

        final content = Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    ActivityUIHelper.getTypeIcon(activity.type),
                    color: ActivityUIHelper.getTypeColor(activity.type),
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      activity.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (activity.imageUrl != null)
                Center(
                  child: Image.network(
                    activity.imageUrl!,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                activity.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 12),
              Text(
                '${DateFormatter.formatDate(activity.startedDate)} - ${activity.status == ActivityStatus.finished ? DateFormatter.formatDate(activity.finishedDate) : 'Devam ediyor'}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              if (activity.url != null) ...[
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Utils.startUrl(activity.url!);
                  },
                  icon: const Icon(Icons.link),
                  label: const Text('Bağlantıya Git'),
                ),
              ],
            ],
          ),
        );

        if (isDialog) {
          return content;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(activity.title),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
          ),
          body: content,
        );
      },
      loading: () => CenterLoading(withText: true),
      error: (error, stack) => Center(
        child: Text('Error loading activity: $error'),
      ),
    );
  }
}
