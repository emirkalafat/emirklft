

import 'package:blog_web_site/screens/recap/activity.dart';
import 'package:blog_web_site/screens/recap/recap.dart';
import 'package:flutter/material.dart';

class ActivityContent extends StatelessWidget {
  final Activity activity;
  final Function(Activity)? onTap;

  const ActivityContent({
    super.key,
    required this.activity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap != null ? () => onTap!(activity) : null,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  ActivityUIHelper.getTypeIcon(activity.type),
                  color: ActivityUIHelper.getTypeColor(activity.type),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    activity.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                if (activity.status == ActivityStatus.ongoing)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Devam ediyor',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(activity.description),
            const SizedBox(height: 4),
            Text(
              '${DateFormatter.formatDate(activity.startedDate)} - ${activity.status == ActivityStatus.finished ? DateFormatter.formatDate(activity.finishedDate) : 'Devam ediyor'}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}