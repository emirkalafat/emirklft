import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:blog_web_site/widgets/source_aware_image.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../models/project_model.dart';

class ShowcaseAppItem extends StatelessWidget {
  final ProjectModel app;

  const ShowcaseAppItem(
    this.app, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          FirebaseAnalytics.instance.logEvent(
            name: 'showcase_app_item_tapped',
            parameters: <String, Object>{
              'app_name': app.name,
            },
          );
          context.go('/projects/${app.id}');
        },
        child: _buildChild(context),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (app.image != null)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: SizedBox(
              height: 180,
              child: SourceAwareImage(
                image: app.image!,
                isNetworkImage: true,
                fit: BoxFit.cover,
              ),
            ),
          ),
        _buildBottom(context),
      ],
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            app.name,
            style: Theme.of(context).textTheme.titleLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (app.googlePlayLink != null)
                _buildIconButton(
                  icon: FontAwesomeIcons.googlePlay,
                  onTap: () => launchUrlString(app.googlePlayLink!),
                ),
              if (app.appStoreLink != null)
                _buildIconButton(
                  icon: FontAwesomeIcons.appStoreIos,
                  onTap: () => launchUrlString(app.appStoreLink!),
                ),
              if (app.githubLink != null)
                _buildIconButton(
                  icon: FontAwesomeIcons.github,
                  onTap: () => launchUrlString(app.githubLink!),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return IconButton(
      icon: FaIcon(icon),
      onPressed: onTap,
      tooltip: 'Open Link',
    );
  }
}
