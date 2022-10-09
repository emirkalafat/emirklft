import 'package:blog_web_site/data/blog_post_model.dart';
import 'package:flutter/material.dart';

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
          return ListView.builder(
            itemBuilder: (context, index) {
              return Text(blogPosts[index].title);
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
