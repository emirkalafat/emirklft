import 'package:beamer/beamer.dart';
import 'package:blog_web_site/screens/admin/auth_page.dart';
import 'package:blog_web_site/screens/link_tree/link_tree.dart';
import 'package:blog_web_site/screens/misc/gizlilik_sozlesmesi.dart';
import 'package:blog_web_site/screens/misc/main_scaffold.dart';
import 'package:blog_web_site/screens/misc/yemek_tarifi_user_deletion.dart';
import 'package:blog_web_site/screens/projects/projects_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blog_web_site/services/auth/auth_guard.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../screens/admin/admin_page.dart';

final locationBuilder = RoutesLocationBuilder(
  routes: {
    '/': (context, state, data) {
      final tab = state.queryParameters['tab'];
      final initialIndex = tab == 'contact'
          ? 3
          : tab == 'projects'
              ? 2
              : tab == 'blog'
                  ? 1
                  : 0;

      return BeamPage(
        key: ValueKey('home-$tab'),
        title: initialIndex == 0
            ? 'Ahmet Emir Kalafat'
            : initialIndex == 1
                ? 'AEK - Blog'
                : initialIndex == 2
                    ? 'AEK - Projelerim'
                    : 'AEK - İletişim',
        child: HomePage(
          key: ValueKey('home-$tab'),
          initialIndex: initialIndex,
        ),
      );
    },
    '/linktree': (context, state, data) {
      return const BeamPage(
        child: LinkTreeScreen(),
        title: 'LinkTree',
      );
    },
    '/yemekdeposu': (context, state, data) => const BeamPage(
          key: ValueKey('yemekdeposu'),
          title: 'Yemek Deposu Gizlilik Sözleşmesi',
          child: YemekDeposuGizlilikSozlesmesi(
            key: ValueKey('yemekdeposu'),
          ),
        ),
    '/yemekdeposu/user-deletion': (context, state, data) => const BeamPage(
        key: ValueKey('yemekdeposu-user-deletion'),
        title: 'Yemek Deposu Kullanıcı Silme',
        child: YemekTarifiUserDeletion(
          key: ValueKey('yemekdeposu-user-deletion'),
        )),
    '/projects/:pid': (context, state, data) {
      final pid = state.pathParameters['pid'] as String;

      return BeamPage(
        key: ValueKey('pid-$pid'),
        child: ProjectDetails(projectID: pid, key: ValueKey('pid-$pid')),
        title: 'Proje - $pid',
      );
    },
    '/auth': (context, state, data) {
      return const BeamPage(
        child: AuthScreen(),
        key: ValueKey('auth'),
        title: 'Admin Giriş',
      );
    },
    '/admin': (context, state, data) {
      return const BeamPage(
        child: AdminPage(),
        key: ValueKey('admin'),
        title: 'Admin',
      );
    }
  },
);
