import 'package:blog_web_site/values/values.dart';
import 'package:blog_web_site/widgets/page_scaffold.dart';
import 'package:flutter/material.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: StringConst.aboutMeScreen,
      body: Container(),
    );
  }
}
