import 'package:beamer/beamer.dart';
import 'package:blog_web_site/data/projects.dart';
import 'package:flutter/material.dart';

class MyProjectsPage extends StatefulWidget {
  const MyProjectsPage({
    Key? key,
    required this.projects,
  }) : super(key: key);
  final List<Map<String, dynamic>> projects;

  @override
  State<MyProjectsPage> createState() => _MyProjectsPageState();
}

class _MyProjectsPageState extends State<MyProjectsPage> {
  List<Color?> color = List.generate(projects.length, (index) => null);

  @override
  Widget build(BuildContext context) {
    final titleQuery = (context.currentBeamLocation.state as BeamState)
        .queryParameters['title'];
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundC = colorScheme.background;
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        color: backgroundC,
        child: GridView.count(
          shrinkWrap: true,
          childAspectRatio: 2,
          crossAxisCount: 2,
          children: widget.projects
              .map(
                (project) => InkWell(
                  onHover: (value) {
                    setState(() {
                      color[widget.projects.indexOf(project)] = value
                          ? colorScheme.tertiaryContainer.withOpacity(0.5)
                          : colorScheme.tertiaryContainer;
                    });
                  },
                  onTap: () => context.beamToNamed(
                    '/projects/${project['id']}',
                    data: {'title': titleQuery},
                  ),
                  child: Card(
                    shadowColor: colorScheme.shadow,
                    color: color[widget.projects.indexOf(project)] ??
                        colorScheme.tertiaryContainer,
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
