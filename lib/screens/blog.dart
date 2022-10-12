import 'package:blog_web_site/data/blog_post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

List<String> days = [
  'Pazartesi',
  'Salı',
  'Çarşamba',
  'Perşembe',
  'Cuma',
  'Cumartesi',
  'Pazar'
];

class MyBlog extends StatelessWidget {
  const MyBlog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BlogPost.readBlogPost(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          final blogPosts = snapshot.data as List<BlogPost>;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: ListView.builder(
                  itemCount: blogPosts.length,
                  itemBuilder: (context, index) {
                    return BlogPostWidget(
                      blogPosts: blogPosts,
                      index: index,
                    );
                  },
                ),
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

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
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final yayinTarihi = widget.blogPosts[widget.index].date.toDate();
    final yayinTarihiFarki = Timestamp.now().toDate().difference(yayinTarihi);
    List<String> eachContent = (widget.blogPosts[widget.index].contents)
        .map((item) => item as String)
        .toList();

    return Container(
      constraints: const BoxConstraints(
        maxWidth: 1000,
        minHeight: 200,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  widget.blogPosts[widget.index].title.toUpperCase(),
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  constraints: BoxConstraints(
                      maxHeight: isExpanded ? double.infinity : 180),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    //listview kaydırılmasın diye
                    child: ListView.builder(
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
                      "  |  ${yayinTarihi.day}-${yayinTarihi.month}-${yayinTarihi.year} ${days[yayinTarihi.weekday - 1]}  ${yayinTarihi.hour}:${yayinTarihi.minute.toString().padLeft(2, '0')}"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
