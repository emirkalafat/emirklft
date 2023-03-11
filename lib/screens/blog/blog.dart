import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:blog_web_site/core/utils.dart';
import 'package:blog_web_site/services/firebase_storage/storage_controller.dart';
import 'package:blog_web_site/widgets/delayed_widget.dart';

class MyBlog extends ConsumerStatefulWidget {
  const MyBlog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyBlogState();
}

class _MyBlogState extends ConsumerState<MyBlog> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  late int selectedBlogIndex;

  @override
  void initState() {
    super.initState();
    selectedBlogIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Size size = MediaQuery.of(context).size;
    final bool isVertical = size.height / size.width < 0.8;
    final bool less600 = size.width < 600;

    return ref.watch(blogPostsFuture).when(
          //skipLoadingOnReload: true,
          data: (data) {
            if (data.isEmpty) {
              return const CenterErrorText('Hiç Paylaşım Yok...');
            }
            List<String> blogTitles =
                data.keys.map((e) => e.split('\n').first.substring(2)).toList();

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (less600)
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 36,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButton<String>(
                          focusNode: FocusNode(canRequestFocus: false),
                          isExpanded: false,
                          underline: Container(),
                          value: blogTitles[selectedBlogIndex],
                          items: List.generate(data.length, (index) {
                            return DropdownMenuItem(
                              value: blogTitles[index],
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(blogTitles[index]),
                              ),
                            );
                          }),
                          onChanged: (item) {
                            setState(() {
                              selectedBlogIndex = blogTitles.indexOf(item!);
                              itemScrollController.scrollTo(
                                index: selectedBlogIndex,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                Expanded(
                    child: Row(
                  children: [
                    if (isVertical) Flexible(flex: 1, child: Container()),
                    Flexible(
                      flex: 10,
                      child: ScrollablePositionedList.builder(
                        shrinkWrap: less600,
                        itemScrollController: itemScrollController,
                        itemPositionsListener: itemPositionsListener,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          String formatedTime = '';
                          final text = data.keys.elementAt(index);
                          final metadata = data.values.elementAt(index);
                          final updateDate = metadata.timeCreated;

                          return DelayedWidget(
                            delayDuration:
                                Duration(milliseconds: (index + 1) * 125),
                            from: DelayFrom.left,
                            child: FutureBuilder(
                              builder: (context, snapshot) {
                                return Stack(children: [
                                  Card(
                                    child: Markdown(
                                      styleSheet: MarkdownStyleSheet(
                                        h1: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                        blockquote: TextStyle(
                                            color:
                                                colorScheme.onPrimaryContainer),
                                        blockquoteDecoration: BoxDecoration(
                                          color: colorScheme.primaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(2.0),
                                        ),
                                      ),
                                      onTapLink: (text, href, title) {
                                        href != null
                                            ? Utils.startUrl(href)
                                            : null;
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
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        color: index == 0
                                            ? colorScheme.primaryContainer
                                            : colorScheme.secondaryContainer,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(formatedTime),
                                        ),
                                      )),
                                ]);
                              },
                              future:
                                  initializeDateFormatting('tr-TR', '').then(
                                (_) => formatedTime =
                                    DateFormat('EEEE, MMM d, yyyy', 'tr-TR')
                                        .format(updateDate!),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (isVertical) Flexible(flex: 1, child: Container()),
                    if (!less600)
                      BlogTitlesWidget(
                        itemScrollController: itemScrollController,
                        data: data,
                      ),
                  ],
                ))
              ],
            );
          },
          error: (error, stackTrace) => CenterErrorText(error.toString()),
          loading: () => const CenterLoading(withText: true),
        );
  }
}

class BlogTitlesWidget extends StatelessWidget {
  const BlogTitlesWidget({
    Key? key,
    required this.itemScrollController,
    required this.data,
  }) : super(key: key);

  final ItemScrollController itemScrollController;
  final Map<String, FullMetadata> data;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            itemBuilder: (context, index) {
              final blogPostTitle =
                  data.keys.elementAt(index).split('\n').first.substring(2);
              return DelayedWidget(
                delayDuration: Duration(milliseconds: (index + 1) * 125),
                from: DelayFrom.right,
                child: GestureDetector(
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
                ),
              );
            },
            itemCount: data.length,
          ),
        ),
      ],
    );
  }
}
