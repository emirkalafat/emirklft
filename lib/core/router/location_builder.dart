import 'package:blog_web_site/screens/admin/auth_page.dart';
import 'package:blog_web_site/screens/blog/blog.dart';
import 'package:blog_web_site/screens/contact_with_me/contact.dart';
import 'package:blog_web_site/screens/home/home_screen.dart';
import 'package:blog_web_site/screens/link_tree/link_tree.dart';
import 'package:blog_web_site/screens/misc/gizlilik_sozlesmesi.dart';
import 'package:blog_web_site/screens/misc/main_scaffold.dart';
import 'package:blog_web_site/screens/misc/yemek_tarifi_user_deletion.dart';
import 'package:blog_web_site/screens/projects/projects_details.dart';
import 'package:blog_web_site/screens/projects/projects_screen.dart';
import 'package:blog_web_site/screens/recap/activity_detail.dart';
import 'package:blog_web_site/screens/recap/recap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blog_web_site/screens/admin/admin_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  redirect: (context, state) {
    final auth = FirebaseAuth.instance;
    final isAuthPage = state.fullPath?.startsWith('/auth') ?? false;

    if (state.fullPath?.startsWith('/admin') ?? false) {
      if (auth.currentUser == null) {
        return '/auth';
      }
    }

    if (isAuthPage && auth.currentUser != null) {
      return '/';
    }

    return null;
  },
  routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainPageScaffold(
            key: ValueKey('main-scaffold'),
            initialIndex: 0,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const AnaSayfa(),
          ),
          GoRoute(
              path: '/contact', builder: (context, state) => ContactWithMe()),
          GoRoute(path: '/blog', builder: (context, state) => MyBlog()),
          GoRoute(
              path: '/projects',
              builder: (context, state) => MyProjectsPage(),
              routes: [
                GoRoute(
                    path: '/:pid',
                    builder: (context, state) {
                      final pid = state.pathParameters['pid'] ?? '0';
                      return ProjectDetails(
                          projectID: pid, key: ValueKey('pid-$pid'));
                    }),
              ]),
          GoRoute(
              path: '/recap',
              builder: (context, state) => RecapScreen(),
              routes: [
                GoRoute(
                  path: '/activity/:id',
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return ActivityDetailScreen(
                      activityId: id,
                    );
                  },
                ),
              ]),
        ]),
    GoRoute(
      path: '/linktree',
      builder: (context, state) => const LinkTreeScreen(),
      name: 'LinkTree',
    ),
    GoRoute(
        path: '/yemekdeposu',
        builder: (context, state) {
          return const YemekDeposuGizlilikSozlesmesi(
            key: ValueKey('yemekdeposu'),
          );
        },
        name: 'Yemek Deposu Gizlilik Sözleşmesi',
        routes: [
          GoRoute(
              path: '/user-deletion',
              builder: (context, state) {
                return const YemekTarifiUserDeletion(
                  key: ValueKey('yemekdeposu-user-deletion'),
                );
              },
              name: 'Yemek Deposu Kullanıcı Silme'),
        ]),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminPage(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) =>
          const AuthScreen(), // Add your auth screen widget
    ),
  ],
);
