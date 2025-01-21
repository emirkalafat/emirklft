import 'package:blog_web_site/core/constants.dart';
import 'package:blog_web_site/core/theme.dart';
import 'package:blog_web_site/services/firebase_storage/storage_controller.dart';
import 'package:blog_web_site/widgets/animated_opacity_when_hovered.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NavigationItem {
  final String label;
  final IconData icon;
  final String route;

  const NavigationItem({
    required this.label,
    required this.icon,
    required this.route,
  });
}

class NavigationService {
  static final List<NavigationItem> menuItems = [
    NavigationItem(label: 'Ana Sayfa', icon: Icons.home, route: '/'),
    NavigationItem(label: 'Blog', icon: Icons.article, route: '/blog'),
    NavigationItem(label: 'Projelerim', icon: Icons.work, route: '/projects'),
    NavigationItem(
        label: 'Ne Yaptım Ben?!', icon: Icons.history, route: '/recap'),
    NavigationItem(label: 'İletişim', icon: Icons.mail, route: '/contact'),
  ];

  static int calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    return menuItems.indexWhere((item) => location.startsWith(item.route));
  }

  static void navigateTo(BuildContext context, int index) {
    if (index < 0 || index >= menuItems.length) return;
    GoRouter.of(context).go(menuItems[index].route);
  }
}

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider.notifier);
    final isDark = themeNotifier.theme == ThemeMode.dark;

    return ListTile(
      leading: Icon(
        isDark ? Icons.dark_mode : Icons.light_mode,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      trailing: Switch.adaptive(
        value: isDark,
        onChanged: (_) => themeNotifier.toggleTheme(),
      ),
      title: const Text('Karanlık Tema'),
    );
  }
}

class MainPageScaffold extends ConsumerStatefulWidget {
  const MainPageScaffold({
    super.key,
    required this.child,
    required this.initialIndex,
  });

  final int initialIndex;
  final Widget child;

  @override
  ConsumerState<MainPageScaffold> createState() => _MainPageScaffoldState();
}

class _MainPageScaffoldState extends ConsumerState<MainPageScaffold> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;
    final colorScheme = Theme.of(context).colorScheme;

    currentIndex = NavigationService.calculateSelectedIndex(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      endDrawer: isSmall ? ResponsiveDrawer(currentIndex: currentIndex) : null,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: isSmall,
        title:
            AppBarTitle(onTap: () => NavigationService.navigateTo(context, 0)),
        actions: isSmall ? null : [AppBarActions(currentIndex: currentIndex)],
      ),
      body: widget.child,
      floatingActionButton: _buildFAB(),
    );
  }

  Widget? _buildFAB() {
    if (currentIndex != 1) return null;

    return FloatingActionButton(
      onPressed: () => ref.invalidate(blogPostsFuture),
      child: const Icon(Icons.refresh),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  final VoidCallback onTap;

  const AppBarTitle({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacityWhenHovered(
      child: GestureDetector(
        onTap: onTap,
        child: const Text(
          "Ahmet Emir Kalafat",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

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
        SettingsButton(),
      ],
    );
  }
}

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
          ColorSeedSelector(),
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
              color: colorScheme.onSurface.withOpacity(0.5),
            ),
            title: Text(AppConstants.appVersion),
          ),
        ],
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final bool isSelected;
  final NavigationItem item;
  final VoidCallback onPressed;

  const NavigationButton({
    super.key,
    required this.isSelected,
    required this.item,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor:
            isSelected ? colorScheme.primary : colorScheme.onSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(item.label),
          if (isSelected)
            Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(3),
                ),
                width: 20,
                height: 3,
              ),
            )
        ],
      ),
    );
  }
}

class DrawerNavigationTile extends StatelessWidget {
  final NavigationItem item;
  final bool isSelected;

  const DrawerNavigationTile({
    super.key,
    required this.item,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(
        item.icon,
        color: isSelected ? colorScheme.primary : colorScheme.onSurface,
      ),
      title: Text(
        item.label,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: isSelected ? colorScheme.primary : colorScheme.onSurface,
            ),
      ),
      onTap: () => NavigationService.navigateTo(
        context,
        NavigationService.menuItems.indexOf(item),
      ),
    );
  }
}

class ColorSeedSelector extends ConsumerWidget {
  const ColorSeedSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider.notifier);

    return ListTile(
      leading: const Icon(Icons.color_lens),
      title: const Text('Tema Rengi'),
      trailing: DropdownButton<ColorSeed>(
        value: themeNotifier.colorSeed,
        items: ColorSeed.values
            .map((color) => DropdownMenuItem(
                  value: color,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: color.color,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(color.label)
                    ],
                  ),
                ))
            .toList(),
        onChanged: (color) {
          if (color != null) themeNotifier.setColorSeed(color);
        },
      ),
    );
  }
}

class SettingsButton extends ConsumerWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () => _showSettingsModal(context),
    );
  }

  void _showSettingsModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const SettingsModal(),
    );
  }
}

class SettingsModal extends StatelessWidget {
  const SettingsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.settings),
          const SizedBox(width: 8),
          const Text('Ayarlar'),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ThemeSwitcher(),
            const ColorSeedSelector(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Lisanslar'),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationVersion: AppConstants.appVersion,
                );
              },
            ),
            ListTile(
              enabled: false,
              leading: const Icon(Icons.bolt),
              title: Text(AppConstants.appVersion),
            ),
          ],
        ),
      ),
    );
  }
}
