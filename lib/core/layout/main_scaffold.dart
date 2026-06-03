import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/navigation_service.dart';
import 'widgets/navigation_sidebar.dart';
import 'widgets/column_nav_overlay.dart';

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
                  backgroundColor: colorScheme.primary.withValues(alpha: 0.8),
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
