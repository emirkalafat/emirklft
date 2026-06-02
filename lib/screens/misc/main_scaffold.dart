import 'package:blog_web_site/core/constants.dart';
import 'package:blog_web_site/core/theme.dart';
import 'package:blog_web_site/services/firebase_storage/storage_controller.dart';
import 'package:blog_web_site/widgets/animated_opacity_when_hovered.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NavigationItem {
  final String label;
  final String number;
  final IconData icon;
  final String route;
  final String description;

  const NavigationItem({
    required this.label,
    required this.number,
    required this.icon,
    required this.route,
    required this.description,
  });
}

class NavigationService {
  static const List<NavigationItem> menuItems = [
    NavigationItem(
      label: 'Ana Sayfa',
      number: '01',
      icon: Icons.home_outlined,
      route: '/',
      description: 'Sistemler ve Genel Bakış',
    ),
    NavigationItem(
      label: 'Projelerim',
      number: '02',
      icon: Icons.work_outline,
      route: '/projects',
      description: 'Seçilmiş Çalışmalar',
    ),
    NavigationItem(
      label: 'Blog',
      number: '03',
      icon: Icons.article_outlined,
      route: '/blog',
      description: 'Düşünceler ve Mühendislik',
    ),
    NavigationItem(
      label: 'İncelemeler',
      number: '04',
      icon: Icons.rate_review_outlined,
      route: '/recap',
      description: 'Seçilmiş Medya ve Geçmiş',
    ),
    NavigationItem(
      label: 'Hakkımda',
      number: '05',
      icon: Icons.person_outline,
      route: '/about',
      description: 'Geçmiş ve İletişim',
    ),
    NavigationItem(
      label: 'Ekipman',
      number: '06',
      icon: Icons.terminal_outlined,
      route: '/equipment', // We might need to add /equipment route
      description: 'Teknoloji ve Donanım',
    ),
  ];

  static int calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location == '/') return 0;
    return menuItems.indexWhere(
        (item) => item.route != '/' && location.startsWith(item.route));
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
  bool isMenuOpen = false;

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;
    final colorScheme = Theme.of(context).colorScheme;
    final currentIndex = NavigationService.calculateSelectedIndex(context);
    final activeItem =
        currentIndex != -1 ? NavigationService.menuItems[currentIndex] : null;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          // Main Content
          Row(
            children: [
              if (!isSmall)
                NavigationSidebar(
                  isMenuOpen: isMenuOpen,
                  onMenuToggle: toggleMenu,
                  activeLabel: activeItem?.label.toUpperCase() ?? 'MENU',
                ),
              Expanded(
                child: widget.child,
              ),
            ],
          ),

          // Column Navigation Overlay
          if (isMenuOpen)
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isMenuOpen ? 1.0 : 0.0,
              child: ColumnNavOverlay(
                isOpen: isMenuOpen,
                onClose: () => setState(() => isMenuOpen = false),
                currentIndex: currentIndex,
              ),
            ),

          // Mobile Menu Toggle
          if (isSmall)
            Positioned(
              top: 20,
              left: 20,
              child: IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: colorScheme.primary.withOpacity(0.8),
                ),
                onPressed: toggleMenu,
                icon: Icon(isMenuOpen ? Icons.close : Icons.grid_view),
              ),
            ),
        ],
      ),
    );
  }
}

class NavigationSidebar extends StatelessWidget {
  final bool isMenuOpen;
  final VoidCallback onMenuToggle;
  final String activeLabel;

  const NavigationSidebar({
    super.key,
    required this.isMenuOpen,
    required this.onMenuToggle,
    required this.activeLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        border: Border(
          right: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          IconButton(
            onPressed: onMenuToggle,
            icon: Icon(
              isMenuOpen ? Icons.close : Icons.grid_view,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          const Spacer(),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              activeLabel,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white.withOpacity(0.6),
                    letterSpacing: 4,
                  ),
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: LanguageSwitcherStub(),
          ),
        ],
      ),
    );
  }
}

class LanguageSwitcherStub extends StatelessWidget {
  const LanguageSwitcherStub({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'TR',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
        Container(
          height: 1,
          width: 16,
          color: Colors.white.withOpacity(0.1),
          margin: const EdgeInsets.symmetric(vertical: 4),
        ),
        Text(
          'EN',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white.withOpacity(0.4),
              ),
        ),
      ],
    );
  }
}

class ColumnNavOverlay extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onClose;
  final int currentIndex;

  const ColumnNavOverlay({
    super.key,
    required this.isOpen,
    required this.onClose,
    required this.currentIndex,
  });

  @override
  State<ColumnNavOverlay> createState() => _ColumnNavOverlayState();
}

class _ColumnNavOverlayState extends State<ColumnNavOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    if (widget.isOpen) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(ColumnNavOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen && !oldWidget.isOpen) {
      _controller.forward();
    } else if (!widget.isOpen && oldWidget.isOpen) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Semi-transparent background fade
          GestureDetector(
            onTap: widget.onClose,
            child: Container(
              color: Colors.black.withOpacity(0.95),
              width: size.width,
              height: size.height,
            ),
          ),

          // Sliding Columns
          Row(
            children: [
              if (!isSmall) const SizedBox(width: 80),
              ...NavigationService.menuItems.map((item) {
                final index = NavigationService.menuItems.indexOf(item);
                final isSelected = index == widget.currentIndex;

                return Expanded(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      // Staggered slide effect
                      final slideProgress = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          index * 0.1,
                          0.5 + (index * 0.1),
                          curve: Curves.easeOutQuart,
                        ),
                      ).value;

                      return Transform.translate(
                        offset: Offset(0, size.height * (1 - slideProgress)),
                        child: Opacity(
                          opacity: slideProgress.clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.05),
                              border: Border(
                                right: BorderSide(
                                    color: Colors.white.withOpacity(0.05)),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                NavigationService.navigateTo(context, index);
                                widget.onClose();
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${item.number} — ${item.label.toUpperCase()}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: isSelected
                                              ? colorScheme.primary
                                              : Colors.white.withOpacity(0.4),
                                          letterSpacing: 2,
                                        ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    item.label,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      item.description,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color:
                                                Colors.white.withOpacity(0.4),
                                          ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Container(
                                        width: 40,
                                        height: 2,
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ],
          ),

          // Close button at top right
          Positioned(
            top: 20,
            right: 20,
            child: FadeTransition(
              opacity: _controller,
              child: IconButton(
                onPressed: widget.onClose,
                icon: const Icon(Icons.close, color: Colors.white, size: 32),
              ),
            ),
          ),
        ],
      ),
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
          ThemeSwitcher(),
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
              color: colorScheme.onSurface.withValues(alpha: 0.5),
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
            ThemeSwitcher(),
            ColorSeedSelector(),
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
