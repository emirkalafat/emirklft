import 'package:flutter/material.dart';
import 'language_switcher_stub.dart';

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
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        border: Border(
          right: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          IconButton(
            onPressed: onMenuToggle,
            icon: Icon(
              isMenuOpen ? Icons.close : Icons.grid_view,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
          const Spacer(),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              activeLabel,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.6),
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
