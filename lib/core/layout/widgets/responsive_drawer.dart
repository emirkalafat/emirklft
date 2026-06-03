import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/navigation_service.dart';
import 'drawer_navigation_tile.dart';
import 'theme_switcher.dart';
import 'color_seed_selector.dart';

class ResponsiveDrawer extends ConsumerWidget {
  final int currentIndex;

  const ResponsiveDrawer({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      child: ListView(
        children: [
          const SizedBox(height: 48),
          ...NavigationService.menuItems.map((item) => DrawerNavigationTile(
                item: item,
                isSelected:
                    NavigationService.menuItems.indexOf(item) == currentIndex,
              )),
          const ThemeSwitcher(),
          const ColorSeedSelector(),
          const Divider(),
          ListTile(
            leading: Icon(Icons.info, color: colorScheme.onSurface),
            title: const Text("Lisanslar"),
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(context: context);
            },
          ),
          ListTile(
            enabled: false,
            leading: Icon(
              Icons.bolt,
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            title: const Text('App Version'),
          ),
        ],
      ),
    );
  }
}
