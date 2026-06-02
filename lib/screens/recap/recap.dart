import 'package:blog_web_site/core/utils/center_error.dart';
import 'package:blog_web_site/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:blog_web_site/services/firestore/activities/activities_controller.dart';
import 'widgets/year_month_timeline_new.dart';
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

class RecapScreen extends ConsumerWidget {
  final String? selectedActivityId;

  const RecapScreen({
    super.key,
    this.selectedActivityId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(activitiesProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: activitiesAsync.when(
        data: (activities) {
          if (activities.isEmpty) {
            return const Center(child: Text('Henüz bir inceleme bulunmuyor.'));
          }

          final groupedActivities = ActivityGrouper.groupByYearAndMonth(activities);

          return SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                padding: EdgeInsets.symmetric(
                  horizontal: isSmall ? 24.0 : 80.0,
                  vertical: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PageHeader(
                      bigTitle: 'REVIEWS',
                      subtitle: 'Curated Media',
                      title: 'İncelemeler',
                      description:
                          'Perspektifimi şekillendiren hikayelerin deneysel bir kataloğu. Kitaplar, filmler ve daha fazlası.',
                    ),
                    const SizedBox(height: 40),

                    // NEW TIMELINE VIEW
                    YearMonthTimelineNew(
                      groupedActivities: groupedActivities,
                      onActivityTap: (activity) {
                        context.go('/recap/activity/${activity.id}');
                      },
                    ),
                    
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          );
        },
        loading: () => CenterLoading(withText: true),
        error: (error, stack) => Center(
          child: Text('Hata: $error'),
        ),
      ),
    );
  }
}
