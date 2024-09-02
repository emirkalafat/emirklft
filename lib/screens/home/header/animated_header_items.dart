import 'package:blog_web_site/core/constants.dart';
import 'package:blog_web_site/widgets/delayed_widget.dart';
import 'package:blog_web_site/screens/home/header/social%20media%20buttons/social_media_buttons.dart';
import 'package:flutter/material.dart';

class AnimatedHeaderItems extends StatelessWidget {
  const AnimatedHeaderItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(maxWidth: 700),
      padding: const EdgeInsets.symmetric(
        vertical: 96.0,
        horizontal: 24.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Personal logo
              ClipOval(
                child: FadeInImage.assetNetwork(
                  //Görsel Github profilinden çekiliyor
                  image: 'https://avatars.githubusercontent.com/u/54103348?v=4',
                  placeholder: 'assets/images/transparent.png',
                  height: 120,
                  width: 120,
                ),
              ),
              const SizedBox(width: 16.0),

              // Text: "Ahmet Emir Kalafat"
              Expanded(
                child: DelayedWidget(
                  delayDuration: const Duration(milliseconds: 1000),
                  from: DelayFrom.right,
                  child: SelectableText(
                    AppConstants.landingTitle,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                          letterSpacing: 4.0,
                        ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),

          //// Divider between
          //const DelayedWidget(
          //  delayDuration: Duration(milliseconds: 1400),
          //  from: DelayFrom.top,
          //  child: Divider(),
          //),
          //const SizedBox(height: 20.0),

          // Text
          DelayedWidget(
            delayDuration: const Duration(milliseconds: 1500),
            from: DelayFrom.top,
            child: SelectableText(
              AppConstants.landingMotto,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16,
                    //fontWeight: FontWeight.w400,
                    color: colorScheme.onSurface,
                    letterSpacing: 1.8,
                  ),
            ),
          ),
          const SizedBox(height: 40.0),

          const SocialMediaButtons(),
          //
        ],
      ),
    );
  }
}
