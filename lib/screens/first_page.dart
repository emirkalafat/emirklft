import 'package:blog_web_site/values/values.dart';
import 'package:blog_web_site/widgets/page_scaffold.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: StringConst.mainScreen,
      body: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.background),
        child: Column(
          children: [
            Flexible(
              flex: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Text(
                          "Ahmet Emir Kalafatttt",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Ahmet Emir Kalafat",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      "Ahmet Emir Kalafat",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer),
                child: Text(
                  "ahmet",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
