import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/cloud_firestore_platform_interface.dart';
import 'package:flutter/material.dart';

class BlogPost {
  String title;
  String content;
  String author;
  Timestamp? date;
  String category;
  String id;
  BlogPost({
    required this.title,
    required this.content,
    this.author = 'Ahmet Emir Kalafat',
    this.date,
    required this.category,
    this.id = '',
  });

  static Future<QuerySnapshot<Map<String, dynamic>>> readBlogPost() {
    return FirebaseFirestore.instance.collection('blogPosts').get();
  }

  static BlogPost fromJson(Map<String, dynamic> json) => BlogPost(
        category: '',
        content: '',
        title: '',
      );
}
