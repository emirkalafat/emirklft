import 'package:blog_web_site/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blog_web_site/services/firebase_storage/storage_controller.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';

class MyBlog extends ConsumerWidget {
  const MyBlog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    String formatedTime = '';

    return ref.watch(blogPostsFuture).when(
          //skipLoadingOnReload: true,
          data: (data) {
            if (data.isEmpty) {
              return const CenterErrorText('Hiç Paylaşım Yok...');
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final text = data.keys.elementAt(index);
                final metadata = data.values.elementAt(index);
                final updateDate = metadata.updated;

                return FutureBuilder(
                  builder: (context, snapshot) {
                    return Stack(children: [
                      Card(
                        child: Markdown(
                          styleSheet: MarkdownStyleSheet(
                            h1: Theme.of(context).textTheme.headlineMedium,
                            blockquote: TextStyle(
                                color: colorScheme.onPrimaryContainer),
                            blockquoteDecoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                          onTapLink: (text, href, title) {
                            href != null ? Utils.startUrl(href) : null;
                          },
                          selectable: true,
                          data: text,
                          shrinkWrap: true,
                        ),
                      ),
                      Positioned(top: 28, right: 24, child: Text(formatedTime)),
                    ]);
                  },
                  future: initializeDateFormatting('tr-TR', '').then((_) {
                    return formatedTime =
                        DateFormat('EEEE, MMM d, yyyy', 'tr-TR')
                            .format(updateDate!);
                  }),
                );
              },
            );
          },
          error: (error, stackTrace) => CenterErrorText(error.toString()),
          loading: () => const CenterLoading(withText: true),
        );
  }
}
