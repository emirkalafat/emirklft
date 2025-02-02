import 'package:flutter/material.dart';
import 'package:blog_web_site/screens/recap/activity.dart';
import 'package:blog_web_site/screens/recap/widgets/activity_content.dart';

class ActivityList extends StatelessWidget {
  final List<Activity> activities;
  final Function(Activity)? onActivityTap;

  const ActivityList({
    super.key,
    required this.activities,
    this.onActivityTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: activities.map((activity) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ActivityContent(
            activity: activity,
            onTap: onActivityTap,
          ),
        );
      }).toList(),
    );
  }
}
