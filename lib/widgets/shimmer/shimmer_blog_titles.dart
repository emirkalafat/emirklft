import 'package:blog_web_site/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';

class ShimmerBlogTitles extends StatelessWidget {
  const ShimmerBlogTitles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(children: [
        const SizedBox(height: 8),
        Text(
          "Yükleniyor...",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (_, __) => ShimmerLoading(
              isLoading: true,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  margin: const EdgeInsets.all(8),
                  color: Colors.transparent,
                  child: Container(
                    width: double.infinity,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              )),
        ),
      ]),
    );
  }
}
