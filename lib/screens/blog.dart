import 'package:blog_web_site/data/blog_post_model.dart';
import 'package:flutter/material.dart';

import '../widgets/blogpost_widget.dart';

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
                constraints: BoxConstraints(
                  maxWidth: 1200,
                  maxHeight: MediaQuery.of(context).size.height,
                ),
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