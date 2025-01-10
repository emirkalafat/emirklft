import 'package:beamer/beamer.dart';
import 'package:blog_web_site/models/changelog_model.dart';
import 'package:blog_web_site/widgets/animated_image_overlay.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:blog_web_site/widgets/external_link_button.dart';
import 'package:blog_web_site/widgets/source_aware_image.dart';

class ShowcaseAppItem extends StatelessWidget {
  final Changelog app;

  const ShowcaseAppItem(
    this.app, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
        bottomLeft: Radius.circular(4.0),
        bottomRight: Radius.circular(4.0),
      ),
      child: Stack(
        children: [
          _buildChild(context),
          Positioned(
            top: 0.0,
            // bottom: 192.0,
            left: 0.0,
            right: 0.0,
            child: GestureDetector(
              // When overlay tapped, open full screen interactive image viewer.
              onTap: () {
                FirebaseAnalytics.instance.logEvent(
                  name: 'showcase_app_item_tapped',
                  parameters: <String, Object>{
                    'app_name': app.name,
                  },
                );
                return Beamer.of(context).beamToNamed('/projects/${app.id}');
              },
              child: AnimatedImageOverlay(app.name),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: app.image != null,
            child: SourceAwareImage(
              image: app.image!,
              isNetworkImage: true,
            ),
          ),
          _buildBottom(context),
        ],
      ),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0).copyWith(bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //App Title
              Text(app.name, style: Theme.of(context).textTheme.titleLarge),
              const Divider(
                thickness: 1.5,
                height: 32.0,
              ),
            ],
          ),
          if (app.googlePlayLink != null) ...[
            ExternalLinkButton(
              url: app.googlePlayLink!,
              iconData: FontAwesomeIcons.googlePlay,
              label: 'Play Store',
            ),
            const SizedBox(height: 10.0),
          ],
          if (app.appStoreLink != null) ...[
            ExternalLinkButton(
              url: app.appStoreLink!,
              iconData: FontAwesomeIcons.appStoreIos,
              label: 'App Store',
            ),
            const SizedBox(height: 10.0),
          ],
          if (app.githubLink != null)
            ExternalLinkButton(
              url: app.githubLink!,
              iconData: FontAwesomeIcons.squareGithub,
              label: 'GitHub',
            ),
        ],
      ),
    );
  }
}
