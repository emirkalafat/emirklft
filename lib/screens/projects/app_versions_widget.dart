import 'package:blog_web_site/services/firestore/changelogs/changelogs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppVersions extends ConsumerWidget {
  final String appID;
  const AppVersions({
    Key? key,
    required this.appID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    return const Center(child: Text('Versiyonlar'));
  }
}
