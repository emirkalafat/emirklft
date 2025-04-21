import 'package:flutter/material.dart';
import '../../models/version_model.dart';

class AppVersionCard extends StatelessWidget {
  final VersionModel version;
  final bool latest;

  const AppVersionCard({
    super.key,
    required this.version,
    this.latest = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(version.version, style: textTheme.headlineLarge),
                const Spacer(),
                if (latest)
                  Card(
                    color: colorScheme.primaryContainer,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('En Yeni Sürüm'),
                    ),
                  ),
                if (version.isBeta)
                  Card(
                    color: colorScheme.primaryContainer,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Beta'),
                    ),
                  ),
                Text(version.date),
              ],
            ),
            const Divider(),
            _buildChangeList('Yeni Özellikler:', version.changes, textTheme),
            _buildChangeList('Düzeltmeler:', version.fixes, textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildChangeList(String title, List<dynamic> items, TextTheme textTheme) {
    if (items.isEmpty) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        ...items.map((item) => Text(item)),
        const SizedBox(height: 8),
      ],
    );
  }
}
