import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class MyProjectsPage extends StatelessWidget {
  const MyProjectsPage({Key? key, required this.projects, required this.title})
      : super(key: key);
  final List<Map<String, dynamic>> projects;
  final String title;

  @override
  Widget build(BuildContext context) {
    final titleQuery = (context.currentBeamLocation.state as BeamState)
        .queryParameters['title'];
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: projects
            .map(
              (project) => ListTile(
                title: Text(project['title']),
                //subtitle: Text(project['author']),
                onTap: () => context.beamToNamed(
                  '/projects/${project['id']}',
                  data: {'title': titleQuery},
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
