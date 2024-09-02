import 'package:blog_web_site/html_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class YemekDeposuGizlilikSozlesmesi extends StatelessWidget {
  const YemekDeposuGizlilikSozlesmesi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).colorScheme.surface.withOpacity(0.93),
      appBar: AppBar(
        title: const Text("Yemek Deposu Gizlilik Bildirimi"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 1800),
          child: CustomScrollView(
            slivers: [
              HtmlWidget(
                HTMLPages.gizlilikEnfesTarifler,
                enableCaching: true,
                onErrorBuilder: (context, element, error) =>
                    Center(child: Text('$element error: $error')),
                onLoadingBuilder: (context, element, loadingProgress) => Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress,
                  ),
                ),
                renderMode: RenderMode.sliverList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
