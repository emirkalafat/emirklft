import 'package:blog_web_site/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blog_web_site/services/firebase_storage/storage_controller.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MyBlog extends ConsumerStatefulWidget {
  const MyBlog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyBlogState();
}

class _MyBlogState extends ConsumerState<MyBlog> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  String formatedTime = '';

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Size size = MediaQuery.of(context).size;
    final bool isVertical = size.height / size.width < 0.8;

    return ref.watch(blogPostsFuture).when(
          //skipLoadingOnReload: true,
          data: (data) {
            if (data.isEmpty) {
              return const CenterErrorText('Hiç Paylaşım Yok...');
            }

            return Row(
              children: [
                if (isVertical) Flexible(flex: 1, child: Container()),
                Flexible(
                  flex: 10,
                  child: ScrollablePositionedList.builder(
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
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
                                  h1: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
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
                            Positioned(
                                top: 20,
                                right: 18,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  color: index == 0
                                      ? colorScheme.secondaryContainer
                                      : colorScheme.primaryContainer,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(formatedTime),
                                  ),
                                )),
                          ]);
                        },
                        future: initializeDateFormatting('tr-TR', '').then(
                          (_) => formatedTime =
                              DateFormat('EEEE, MMM d, yyyy', 'tr-TR')
                                  .format(updateDate!),
                        ),
                      );
                    },
                  ),
                ),
                if (isVertical) Flexible(flex: 1, child: Container()),
                Column(
                  children: [
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Yazılar',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(
                      //color: Colors.red,
                      width: 200,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        itemBuilder: (context, index) {
                          final blogPostTitle = data.keys
                              .elementAt(index)
                              .split('\n')
                              .first
                              .substring(2);
                          return GestureDetector(
                            onTap: () {
                              itemScrollController.scrollTo(
                                index: index,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut,
                              );
                            },
                            child: Card(
                                color: colorScheme.tertiaryContainer,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(blogPostTitle),
                                )),
                          );
                        },
                        itemCount: data.length,
                      ),
                    ),
                  ],
                )
              ],
            );
          },
          error: (error, stackTrace) => CenterErrorText(error.toString()),
          loading: () => const CenterLoading(withText: true),
        );
  }
}
