import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:blog_web_site/core/constants.dart';
import 'package:blog_web_site/core/theme.dart';
import 'package:blog_web_site/core/utils.dart';
import 'package:blog_web_site/services/firebase_storage/storage_controller.dart';
import 'package:blog_web_site/widgets/blog/blog_title_widget.dart';
import 'package:blog_web_site/widgets/delayed_widget.dart';
import 'package:blog_web_site/widgets/shimmer/shimmer.dart';
import 'package:blog_web_site/widgets/shimmer/shimmer_blog_cards.dart';
import 'package:blog_web_site/widgets/shimmer/shimmer_blog_titles.dart';

class MyBlog extends ConsumerStatefulWidget {
  const MyBlog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyBlogState();
}

class _MyBlogState extends ConsumerState<MyBlog> {
  late ItemScrollController itemScrollController;
  late ItemPositionsListener itemPositionsListener;
  late int selectedBlogIndex;

  @override
  void initState() {
    super.initState();
    itemScrollController = ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();
    initializeDateFormatting('tr-TR', '');
    selectedBlogIndex = 0;
    itemPositionsListener.itemPositions.addListener(() {
      if (itemPositionsListener.itemPositions.value.isNotEmpty) {
        setState(() {
          selectedBlogIndex =
              itemPositionsListener.itemPositions.value.first.index;
        });
      }
    });
  }

  bool get isDark {
    return ref.watch(themeNotifierProvider.notifier).theme == ThemeMode.dark;
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
            if (less600) {
              return NestedScrollView(
                floatHeaderSlivers: false,
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  buildLess600Selector(blogTitles, data),
                ],
                body: BlogCardListView(
                  data: data,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  colorScheme: colorScheme,
                ),
              );
            }
            return Row(
              children: [
                if (isVertical) Flexible(flex: 1, child: Container()),
                Flexible(
                  flex: 10,
                  child: BlogCardListView(
                    data: data,
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                    colorScheme: colorScheme,
                  ),
                ),
                if (isVertical) Flexible(flex: 1, child: Container()),
                BlogTitlesWidget(
                  itemScrollController: itemScrollController,
                  data: data,
                ),
              ],
            );
          },
          error: (error, stackTrace) => CenterErrorText(error.toString()),
          loading: () {
            if (less600) {
              return Shimmer(
                linearGradient:
                    isDark ? shimmerGradientDark : shimmerGradientLight,
                child: const ShimmerBlogCards(less600: true),
              );
            } else {
              return Shimmer(
                linearGradient:
                    isDark ? shimmerGradientDark : shimmerGradientLight,
                child: Row(
                  children: [
                    if (isVertical) Flexible(flex: 1, child: Container()),
                    const Flexible(
                        flex: 10,
                        child: ShimmerBlogCards(
                          less600: false,
                        )),
                    if (isVertical) Flexible(flex: 1, child: Container()),
                    const ShimmerBlogTitles()
                  ],
                ),
              );
            }
          },
        );
  }

  SliverAppBar buildLess600Selector(
      List<String> blogTitles, Map<String, FullMetadata> data) {
    return SliverAppBar(
      pinned: true,
      actions: [
        Padding(
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
      ],
    );
  }
}

class BlogCardListView extends StatefulWidget {
  const BlogCardListView({
    super.key,
    required this.data,
    required this.itemScrollController,
    required this.itemPositionsListener,
    required this.colorScheme,
  });

  final Map<String, FullMetadata> data;
  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;
  final ColorScheme colorScheme;

  @override
  State<BlogCardListView> createState() => _BlogCardListViewState();
}

class _BlogCardListViewState extends State<BlogCardListView> {
  late List<bool> isOpenList;

  @override
  void initState() {
    super.initState();
    isOpenList = List.filled(widget.data.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      //physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 250),
      //shrinkWrap: less600,
      itemScrollController: widget.itemScrollController,
      itemPositionsListener: widget.itemPositionsListener,
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        final text = widget.data.keys.elementAt(index);
        final metadata = widget.data.values.elementAt(index);
        final updateDate = metadata.timeCreated;
        bool isOpen = isOpenList[index];
        return DelayedWidget(
            delayDuration: Duration(milliseconds: (index + 1) * 125),
            from: DelayFrom.left,
            child: Stack(
              children: [
                Card(
                  child: Markdown(
                    styleSheet: MarkdownStyleSheet(
                      h1: Theme.of(context).textTheme.headlineMedium,
                      blockquote: TextStyle(
                          color: widget.colorScheme.onPrimaryContainer),
                      blockquoteDecoration: BoxDecoration(
                        color: widget.colorScheme.primaryContainer,
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
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  top: 18,
                  right: isOpen ? 18 : 0,
                  child: SizedBox(
                    width: isOpen ? null : 50,
                    child: GestureDetector(
                      onTap: () => setState(() {
                        isOpenList[index] = !isOpenList[index];
                      }),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: isOpen
                              ? BorderRadius.circular(6.0)
                              : const BorderRadius.only(
                                  topRight: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  topLeft: Radius.circular(6),
                                  bottomLeft: Radius.circular(6),
                                ),
                        ),
                        color: index == 0
                            ? widget.colorScheme.primaryContainer
                            : widget.colorScheme.secondaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: isOpen
                              ? Text(DateFormat('EEEE, MMM d, yyyy', 'tr-TR')
                                  .format(updateDate!))
                              : const Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 18,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
