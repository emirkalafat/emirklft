import 'package:blog_web_site/html_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class EnfesTariflerGizlilikSozlesmesi extends StatelessWidget {
  const EnfesTariflerGizlilikSozlesmesi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).colorScheme.background.withOpacity(0.93),
      appBar: AppBar(
        title: const Text("Enfes Tarifler Gizlilik Bildirimi"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: HtmlWidget(
            HTMLPages.gizlilik,
            onErrorBuilder: (context, element, error) =>
                Text('$element error: $error'),
            onLoadingBuilder: (context, element, loadingProgress) =>
                const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
