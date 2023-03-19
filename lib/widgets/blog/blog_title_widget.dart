import 'package:blog_web_site/widgets/delayed_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
