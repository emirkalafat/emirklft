import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme.dart';

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider.notifier);
    final isDark = themeNotifier.theme == ThemeMode.dark;

    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(
        isDark ? Icons.dark_mode : Icons.light_mode,
        color: colorScheme.onSurface,
      ),
      trailing: Switch.adaptive(
        value: isDark,
        onChanged: (_) => themeNotifier.toggleTheme(),
      ),
      title: const Text('Karanlık Tema'),
    );
  }
}
