import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/project_detail_model.dart';
import 'package:blog_web_site/core/utils/utils.dart';

class ProjectDetailContent extends StatelessWidget {
  final ProjectDetailModel project;

  const ProjectDetailContent({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            project.name,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8,
            ),
            child: Text(project.explanation),
          ),
          if (project.googlePlayLink != null)
            TextButton.icon(
              icon: const Icon(FontAwesomeIcons.googlePlay),
              onPressed: () => Utils.startUrl(project.googlePlayLink!),
              label: const Text('Google Play\'den indirmek için tıklayın'),
            ),
          if (project.appStoreLink != null)
            TextButton.icon(
              icon: const Icon(FontAwesomeIcons.apple),
              onPressed: () => Utils.startUrl(project.appStoreLink!),
              label: const Text('App Store\'den indirmek için tıklayın'),
            ),
          if (project.additionalLinks != null)
            ...project.additionalLinks!.entries.map(
              (entry) => TextButton.icon(
                onPressed: () => Utils.startUrl(entry.value),
                icon: const Icon(Icons.link),
                label: Text(entry.key),
              ),
            ),
        ],
      ),
    );
  }
}
