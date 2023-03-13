import 'package:blog_web_site/core/theme.dart';
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
import 'package:blog_web_site/widgets/shimmer/shimmer.dart';
import 'package:blog_web_site/widgets/shimmer/shimmer_loading.dart';

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

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (less600)
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 40,
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
                        padding: const EdgeInsets.only(bottom: 250),
                        shrinkWrap: less600,
                        itemScrollController: itemScrollController,
                        itemPositionsListener: itemPositionsListener,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final text = data.keys.elementAt(index);
                          final metadata = data.values.elementAt(index);
                          final updateDate = metadata.timeCreated;

                          return DelayedWidget(
                              delayDuration:
                                  Duration(milliseconds: (index + 1) * 125),
                              from: DelayFrom.left,
                              child: Stack(children: [
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
                                        child: Text(DateFormat(
                                                'EEEE, MMM d, yyyy', 'tr-TR')
                                            .format(updateDate!)),
                                      ),
                                    )),
                              ]));
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
                )),
              ],
            );
          },
          error: (error, stackTrace) => CenterErrorText(error.toString()),
          loading: () {
            if (less600) {
              return Shimmer(
                linearGradient:
                    isDark ? _shimmerGradientDark : _shimmerGradientLight,
                child: const ShimmerBlogCards(less600: true),
              );
            } else {
              return Shimmer(
                linearGradient:
                    isDark ? _shimmerGradientDark : _shimmerGradientLight,
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
}

class ShimmerBlogTitles extends StatelessWidget {
  const ShimmerBlogTitles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(children: [
        const SizedBox(height: 8),
        Text(
          "Yükleniyor...",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (_, __) => ShimmerLoading(
              isLoading: true,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  margin: const EdgeInsets.all(8),
                  color: Colors.transparent,
                  child: Container(
                    width: double.infinity,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              )),
        ),
      ]),
    );
  }
}

class ShimmerBlogCards extends StatelessWidget {
  const ShimmerBlogCards({
    Key? key,
    required this.less600,
  }) : super(key: key);
  final bool less600;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          if (less600)
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Yükleniyor...   ",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 16)),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              shrinkWrap: true,
              itemBuilder: (_, __) => ShimmerLoading(
                    isLoading: true,
                    child: Card(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ...List.generate(16, (index) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  )),
        ],
      ),
    );
  }
}

const _colorGradientDark = [
  Color.fromARGB(255, 18, 18, 20),
  Color.fromARGB(255, 25, 25, 27),
  Color.fromARGB(255, 18, 18, 20),
];

const _colorGradientLight = [
  Color(0xFFEBEBF4),
  Color(0xFFF4F4F4),
  Color(0xFFEBEBF4),
];

const _shimmerGradientLight = LinearGradient(
  colors: _colorGradientLight,
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

const _shimmerGradientDark = LinearGradient(
  colors: _colorGradientDark,
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

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
