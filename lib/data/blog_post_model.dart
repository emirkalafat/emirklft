import 'package:cloud_firestore/cloud_firestore.dart';

class BlogPost {
  String title;
  String content;
  Timestamp date;
  String? category;
  String id;
  BlogPost({
    required this.title,
    required this.content,
    required this.date,
    required this.category,
    this.id = '',
  });

  static Future<List<BlogPost>> readBlogPost() {
    return FirebaseFirestore.instance
        .collection('blogPosts')
        .orderBy('title')
        .get()
        .then((event) =>
            event.docs.map((e) => BlogPost.fromJson(e.data())).toList());

    //.then((value) => value.docs.map((e) => BlogPost.fromJson(e.data())).toList());
  }

  static BlogPost fromJson(Map<String, dynamic> json) => BlogPost(
        category: json['category'] ?? 'Havadan Sudan',
        content: json['content'],
        title: json['title'],
        date: json['date'],
      );
}
