import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import '../models/project_detail_model.dart';
import '../models/project_version_filter_model.dart';
import '../viewmodels/project_details_view_model.dart';
import '../viewmodels/version_view_model.dart';
import 'widgets/app_version_card.dart';
import 'package:blog_web_site/widgets/page_header.dart';
import 'package:blog_web_site/core/utils/utils.dart';

class ProjectDetailView extends ConsumerStatefulWidget {
  final String projectId;
  const ProjectDetailView({super.key, required this.projectId});

  @override
  ConsumerState<ProjectDetailView> createState() => _ProjectDetailViewState();
}

class _ProjectDetailViewState extends ConsumerState<ProjectDetailView> {
  bool showBetaVersions = false;

  @override
  Widget build(BuildContext context) {
    final projectDetailState =
        ref.watch(projectDetailStreamProvider(widget.projectId));
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: projectDetailState.when(
        data: (projects) {
          if (projects.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Proje bulunamadı'),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => context.go('/projects'),
                    child: const Text('PROJELERE DÖN'),
                  ),
                ],
              ),
            );
          }
          final project = projects.first;

          return Stack(
            children: [
              // Cinematic Background Image (Blurred)
              if (project.image != null)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: size.height * 0.5,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          project.image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                colorScheme.surface.withOpacity(0.4),
                                colorScheme.surface,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                          child: Container(color: Colors.transparent),
                        ),
                      ),
                    ],
                  ),
                ),

              // Back Button
              //Positioned(
              //  top: 40,
              //  left: isSmall ? 20 : 40,
              //  child: IconButton.filled(
              //    style: IconButton.styleFrom(
              //      backgroundColor: Colors.white.withOpacity(0.05),
              //    ),
              //    onPressed: () => context.go('/projects'),
              //    icon: const Icon(Icons.arrow_back, color: Colors.white),
              //  ),
              //),

              // Scrollable Content
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmall ? 24.0 : 80.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            PageHeader(
                              bigTitle: 'PROJECT',
                              subtitle: project.storageID.toUpperCase(),
                              title: project.name,
                              description: project.explanation,
                            ),

                            const SizedBox(height: 40),

                            // Links Section
                            _buildExternalLinks(context, project),

                            const SizedBox(height: 80),

                            // Versions Section Title
                            _buildSectionHeader(context, '03 / EVOLUTION', 'Versiyon Geçmişi'),
                            
                            const SizedBox(height: 20),
                            _buildBetaSwitch(context),
                            const SizedBox(height: 32),
                            _buildVersionsList(projects),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String label, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceMono(
            textStyle: TextStyle(
              color: colorScheme.primary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ],
    );
  }

  Widget _buildExternalLinks(BuildContext context, ProjectDetailModel project) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        if (project.googlePlayLink != null)
          _buildLinkButton(context, 'PLAY STORE', Icons.shop, project.googlePlayLink!),
        if (project.appStoreLink != null)
          _buildLinkButton(context, 'APP STORE', Icons.apple, project.appStoreLink!),
        if (project.additionalLinks != null)
          ...project.additionalLinks!.entries.map(
            (entry) => _buildLinkButton(context, entry.key.toUpperCase(), Icons.link, entry.value),
          ),
      ],
    );
  }

  Widget _buildLinkButton(BuildContext context, String label, IconData icon, String url) {
    return InkWell(
      onTap: () => Utils.startUrl(url),
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white.withOpacity(0.6), size: 18),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.spaceMono(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBetaSwitch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Beta sürümlerini göster',
          style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
        ),
        const SizedBox(width: 12),
        Switch(
          activeColor: Theme.of(context).colorScheme.primary,
          value: showBetaVersions,
          onChanged: (value) {
            setState(() {
              showBetaVersions = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildVersionsList(List<ProjectDetailModel> projects) {
    return ref.watch(versionsProvider(ProjectVersionFilterModel(
      storageID: projects.first.storageID,
      showBetaVersions: showBetaVersions,
    ))).when(
      data: (versions) => ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: versions.length,
        itemBuilder: (context, index) => AppVersionCard(
          version: versions[index],
          latest: index == 0,
        ),
      ),
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
