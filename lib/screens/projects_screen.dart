import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class MyProjectsPage extends StatelessWidget {
  const MyProjectsPage({
    Key? key,
    required this.projects,
  }) : super(key: key);
  final List<Map<String, dynamic>> projects;

  @override
  Widget build(BuildContext context) {
    final titleQuery = (context.currentBeamLocation.state as BeamState)
        .queryParameters['title'];
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final crossAxisCount = (screenSize.width / 300).round();
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Center(
        child: GridView.count(
          shrinkWrap: true,
          childAspectRatio: 2,
          crossAxisCount: crossAxisCount,
          children: projects
              .map(
                (project) => GestureDetector(
                  onTap: () => context.beamToNamed(
                    '/projects/${project['id']}',
                    data: {'title': titleQuery},
                  ),
                  child: Card(
                    shadowColor: colorScheme.shadow,
                    color: colorScheme.tertiaryContainer,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            project['title'],
                            style: textTheme.headline6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            project['explanation'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
