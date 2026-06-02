import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:blog_web_site/widgets/page_header.dart';
import 'package:blog_web_site/core/utils/utils.dart';

class BlogDetailView extends StatelessWidget {
  final String title;
  final String content;
  final DateTime? date;

  const BlogDetailView({
    super.key,
    required this.title,
    required this.content,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          // Back Button
          Positioned(
            top: 40,
            left: isSmall ? 20 : 40,
            child: Material(
              color: Colors.transparent,
              child: IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.05),
                ),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/blog');
                  }
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),

          // Content
          SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 900),
                padding: EdgeInsets.symmetric(
                  horizontal: isSmall ? 24.0 : 80.0,
                  vertical: 100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    PageHeader(
                      bigTitle: 'ARTICLE',
                      subtitle: date != null ? '${date!.day}.${date!.month}.${date!.year}' : 'BLOG',
                      title: title,
                      description: 'Thoughts, engineering, and digital craftsmanship.',
                    ),

                    const SizedBox(height: 40),

                    // Markdown Content
                    MarkdownBody(
                      data: content,
                      selectable: true,
                      onTapLink: (text, href, title) {
                        if (href != null) Utils.startUrl(href);
                      },
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 18,
                          height: 1.8,
                          fontWeight: FontWeight.w300,
                        ),
                        h1: GoogleFonts.syne(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        h2: GoogleFonts.syne(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        code: GoogleFonts.spaceMono(
                          textStyle: TextStyle(
                            backgroundColor: Colors.white.withOpacity(0.05),
                            color: colorScheme.primary,
                          ),
                        ),
                        codeblockDecoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.02),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.white.withOpacity(0.05)),
                        ),
                        blockquote: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontStyle: FontStyle.italic,
                        ),
                        blockquoteDecoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: colorScheme.primary, width: 4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
