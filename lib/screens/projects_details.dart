import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildBodyWidgets(context, project),
          ],
        ),
      ),
    );
  }

  buildBodyWidgets(BuildContext context, Map<String, dynamic> project) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (project['id']) {
      case '1':
        //?Enfes Tarifler Proje Sayfası
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: colorScheme.secondary.withOpacity(0.5),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                      "Bu proje Flutter'ı anlamak ve kendimi geliştirmek için odaklandığım ilk projedir. Kendi yemek tariflerinizi paylaşabildiğiniz ve başkalarının paylaştığı yemek tariflerini inceleyebildiğiniz bir mobil uygulama."),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _launchUrl(
                    'https://play.google.com/store/apps/details?id=com.garlicman.flutter_tarif_sitesi');
              },
              child: const Image(
                image: AssetImage('assets/images/googlePlay.png'),
                height: 50,
              ),
            ),
          ],
        );
    }
  }
}
