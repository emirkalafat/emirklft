import 'package:flutter/material.dart';

class ClosableSearchBar extends StatefulWidget {
  const ClosableSearchBar({
    super.key,
  });

  @override
  State<ClosableSearchBar> createState() => _ClosableSearchBarState();
}

class _ClosableSearchBarState extends State<ClosableSearchBar> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return isSearching
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        isSearching = false;
                      });
                    },
                  ),
                  hintText: 'Arama',
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ),
          )
        : IconButton(
            onPressed: () {
              setState(
                () {
                  isSearching = true;
                },
              );
            },
            icon: const Icon(Icons.search),
          );
  }
}
