import 'package:beamer/beamer.dart';
import 'package:blog_web_site/screens/gizlilik_sozlesmesi.dart';
import 'package:flutter/cupertino.dart';

import '../screens/home_screen.dart';
import '../screens/projects_details.dart';
import '../screens/projects_screen.dart';
import 'package:blog_web_site/projects.dart' as projectsData;

final locationBuilder = RoutesLocationBuilder(
  routes: {
    '/': (context, state, data) => const BeamPage(
          key: ValueKey('home'),
          title: 'Home',
          child: HomePage(),
        ),
    '/enfestarifler': (context, state, data) => const BeamPage(
          key: ValueKey('enfestarifler'),
          title: 'Enfes Tarifler Gizlilik Sözleşmesi',
          child: EnfesTariflerGizlilikSozlesmesi(),
        ),
    '/projects': (context, state, data) {
      final titleQuery = state.queryParameters['title'] ??
          (data is Map ? (data['title'] ?? '') : '');
      final genreQuery = state.queryParameters['genre'] ?? '';
      final pageTitle = titleQuery != ''
          ? "Books with name '$titleQuery'"
          : genreQuery != ''
              ? "Books with genre '$genreQuery'"
              : 'Bütün Projelerim';
      final projects = titleQuery != ''
          ? projectsData.projects.where((project) =>
              project['title'].toLowerCase().contains(titleQuery.toLowerCase()))
          : genreQuery != ''
              ? projectsData.projects
                  .where((project) => project['genres'].contains(genreQuery))
              : projectsData.projects;

      return BeamPage(
        key: ValueKey('projects-$titleQuery-$genreQuery'),
        title: pageTitle,
        child: MyProjectsPage(
          projects: projects.toList(),
          title: pageTitle,
        ),
      );
    },
    '/projects/:projectId': (context, state, data) {
      final projectId = state.pathParameters['projectId'];
      final project = projectsData.projects
          .firstWhere((project) => project['id'] == projectId);
      final pageTitle = project['title'];

      return BeamPage(
        key: ValueKey('project-$projectId'),
        title: pageTitle,
        child: ProjectDetails(
          project: project,
          title: pageTitle,
        ),
      );
    },
  },
);
