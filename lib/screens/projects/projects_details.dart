import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:blog_web_site/core/utils.dart';
import 'package:blog_web_site/screens/projects/app_versions_card.dart';
import 'package:blog_web_site/services/firestore/changelogs/changelogs_controller.dart';
import 'package:blog_web_site/services/firestore/versions/versions_controller.dart';

class ProjectDetails extends ConsumerWidget {
  final String projectID;
  const ProjectDetails({
    Key? key,
    required this.projectID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController controller = ScrollController();
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textStyle = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: colorScheme.background,
        appBar: AppBar(
            //title: Text(projectID),
            leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Beamer.of(context).beamBack();
          },
        )),
        body: ref.watch(changelogProvider(projectID)).when(
              data: (data) {
                return data.isEmpty
                    ? const Center(
                        child: Text('No data'),
                      )
                    : Center(
                        child: Builder(builder: (context) {
                          final info = data.first;
                          return SingleChildScrollView(
                            controller: controller,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  info.name,
                                  style: textStyle.headlineLarge,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 8,
                                  ),
                                  child: Text(info.explanation),
                                ),
                                Visibility(
                                  visible: info.googlePlayLink != null,
                                  child: SizedBox(
                                    width: 290,
                                    child: TextButton(
                                        onPressed: () {
                                          Utils.startUrl(info.googlePlayLink!);
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(FontAwesomeIcons.googlePlay),
                                            SizedBox(width: 8),
                                            Text(
                                                'Google Play\'den indirmek için tıklayın'),
                                          ],
                                        )),
                                  ),
                                ),
                                Visibility(
                                  visible: info.appStoreLink != null,
                                  child: TextButton(
                                      onPressed: () {
                                        Utils.startUrl(info.appStoreLink!);
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(FontAwesomeIcons.apple),
                                          SizedBox(width: 8),
                                          Text(
                                              'App Store\'den indirmek için tıklayın'),
                                        ],
                                      )),
                                ),
                                if (info.additionalLinks != null)
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: info.additionalLinks!.length,
                                    itemBuilder: (context, index) {
                                      final link = info.additionalLinks!.values
                                          .elementAt(index);
                                      return Center(
                                        child: TextButton.icon(
                                            onPressed: () {
                                              Utils.startUrl(link);
                                            },
                                            icon: const Icon(Icons.link),
                                            label: Text(info
                                                .additionalLinks!.keys
                                                .elementAt(index))),
                                      );
                                    },
                                  ),
                                const SizedBox(height: 32),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: SizedBox(width: 800, child: Divider()),
                                ),
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 800),
                                  child: ref
                                      .watch(versionsProvider(info.storageID))
                                      .when(
                                        data: (versions) {
                                          return ListView.builder(
                                            itemCount: versions.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              final version = versions[index];
                                              return AppVersionCard(
                                                version: version,
                                                latest: index == 0,
                                              );
                                            },
                                          );
                                        },
                                        error: (error, stackTrace) => Center(
                                          child: Text(error.toString()),
                                        ),
                                        loading: () => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          );
                        }),
                      );
              },
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }
}
