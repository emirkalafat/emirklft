import 'package:flutter/material.dart';

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({super.key, required this.project, required this.title});
  final Map<String, dynamic> project;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildBodyWidgets(context, project),
          ],
        ),
      ),
    );
  }

  buildBodyWidgets(BuildContext context, Map<String, dynamic> project) {
    switch (project['id']) {
      case '1':
        return Column(children: [
          Text("falan"),
          Text("falan"),
          Text("falan"),
          Text("falan"),
          Text("falan"),
        ]);

      default:
    }
  }
}
