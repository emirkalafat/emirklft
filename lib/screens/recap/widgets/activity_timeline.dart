
import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

import 'package:blog_web_site/screens/recap/activity.dart';
import 'package:blog_web_site/screens/recap/widgets/activity_content.dart';

class ActivityTimeline extends StatelessWidget {
  final List<Activity> activities;
  final Function(Activity)? onActivityTap;

  const ActivityTimeline({
    super.key,
    required this.activities,
    this.onActivityTap,
  });

  @override
  Widget build(BuildContext context) {
    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        color: Colors.grey.shade400,
        indicatorTheme: const IndicatorThemeData(
          position: 0,
          size: 15.0,
        ),
        connectorTheme: const ConnectorThemeData(
          thickness: 1.5,
        ),
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: activities.length,
        contentsBuilder: (context, activityIndex) {
          final activity = activities[activityIndex];
          return ActivityContent(
            activity: activity,
            onTap: onActivityTap,
          );
        },
        indicatorBuilder: (_, __) => const OutlinedDotIndicator(),
        connectorBuilder: (_, __, ___) => const SolidLineConnector(),
      ),
    );
  }
}