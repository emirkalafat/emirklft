import 'package:blog_web_site/core/utils/center_error_text.dart';
import 'package:blog_web_site/services/firebase_storage/storage_controller.dart';
import 'package:blog_web_site/shared/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'blog_detail_view.dart';
import 'widgets/blog_card.dart';

class MyBlog extends ConsumerStatefulWidget {
  const MyBlog({super.key});

  @override
  ConsumerState<MyBlog> createState() => _MyBlogState();
}

class _MyBlogState extends ConsumerState<MyBlog> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: ref.watch(blogPostsFuture).when(
        data: (data) {
          if (data.isEmpty) {
            return const CenterErrorText('Hiç Paylaşım Yok...');
          }

          final posts = data.entries.toList();

          return SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1400),
                padding: EdgeInsets.symmetric(
                  horizontal: isSmall ? 24.0 : 80.0,
                  vertical: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PageHeader(
                      bigTitle: 'IDEAS',
                      subtitle: 'Thoughts & Engineering',
                      title: 'Blog Yazıları',
                      description:
                          'Kod, mimari ve dijital minimalizm üzerine keşifler. Teknik yolculuğumun bir günlüğü.',
                    ),
                    const SizedBox(height: 40),

                    // FEATURED POST
                    if (posts.isNotEmpty)
                      BlogCard(
                        isFeatured: true,
                        title: _extractTitle(posts.first.key),
                        description: _extractDescription(posts.first.key),
                        date: posts.first.value.timeCreated,
                        image: null,
                        onTap: () {
                          final title = _extractTitle(posts.first.key);
                          final content = posts.first.key;
                          final date = posts.first.value.timeCreated;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BlogDetailView(
                                title: title,
                                content: content,
                                date: date,
                              ),
                            ),
                          );
                        },
                      ),

                    const SizedBox(height: 40),

                    // GRID OF OTHER POSTS
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final crossAxisCount = constraints.maxWidth > 1200
                            ? 3
                            : constraints.maxWidth > 800
                                ? 2
                                : 1;

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 40,
                            mainAxisSpacing: 60,
                            mainAxisExtent: 450,
                          ),
                          itemCount: posts.length > 1 ? posts.length - 1 : 0,
                          itemBuilder: (context, index) {
                            final post = posts[index + 1];
                            final title = _extractTitle(post.key);
                            final content = post.key;
                            final date = post.value.timeCreated;

                            return BlogCard(
                              title: title,
                              description: _extractDescription(post.key),
                              date: date,
                              image: null,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BlogDetailView(
                                      title: title,
                                      content: content,
                                      date: date,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          );
        },
        error: (error, stackTrace) => CenterErrorText(error.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  String _extractTitle(String content) {
    final firstLine = content.split('\n').first;
    if (firstLine.startsWith('# ')) {
      return firstLine.substring(2);
    }
    return firstLine;
  }

  String _extractDescription(String content) {
    final lines = content.split('\n');
    if (lines.length > 1) {
      for (var i = 1; i < lines.length; i++) {
        if (lines[i].trim().isNotEmpty && !lines[i].startsWith('#')) {
          return lines[i].trim();
        }
      }
    }
    return "Yazı içeriği yükleniyor...";
  }
}
