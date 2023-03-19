import 'package:blog_web_site/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';

class ShimmerBlogCards extends StatelessWidget {
  const ShimmerBlogCards({
    Key? key,
    required this.less600,
  }) : super(key: key);
  final bool less600;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          if (less600)
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Yükleniyor...   ",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 16)),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              shrinkWrap: true,
              itemBuilder: (_, __) => ShimmerLoading(
                    isLoading: true,
                    child: Card(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ...List.generate(16, (index) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  )),
        ],
      ),
    );
  }
}
