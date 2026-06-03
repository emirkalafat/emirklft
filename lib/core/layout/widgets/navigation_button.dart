import 'package:flutter/material.dart';
import '../models/navigation_item.dart';

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
