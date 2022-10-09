import 'package:beamer/beamer.dart';
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
                    final yayinTarihi = blogPosts[index].date.toDate();
                    final yayinTarihiFarki =
                        Timestamp.now().toDate().difference(yayinTarihi);

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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    blogPosts[index].title.toUpperCase(),
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  const Spacer(),
                                  Text(yayinTarihiFarki.inHours > 24
                                      ? "${yayinTarihiFarki.inDays} gün önce"
                                      : yayinTarihiFarki.inMinutes > 60
                                          ? "${yayinTarihiFarki.inHours} saat önce"
                                          : "${yayinTarihiFarki.inMinutes} dakika önce"),
                                  const SizedBox(width: 10),
                                  Text(
                                      " Yayınlanma Tarihi: ${yayinTarihi.day} ${yayinTarihi.month} ${yayinTarihi.year} ${days[yayinTarihi.weekday - 1]}  ${yayinTarihi.hour}:${yayinTarihi.minute}"),
                                ],
                              ),
                              Divider(),
                              Text(
                                blogPosts[index].content,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              InkWell(
                                  onTap: () {
                                    Beamer.of(context).beamToNamed(
                                        "/blog/${blogPosts[index].id}");
                                  },
                                  child: Text("Devamını Okuyayım...")),
                            ],
                          ),
                        ),
                      ),
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
