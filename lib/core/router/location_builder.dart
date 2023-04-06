import 'package:beamer/beamer.dart';
import 'package:blog_web_site/screens/misc/gizlilik_sozlesmesi.dart';
import 'package:blog_web_site/screens/misc/main_scaffold.dart';
import 'package:blog_web_site/screens/projects/projects_details.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          initialIndex: initialIndex,
        ),
      );
    },
    '/yemekdeposu': (context, state, data) => const BeamPage(
          key: ValueKey('yemekdeposu'),
          title: 'Yemek Deposu Gizlilik Sözleşmesi',
          child: YemekDeposuGizlilikSozlesmesi(),
        ),
    '/projects/:pid': (context, state, data) {
      final pid = state.pathParameters['pid'] as String;

      return BeamPage(
        key: ValueKey('pid-$pid'),
        child: ProjectDetails(projectID: pid),
        title: 'Proje - $pid',
      );
    }
  },
);
