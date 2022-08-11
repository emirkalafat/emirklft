import 'dart:convert';

import 'package:blog_web_site/values/gizlilik_html.dart';
import 'package:blog_web_site/widgets/page_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EnfesTariflerScreen extends StatefulWidget {
  const EnfesTariflerScreen({Key? key}) : super(key: key);

  @override
  State<EnfesTariflerScreen> createState() => _EnfesTariflerScreenState();
}

class _EnfesTariflerScreenState extends State<EnfesTariflerScreen> {
  late WebViewController controller;

  void loadLocalHTML() async {
    final url = Uri.dataFromString(
      HTMLPages.gizlilik,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();
    controller.loadUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        title: 'Enfes Tarifler',
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: HtmlWidget(
              HTMLPages.gizlilik,
              onErrorBuilder: (context, element, error) =>
                  Text('$element error: $error'),
              onLoadingBuilder: (context, element, loadingProgress) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          ),
        )
        //WebView(
        //  javascriptMode: JavascriptMode.unrestricted,
        //  onWebViewCreated: (controller) {
        //    this.controller = controller;
        //    loadLocalHTML();
        //  },
        //),
        );
  }
}
