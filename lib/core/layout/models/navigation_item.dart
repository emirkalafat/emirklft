import 'package:flutter/material.dart';

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
