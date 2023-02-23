import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:blog_web_site/data/project_versions.dart'
    as project_versions_data;

import '../widgets/utils.dart';
import 'app_versions_widget.dart';

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({super.key, required this.project, required this.title});
  final Map<String, dynamic> project;
  final String title;

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  Color? hoverColor;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: buildBodyWidgets(context, widget.project),
    );
  }

  buildBodyWidgets(BuildContext context, Map<String, dynamic> project) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    switch (project['id']) {
      case '1':
        //?Yemek Deposu Proje Sayfası
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
              InkWell(
                onTap: () {
                  Utils.startUrl(
                      'https://play.google.com/store/apps/details?id=com.garlicman.flutter_tarif_sitesi');
                },
                child: const Center(
                  child: Image(
                    image: AssetImage('assets/images/googlePlay.png'),
                    height: 75,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Utils.startUrl('https://trello.com/b/QcikUWjc/yemek-deposu');
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(
                        image: AssetImage('assets/images/trello.png'),
                        height: 40,
                      ),
                      SizedBox(width: 16),
                      Text(
                          'Uygulamanın Detaylı Geliştirme Süreci Takibi İçin Tıklayın'),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.beamToNamed(
                        '/yemekdeposu',
                        beamBackOnPop: true,
                      );
                    },
                    child: const Text("Yemek Deposu Gizlilik Sözleşmesi"),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      Utils.startUrl(
                          'https://play.google.com/apps/testing/com.garlicman.flutter_tarif_sitesi');
                    },
                    onHover: (value) {
                      setState(() {
                        hoverColor =
                            value ? Colors.blue : colorScheme.onBackground;
                      });
                    },
                    child: Text(
                      'Uygulamanın beta sürümüne erişmek için tıklayın.',
                      style: TextStyle(
                          color: hoverColor ?? colorScheme.onBackground),
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
                    style: textTheme.displayMedium!
                        .copyWith(color: colorScheme.onBackground),
                  ),
                ),
              ),
              AppVersions(
                  app: project_versions_data.versions[
                      project_versions_data.versions.indexWhere(
                          (element) => element['id'] == project['id'])]),
            ],
          ),
        );
      case '2':
        //?MultiKronometre Proje Sayfası
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
                      "Bu proje 10 taneye kadar kronometre tanımlayabildiğiniz bir mobil uygulama."),
                ),
              ),
              InkWell(
                onTap: () {
                  //!link eklenecek
                  Utils.startUrl('abount:blank');
                },
                child: const Center(
                  child: Image(
                    image: AssetImage('assets/images/googlePlay.png'),
                    height: 75,
                  ),
                ),
              ),
              //!gizlilik sözleşmesi eklenecek
              //Center(
              //  child: Padding(
              //    padding: const EdgeInsets.all(8.0),
              //    child: ElevatedButton(
              //      onPressed: () {
              //        context.beamToNamed(
              //          '/enfestarifler',
              //          beamBackOnPop: true,
              //        );
              //      },
              //      child: const Text("Yemek Deposu Gizlilik Sözleşmesi"),
              //    ),
              //  ),
              //),
              const SizedBox(height: 50),
              const Divider(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Uygulama Sürüm Notları',
                    style: textTheme.displayMedium!
                        .copyWith(color: colorScheme.onBackground),
                  ),
                ),
              ),
              AppVersions(
                  app: project_versions_data.versions[
                      project_versions_data.versions.indexWhere(
                          (element) => element['id'] == project['id'])]),
            ],
          ),
        );
      case '3':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(project['explanation']),
            ),
            InkWell(
              hoverColor: Colors.blue,
              onTap: () {
                Utils.startUrl('https://github.com/emirkalafat/emirklft');
              },
              child: Container(
                color: colorScheme.primary.withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Sitenin kaynak kodu için tıklayın.',
                        ),
                      ),
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
