import 'package:blog_web_site/core/constants.dart';
import 'package:blog_web_site/core/theme.dart';
import 'package:blog_web_site/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

const linkTreeModelList = [
  LinkTreeModel(title: 'Siteye Devam Et', icon: Icons.home, route: '/'),
  LinkTreeModel(
      title: 'Instagram',
      icon: FontAwesomeIcons.instagram,
      url: AppConstants.instagramProfileURL),
  LinkTreeModel(
      title: 'Youtube',
      icon: FontAwesomeIcons.youtube,
      url: AppConstants.youtubeProfileURL),
  //LinkTreeModel(
  //    title: 'Twitter',
  //    icon: FontAwesomeIcons.twitter,
  //    url: AppConstants.twitterProfileURL),
  LinkTreeModel(
      title: 'Github',
      icon: FontAwesomeIcons.github,
      url: AppConstants.gitHubProfileURL),
  LinkTreeModel(
      title: 'LinkedIn',
      icon: FontAwesomeIcons.linkedin,
      url: AppConstants.linkedInProfileURL),
];

class LinkTreeModel {
  final String title;
  final String? route;
  final String? url;
  final IconData icon;
  const LinkTreeModel(
      {required this.title, this.route, this.url, required this.icon})
      : assert(route != null || url != null);
}

class LinkTreeScreen extends ConsumerStatefulWidget {
  const LinkTreeScreen({super.key});

  @override
  ConsumerState<LinkTreeScreen> createState() => _LinkTreeScreenState();
}

class _LinkTreeScreenState extends ConsumerState<LinkTreeScreen> {
  void toggleTheme() => ref.read(themeNotifierProvider.notifier).toggleTheme();
  bool get isDark =>
      ref.watch(themeNotifierProvider.notifier).theme == ThemeMode.dark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('LinkTree'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => toggleTheme(),
                        child: SizedBox(
                          width: 104,
                          height: 104,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Icon(
                              isDark ? Icons.dark_mode : Icons.light_mode,
                              size: 64,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 104,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  'Ahmet Emir Kalafat',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 100),
                    shrinkWrap: true,
                    itemCount: linkTreeModelList.length,
                    itemBuilder: (context, index) {
                      return LinkTreeCard(
                          linkTreeModel: linkTreeModelList[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class LinkTreeCard extends StatelessWidget {
  final LinkTreeModel linkTreeModel;
  const LinkTreeCard({
    super.key,
    required this.linkTreeModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => linkTreeModel.route != null
          ? context.replace(linkTreeModel.route!)
          : Utils.startUrl(linkTreeModel.url!),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.tertiaryContainer,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          width: 300,
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(
                linkTreeModel.icon,
                size: 64,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  linkTreeModel.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 24),
                ),
              ),
              const Spacer(),
              Text('Git', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
