import 'package:beamer/beamer.dart';
import 'package:blog_web_site/models/changelog_model.dart';
import 'package:blog_web_site/widgets/animated_image_overlay.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:blog_web_site/widgets/external_link_button.dart';
import 'package:blog_web_site/widgets/source_aware_image.dart';

class ShowcaseAppItem extends StatelessWidget {
  final Changelog app;

  const ShowcaseAppItem(
    this.app, {
    Key? key,
  }) : super(key: key);

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
          _buildChild(),
          Positioned(
            top: 0.0,
            // bottom: 192.0,
            left: 0.0,
            right: 0.0,
            child: GestureDetector(
              // When overlay tapped, open full screen interactive image viewer.
              onTap: () {
                return Beamer.of(context).beamToNamed('/projects/${app.id}');
              },
              child: AnimatedImageOverlay(app.name),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChild() {
    return Container(
      color: const Color.fromRGBO(54, 56, 72, 1.0),
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
          _buildBottom(),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return Padding(
      padding: const EdgeInsets.all(24.0).copyWith(bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppName(),
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

  Widget _buildAppName() {
    return Text(
      app.name,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 1.4,
      ),
    );
  }
}
