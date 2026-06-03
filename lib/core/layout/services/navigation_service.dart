import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/navigation_item.dart';

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
      route: '/equipment',
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
