import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:blog_web_site/core/constants.dart';
import 'package:blog_web_site/screens/home/header/social%20media%20buttons/social_media_button.dart';

class SocialMediaButtons extends StatelessWidget {
  final int delayDuration;
  const SocialMediaButtons({
    Key? key,
    this.delayDuration = 1500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const alignment = WrapAlignment.start;
    const wrapAlignment = Alignment.center;

    return Container(
      alignment: wrapAlignment,
      child: Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        alignment: alignment,
        children: [
          //Github Butonu
          SocialMediaButton(
            delayDuration: delayDuration,
            index: 0,
            url: AppConstants.gitHubProfileURL,
            iconData: FontAwesomeIcons.github,
          ),
          //Mail Butonu
          SocialMediaButton(
            delayDuration: delayDuration,
            index: 1,
            url: AppConstants.eMail,
            iconData: Icons.alternate_email_rounded,
          ),
          //Linkedin Butonu
          SocialMediaButton(
            delayDuration: delayDuration,
            index: 2,
            url: AppConstants.linkedInProfileURL,
            iconData: FontAwesomeIcons.linkedin,
          ),
          //Instagram Butonu
          SocialMediaButton(
            delayDuration: delayDuration,
            index: 3,
            url: AppConstants.instagramProfileURL,
            iconData: FontAwesomeIcons.instagram,
          ),
          //Youtube Butonu
          SocialMediaButton(
            delayDuration: delayDuration,
            index: 4,
            url: AppConstants.youtubeProfileURL,
            iconData: FontAwesomeIcons.youtube,
          ),
        ],
      ),
    );
  }
}
