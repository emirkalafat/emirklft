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
            ? 'Ana Sayfa'
            : initialIndex == 1
                ? 'Blog'
                : initialIndex == 2
                    ? 'Projelerim'
                    : 'İletişim',
        child: HomePage(
          initialIndex: initialIndex,
        ),
      );
    },
    //'/projects': (context, state, data) =>
    //    Beamer.of(context).beamToNamed('/?tab=projects'),
    '/yemekdeposu': (context, state, data) => const BeamPage(
          key: ValueKey('yemekdeposu'),
          title: 'Yemek Deposu Gizlilik Sözleşmesi',
          child: EnfesTariflerGizlilikSozlesmesi(),
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
