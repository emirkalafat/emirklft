import 'package:blog_web_site/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blog_web_site/services/firebase_storage/storage_controller.dart';

class MyBlog extends ConsumerWidget {
  const MyBlog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ref.watch(blogPostsFuture).when(
          //skipLoadingOnReload: true,
          data: (data) {
            if (data.isEmpty) {
              return const CenterErrorText('Hiç Paylaşım Yok...');
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Markdown(
                    styleSheet: MarkdownStyleSheet(
                      h1: Theme.of(context).textTheme.headlineMedium,
                      blockquote:
                          TextStyle(color: colorScheme.onPrimaryContainer),
                      blockquoteDecoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                    onTapLink: (text, href, title) {
                      href != null ? Utils.startUrl(href) : null;
                    },
                    selectable: true,
                    data: data[index],
                    shrinkWrap: true,
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) => CenterErrorText(error.toString()),
          loading: () => const CenterLoading(withText: true),
        );
  }
}
