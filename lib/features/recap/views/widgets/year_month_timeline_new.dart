import 'package:blog_web_site/features/recap/models/activity.dart';
import 'package:blog_web_site/features/recap/views/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YearMonthTimelineNew extends StatelessWidget {
  final Map<int, Map<int, List<Activity>>> groupedActivities;
  final Function(Activity)? onActivityTap;

  const YearMonthTimelineNew({
    super.key,
    required this.groupedActivities,
    this.onActivityTap,
  });

  @override
  Widget build(BuildContext context) {
    final years = groupedActivities.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: years.map((year) {
        final months = groupedActivities[year]!.keys.toList();
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // YEAR HEADER
            _buildYearHeader(context, year),
            const SizedBox(height: 40),
            
            // MONTHS IN THIS YEAR
            ...months.map((month) {
              final activities = groupedActivities[year]![month]!;
              return _buildMonthSection(context, month, activities);
            }),
            
            const SizedBox(height: 60),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildYearHeader(BuildContext context, int year) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Text(
          '$year',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -2,
              ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Container(
            height: 1,
            color: colorScheme.primary.withValues(alpha: 0.2),
          ),
        ),
      ],
    );
  }

  Widget _buildMonthSection(BuildContext context, int month, List<Activity> activities) {
    final monthName = _getMonthName(month).toUpperCase();
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month Label (Side)
          SizedBox(
            width: 80,
            child: Column(
              children: [
                const SizedBox(height: 10),
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    monthName,
                    style: GoogleFonts.spaceMono(
                      textStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.2),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 1,
                  height: 100,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ],
            ),
          ),
          
          // Activities List
          Expanded(
            child: Column(
              children: activities.map((activity) {
                return ReviewCard(
                  activity: activity,
                  onTap: () {
                    if (onActivityTap != null) {
                      onActivityTap!(activity);
                    }
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
    ];
    return months[month - 1];
  }
}
