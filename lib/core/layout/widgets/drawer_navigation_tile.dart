import 'package:flutter/material.dart';
import '../models/navigation_item.dart';
import '../services/navigation_service.dart';

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
