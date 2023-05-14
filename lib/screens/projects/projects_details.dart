import 'package:beamer/beamer.dart';
import 'package:blog_web_site/screens/projects/project_details_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:blog_web_site/core/utils.dart';
import 'package:blog_web_site/screens/projects/app_versions_card.dart';
import 'package:blog_web_site/services/firestore/changelogs/changelogs_controller.dart';
import 'package:blog_web_site/services/firestore/versions/versions_controller.dart';

class ProjectDetails extends ConsumerStatefulWidget {
  final String projectID;
  const ProjectDetails({
    super.key,
    required this.projectID,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends ConsumerState<ProjectDetails> {
  late bool showBetaVersions;

  @override
  void initState() {
    super.initState();
    showBetaVersions = false;
  }

  @override
  Widget build(BuildContext context) {
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
            if (Beamer.of(context).canBeamBack) {
              Beamer.of(context).beamBack();
            } else {
              Beamer.of(context).beamToNamed('/?tab=projects');
            }
          },
        )),
        body: ref.watch(changelogProvider(widget.projectID)).when(
              data: (data) {
                return data.isEmpty
                    ? const Center(
                        child: Text('No data'),
                      )
                    : Center(
                        child: Builder(builder: (context) {
                          final info = data.first;
                          //final ProjectDetailsInfoModel search =
                          //    ProjectDetailsInfoModel(
                          //  storageID: info.storageID,
                          //  showBetaVersions: showBetaVersions,
                          //);
                          bool? isRecentBeta = ref
                              .watch(versionsProvider(ProjectDetailsInfoModel(
                                storageID: info.storageID,
                                showBetaVersions: true,
                              )))
                              .when(
                                data: (versionsList) {
                                  if (versionsList.first.isBeta) {
                                    return true;
                                  } else {
                                    return false;
                                  }
                                },
                                loading: () => null,
                                error: (error, stack) {
                                  return null;
                                },
                              );
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
                                  child: TextButton.icon(
                                      icon: const Icon(
                                          FontAwesomeIcons.googlePlay),
                                      onPressed: () {
                                        Utils.startUrl(info.googlePlayLink!);
                                      },
                                      label: const Text(
                                          'Google Play\'den indirmek için tıklayın')),
                                ),
                                Visibility(
                                  visible: info.appStoreLink != null,
                                  child: TextButton(
                                      onPressed: () {
                                        Utils.startUrl(info.appStoreLink!);
                                      },
                                      child: const Row(
                                        children: [
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 800),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (isRecentBeta != null &&
                                            isRecentBeta &&
                                            !showBetaVersions) ...[
                                          const SizedBox(width: 8),
                                          const Text(
                                              'Yeni Beta Sürümler Mevcut'),
                                          const Spacer(),
                                        ],
                                        const Text('Beta sürümlerini göster'),
                                        Switch(
                                          value: showBetaVersions,
                                          onChanged: (value) {
                                            setState(() {
                                              showBetaVersions = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 800),
                                  child: ref
                                      .watch(versionsProvider(
                                          ProjectDetailsInfoModel(
                                        storageID: info.storageID,
                                        showBetaVersions: showBetaVersions,
                                      )))
                                      .when(
                                        data: (versions) {
                                          return ListView.builder(
                                            itemCount: versions.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              final version = versions[index];
                                              if ((version.version == '')) {
                                                return const SizedBox.shrink();
                                              }
                                              return AppVersionCard(
                                                version: version,
                                                latest: index == 0,
                                              );
                                            },
                                          );
                                        },
                                        error: (error, stackTrace) {
                                          print(error.toString());
                                          return CenterErrorText(
                                              error.toString());
                                        },
                                        loading: () => const CenterLoading(),
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
