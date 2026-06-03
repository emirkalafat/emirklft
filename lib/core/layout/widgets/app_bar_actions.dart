import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants.dart';
import '../../../core/theme.dart';
import '../services/navigation_service.dart';
import 'navigation_button.dart';
import 'settings_button.dart';

class AppBarActions extends ConsumerWidget {
  final int currentIndex;

  const AppBarActions({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuItems = NavigationService.menuItems;

    final colorScheme = Theme.of(context).colorScheme;
    final themeNotifier = ref.watch(themeNotifierProvider.notifier);
    final isDark = themeNotifier.theme == ThemeMode.dark;

    return Row(
      children: [
        ...List.generate(
          menuItems.length,
          (i) => NavigationButton(
            isSelected: currentIndex == i,
            item: menuItems[i],
            onPressed: () => NavigationService.navigateTo(context, i),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.onSurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () => showAboutDialog(
            context: context,
            applicationVersion: AppConstants.appVersion,
          ),
          child: const Text("Lisanslar"),
        ),
        IconButton(
          onPressed: themeNotifier.toggleTheme,
          icon: Icon(
            isDark ? Icons.dark_mode : Icons.light_mode,
            color: colorScheme.onSurface,
          ),
        ),
        const SettingsButton(),
      ],
    );
  }
}
