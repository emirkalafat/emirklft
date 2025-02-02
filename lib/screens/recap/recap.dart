import 'package:blog_web_site/screens/recap/mock_activities.dart';
import 'package:blog_web_site/screens/recap/widgets/year_month_timeline.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:blog_web_site/services/firestore/activities/activities_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
class RecapScreen extends ConsumerWidget {
  final String? selectedActivityId;

  const RecapScreen({
    super.key,
    this.selectedActivityId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(activitiesProvider);

    return Scaffold(
      body: activitiesAsync.when(
        data: (activities) {
          final groupedActivities = ActivityGrouper.groupByYearAndMonth(activities);
          return YearMonthTimeline(
            groupedActivities: groupedActivities,
            onActivityTap: (activity) {
              context.go('/recap/activity/${activity.id}');
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading activities: $error'),
        ),
      ),
    );
  }
}
