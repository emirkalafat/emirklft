import 'package:blog_web_site/widgets/default_widgets.dart';
import 'package:flutter/material.dart';

import '../../data/database.dart';
import '../../widgets/utils.dart';

class MyLinksSection extends StatefulWidget {
  const MyLinksSection({super.key});

  @override
  State<MyLinksSection> createState() => _MyLinksSectionState();
}

class _MyLinksSectionState extends State<MyLinksSection> {
  List<Color?> color = List.generate(links.length, (index) => null);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      constraints: buildDefaultConstraints(maxHeight: 45),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onHover: (value) {
              setState(() {
                color[index] = value ? Colors.blue : colorScheme.onBackground;
              });
            },
            onTap: () {
              Utils.startUrl(links.values.elementAt(index));
            },
            // ignore: avoid_unnecessary_containers
            child: Container(
              //color: Colors.black,
              child: Text(
                links.keys.elementAt(index),
                style:
                    TextStyle(color: color[index] ?? colorScheme.onBackground),
              ),
            ),
          ),
        ),
        itemCount: links.length,
      ),
    );
  }
}
