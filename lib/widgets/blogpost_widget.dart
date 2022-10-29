import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/blog_post_model.dart';
import 'utils.dart';

class BlogPostWidget extends StatefulWidget {
  const BlogPostWidget({
    Key? key,
    required this.blogPosts,
    required this.index,
  }) : super(key: key);

  final List<BlogPost> blogPosts;
  final int index;

  @override
  State<BlogPostWidget> createState() => _BlogPostWidgetState();
}

class _BlogPostWidgetState extends State<BlogPostWidget> {
  GlobalKey _textKey = GlobalKey();

  bool isExpanded = false;
  double maxHeight = 150;
  double hey = 0;

  @override
  void setState(VoidCallback fn) {
    hey = _textKey.currentContext?.size?.height ?? double.infinity;
    print("state updated hey: $hey");
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final yayinTarihi = widget.blogPosts[widget.index].date.toDate();
    final yayinTarihiFarki = Timestamp.now().toDate().difference(yayinTarihi);
    List<String> eachContent = (widget.blogPosts[widget.index].contents)
        .map((item) => item as String)
        .toList();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withOpacity(0.5),
          borderRadius: BorderRadius.circular(32),
          boxShadow: const [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              blurRadius: 10,
              color: Colors.black,
              spreadRadius: 0,
            ),
          ],
        ),
        constraints: const BoxConstraints(
          maxWidth: 1000,
          minHeight: 200,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.blogPosts[widget.index].title.toUpperCase(),
                      style: const TextStyle(fontSize: 24),
                    ),
                    if (widget.index == 0)
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: colorScheme.primary, blurRadius: 5),
                          ],
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 6.0,
                          ),
                          child: Text(
                            "Yeni",
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),

              const Divider(),
              // ignore: sized_box_for_whitespace
              Container(
                //? Animated Container işini çözemedim :((
                //duration: Duration(milliseconds: 1000),
                //curve: Curves.easeOut,
                constraints: BoxConstraints(
                  maxHeight: isExpanded ? double.infinity : maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    //listview kaydırılmasın diye
                    child: ListView.builder(
                      key: _textKey,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: eachContent.length,
                      shrinkWrap: true,
                      itemBuilder: (context, contentIndex) {
                        final text = eachContent[contentIndex];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(text),
                            const SizedBox(
                              height: 8,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              if (!isExpanded)
                const Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 6),
                  child: Text("..."),
                ),
              const Divider(),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(isExpanded ? 'Küçült' : 'Devamını Oku'),
                  ),
                  const Spacer(),
                  Text(yayinTarihiFarki.inHours > 24
                      ? "${yayinTarihiFarki.inDays} gün önce"
                      : yayinTarihiFarki.inMinutes > 60
                          ? "${yayinTarihiFarki.inHours} saat önce"
                          : "${yayinTarihiFarki.inMinutes} dakika önce  "),
                  Text(
                      "  |  ${yayinTarihi.day}-${yayinTarihi.month}-${yayinTarihi.year} ${Utils.daysTR[yayinTarihi.weekday - 1]}  ${yayinTarihi.hour}:${yayinTarihi.minute.toString().padLeft(2, '0')}  "),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
