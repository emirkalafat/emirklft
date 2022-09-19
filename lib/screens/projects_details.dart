import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:blog_web_site/data/project_versions.dart'
    as project_versions_data;

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({super.key, required this.project, required this.title});
  final Map<String, dynamic> project;
  final String title;

  _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(title),
      ),
      body: buildBodyWidgets(context, project),
    );
  }

  buildBodyWidgets(BuildContext context, Map<String, dynamic> project) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    switch (project['id']) {
      case '1':
        //?Enfes Tarifler Proje Sayfası
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(project['explanation']),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                      "Bu proje Flutter'ı anlamak ve kendimi geliştirmek için odaklandığım ilk projedir. Kendi yemek tariflerinizi paylaşabildiğiniz ve başkalarının paylaştığı yemek tariflerini inceleyebildiğiniz bir mobil uygulama."),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchUrl(
                      'https://play.google.com/store/apps/details?id=com.garlicman.flutter_tarif_sitesi');
                },
                child: const Center(
                  child: Image(
                    image: AssetImage('assets/images/googlePlay.png'),
                    height: 50,
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _launchUrl(
                        'https://play.google.com/apps/testing/com.garlicman.flutter_tarif_sitesi');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Uygulamanın beta sürümüne erişmek için tıklayın.',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const Divider(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Uygulama Sürüm Notları',
                    style: textTheme.displayMedium,
                  ),
                ),
              ),
              AppVersions(app: project_versions_data.versions[0]),
            ],
          ),
        );
      case '2':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(project['explanation']),
            ),
            GestureDetector(
              onTap: () {
                _launchUrl('https://github.com/emirkalafat/emirklft');
              },
              child: Container(
                color: colorScheme.primary.withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sitenin kaynak kodu için tıklayın.'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, right: 4.0),
                        child: Image.asset(
                          'assets/images/github.png',
                          height: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
    }
  }
}

class AppVersions extends StatelessWidget {
  const AppVersions({
    Key? key,
    required this.app,
  }) : super(key: key);

  final Map<String, dynamic> app;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: screenWidth < 780 ? double.infinity : screenWidth - 200,
          minWidth: 580,
        ),
        child: ListView.separated(
            shrinkWrap: true,
            //primary: true,
            itemBuilder: (context, index) {
              final indexedVersion = app['versions'][index];
              var versionAndDate = <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    indexedVersion['version'],
                    style: textTheme.displaySmall!.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Yayınlanma tarihi: ${indexedVersion['date']}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ];
              return Card(
                color: colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      screenWidth < 550
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: versionAndDate,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: versionAndDate,
                            ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                        child: Text('Yapılan Değişikler'),
                      ),
                      ListView.builder(
                        padding: const EdgeInsets.all(8),
                        shrinkWrap: true,
                        itemBuilder: (context, index2) {
                          return Text('* ${indexedVersion['changes'][index2]}');
                        },
                        itemCount: indexedVersion['changes'].length,
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                        child: Text('Düzeltilen Hatalar'),
                      ),
                      ListView.builder(
                        padding: const EdgeInsets.all(8),
                        shrinkWrap: true,
                        itemBuilder: (context, index3) {
                          return Text(
                              '* ${indexedVersion['fixed bugs'][index3]}');
                        },
                        itemCount: indexedVersion['fixed bugs'].length,
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              );
            },
            itemCount: project_versions_data.versions[0]['versions'].length),
      ),
    );
  }
}
