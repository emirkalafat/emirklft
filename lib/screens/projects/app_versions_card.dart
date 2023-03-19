import 'package:flutter/material.dart';

import 'package:blog_web_site/models/version.dart';

class AppVersionCard extends StatelessWidget {
  const AppVersionCard({
    super.key,
    required this.version,
    this.latest = false,
  });

  final Version version;
  final bool latest;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final List changes = version.changes;
    final List fixes = version.fixes;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  version.version,
                  style: textTheme.headlineLarge,
                ),
                if (latest) ...[
                  const Spacer(),
                  Card(
                    color: colorScheme.primaryContainer,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('En Yeni Sürüm'),
                    ),
                  ),
                ],
                Text(version.date),
              ],
            ),
            const Divider(),
            if (changes.isNotEmpty) ...[
              Text(
                'Yeni Özellikler:',
                style: textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: version.changes.map((str) => Text(str)).toList(),
              ),
            ],
            if (fixes.isNotEmpty) ...[
              Text(
                'Düzeltmeler:',
                style: textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: version.fixes.map((str) => Text(str)).toList(),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
