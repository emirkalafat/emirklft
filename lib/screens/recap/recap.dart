import 'package:blog_web_site/screens/recap/mock_activities.dart';
import 'package:blog_web_site/screens/recap/widgets/year_month_timeline.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:blog_web_site/screens/recap/activity_detail.dart';

import 'activity.dart';

// UI Helper classes
class ActivityUIHelper {
  static Color getTypeColor(ActivityType type) {
    switch (type) {
      case ActivityType.book:
        return Colors.blue;
      case ActivityType.movie:
        return Colors.red;
      case ActivityType.tvShow:
        return Colors.purple;
      case ActivityType.other:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  static IconData getTypeIcon(ActivityType type) {
    switch (type) {
      case ActivityType.book:
        return Icons.book;
      case ActivityType.movie:
        return Icons.movie;
      case ActivityType.tvShow:
        return Icons.tv;
      case ActivityType.other:
        return Icons.category;
      default:
        return Icons.category;
    }
  }
}

class DateFormatter {
  static final List<String> _monthNames = [
    'Ocak',
    'Şubat',
    'Mart',
    'Nisan',
    'Mayıs',
    'Haziran',
    'Temmuz',
    'Ağustos',
    'Eylül',
    'Ekim',
    'Kasım',
    'Aralık'
  ];

  static String formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day} ${getMonthName(date.month)} ${date.year}';
  }

  static String getMonthName(int month) => _monthNames[month - 1];
}

// Main Screen
class RecapScreen extends StatelessWidget {
  final ActivityRepository _repository;
  final String? selectedActivityId;

  RecapScreen({
    super.key,
    ActivityRepository? repository,
    this.selectedActivityId,
  }) : _repository = repository ?? MockActivityRepository();

  @override
  Widget build(BuildContext context) {
    final activities = _repository.getActivities();
    final groupedActivities = ActivityGrouper.groupByYearAndMonth(activities);
    final isWideScreen = MediaQuery.of(context).size.width > 1000;

    if (!isWideScreen) {
      return Scaffold(
        body: YearMonthTimeline(
          groupedActivities: groupedActivities,
          onActivityTap: (activity) {
            context.go('/recap/activity/${activity.id}');
          },
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: YearMonthTimeline(
              groupedActivities: groupedActivities,
              onActivityTap: (activity) {
                context.go('/?tab=recap&activity=${activity.id}');
              },
            ),
          ),
          if (selectedActivityId != null) ...[
            const VerticalDivider(width: 1),
            Expanded(
              flex: 3,
              child: ActivityDetailScreen(
                activityId: selectedActivityId!,
                isDialog: true,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
