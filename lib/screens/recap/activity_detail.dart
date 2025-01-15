import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:blog_web_site/screens/recap/mock_activities.dart';
import 'package:blog_web_site/screens/recap/recap.dart';

import 'activity.dart';

class ActivityDetailScreen extends StatelessWidget {
  final String activityId;
  final bool isDialog;

  const ActivityDetailScreen({
    super.key,
    required this.activityId,
    this.isDialog = false,
  });

  @override
  Widget build(BuildContext context) {
    // Mock repository'den aktiviteyi al
    final activity = MockActivityRepository()
        .getActivities()
        .firstWhere((activity) => activity.id == activityId);

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
                // URL'yi aç
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
          onPressed: () => context.go('/'),
        ),
      ),
      body: content,
    );
  }
}
