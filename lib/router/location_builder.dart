import 'package:beamer/beamer.dart';
import 'package:blog_web_site/screens/gizlilik_sozlesmesi.dart';
import 'package:flutter/cupertino.dart';

import '../screens/main_scaffold.dart';
import '../screens/projects_details.dart';
import 'package:blog_web_site/data/projects.dart' as projects_data;

final locationBuilder = RoutesLocationBuilder(
  routes: {
    '/': (context, state, data) {
      final titleQuery = state.queryParameters['title'] ??
          (data is Map ? (data['title'] ?? '') : '');
      final genreQuery = state.queryParameters['genre'] ?? '';
      final pageTitle = titleQuery != ''
          ? "Books with name '$titleQuery'"
          : genreQuery != ''
              ? "Books with genre '$genreQuery'"
              : 'Bütün Projelerim';
      final projects = titleQuery != ''
          ? projects_data.projects.where((project) =>
              project['title'].toLowerCase().contains(titleQuery.toLowerCase()))
          : genreQuery != ''
              ? projects_data.projects
                  .where((project) => project['genres'].contains(genreQuery))
              : projects_data.projects;
      final tab = state.queryParameters['tab'];
      final initialIndex = tab == 'contact'
          ? 3
          : tab == 'projects'
              ? 2
              : tab == 'blog'
                  ? 1
                  : 0;
      return BeamPage(
        //key: ValueKey('home'),
        title: initialIndex == 0
            ? 'Ana Sayfa'
            : initialIndex == 1
                ? 'Blog'
                : initialIndex == 2
                    ? 'Projelerim'
                    : 'İletişim',
        child: HomePage(
          initialIndex: initialIndex,
          projects: projects.toList(),
        ),
      );
    },
    '/enfestarifler': (context, state, data) => const BeamPage(
          key: ValueKey('enfestarifler'),
          title: 'Enfes Tarifler Gizlilik Sözleşmesi',
          child: EnfesTariflerGizlilikSozlesmesi(),
        ),
    '/projects/:projectId': (context, state, data) {
      final projectId = state.pathParameters['projectId'];
      final project = projects_data.projects
          .firstWhere((project) => project['id'] == projectId);
      final pageTitle = project['title'];

      return BeamPage(
        key: ValueKey('project-$projectId'),
        title: pageTitle,
        child: ProjectDetails(
          project: project,
          title: pageTitle,
        ),
        onPopPage: (context, delegate, _, page) {
          delegate.update(
            configuration: const RouteInformation(
              location: '/?tab=projects',
            ),
            rebuild: false,
          );
          return true;
        },
      );
    },
  },
);
