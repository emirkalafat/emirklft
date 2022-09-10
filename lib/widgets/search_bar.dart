import 'package:flutter/material.dart';

Widget buildSearchBar() {
  return const Padding(
    padding: EdgeInsets.all(8.0),
    child: SizedBox(
      width: 200,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Arama',
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    ),
  );
}
