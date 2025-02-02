import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

import 'package:blog_web_site/screens/recap/activity.dart';
import 'package:blog_web_site/screens/recap/recap.dart';
import 'package:blog_web_site/screens/recap/widgets/activity_list.dart';

class MonthTimeline extends StatelessWidget {
  final Map<int, List<Activity>> monthActivities;
  final Function(Activity)? onActivityTap;

  const MonthTimeline({
    super.key,
    required this.monthActivities,
    this.onActivityTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FixedTimeline.tileBuilder(
      theme: _getTimelineTheme(colorScheme),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: monthActivities.length,
        contentsBuilder: _buildMonthContent,
        indicatorBuilder: (_, __) =>
            const OutlinedDotIndicator(borderWidth: 2.0),
        connectorBuilder: (_, __, ___) => const SolidLineConnector(),
      ),
    );
  }

  Widget _buildMonthContent(BuildContext context, int monthIndex) {
    final month = monthActivities.keys.toList()[monthIndex];
    final activities = monthActivities[month]!;

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormatter.getMonthName(month),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          const SizedBox(height: 8.0),
          ActivityList(
            activities: activities,
            onActivityTap: onActivityTap,
          ),
        ],
      ),
    );
  }

  TimelineThemeData _getTimelineTheme(ColorScheme colorScheme) {
    return TimelineThemeData(
      nodePosition: 0,
      color: colorScheme.secondary,
      indicatorTheme: const IndicatorThemeData(
        position: 0,
        size: 20.0,
      ),
      connectorTheme: const ConnectorThemeData(
        thickness: 2.0,
      ),
    );
  }
}
