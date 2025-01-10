import 'package:blog_web_site/screens/link_tree/link_tree.dart';
import 'package:blog_web_site/screens/misc/gizlilik_sozlesmesi.dart';
import 'package:blog_web_site/screens/misc/main_scaffold.dart';
import 'package:blog_web_site/screens/misc/yemek_tarifi_user_deletion.dart';
import 'package:blog_web_site/screens/projects/projects_details.dart';
import 'package:blog_web_site/screens/recap/activity_detail.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/linktree',
  redirect: (context, state) {
    return state.uri.path == 'projects' ? '/?tab=projects' : null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        final tab = state.uri.queryParameters['tab'];
        final initialIndex = tab == 'contact'
            ? 4
            : tab == 'recap'
                ? 3
                : tab == 'projects'
                    ? 2
                    : tab == 'blog'
                        ? 1
                        : 0;

        final pageName = initialIndex == 0
            ? 'Ahmet Emir Kalafat'
            : initialIndex == 1
                ? 'AEK - Blog'
                : initialIndex == 2
                    ? 'AEK - Projelerim'
                    : 'AEK - İletişim';
        return HomePage(
          key: ValueKey('home-$tab'),
          initialIndex: initialIndex,
        );
      },
    ),
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
        path: '/projects/:pid',
        builder: (context, state) {
          final pid = state.pathParameters['pid'] ?? '0';
          return ProjectDetails(projectID: pid, key: ValueKey('pid-$pid'));
        }),
    GoRoute(
      path: '/recap/activity/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final isDialog = state.uri.queryParameters['dialog'] == 'true';
        return ActivityDetailScreen(
          activityId: id,
          key: ValueKey('activity-$id'),
          isDialog: isDialog,
        );
      },
    ),
  ],
);