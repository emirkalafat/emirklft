import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogCard extends StatefulWidget {
  final String title;
  final String description;
  final DateTime? date;
  final String? image;
  final bool isFeatured;
  final VoidCallback? onTap;

  const BlogCard({
    super.key,
    required this.title,
    required this.description,
    this.date,
    this.image,
    this.isFeatured = false,
    this.onTap,
  });

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: widget.isFeatured ? _buildFeaturedCard(context) : _buildStandardCard(context),
      ),
    );
  }

  Widget _buildFeaturedCard(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 900;

    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      child: Column(
        children: [
          Row(
            children: [
              if (!isSmall)
                Expanded(
                  flex: 6,
                  child: _buildImageSection(aspectRatio: 16 / 9),
                ),
              if (!isSmall) const SizedBox(width: 60),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildMetadata(context),
                    const SizedBox(height: 24),
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      widget.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildReadMore(context),
                  ],
                ),
              ),
            ],
          ),
          if (isSmall) const SizedBox(height: 24),
          if (isSmall) _buildImageSection(aspectRatio: 16 / 9),
          const SizedBox(height: 40),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.05)),
        ],
      ),
    );
  }

  Widget _buildStandardCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageSection(aspectRatio: 3 / 2),
        const SizedBox(height: 24),
        _buildMetadata(context),
        const SizedBox(height: 16),
        Text(
          widget.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.2,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildImageSection({required double aspectRatio}) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            if (widget.image != null)
              Positioned.fill(
                child: AnimatedScale(
                  scale: _isHovered ? 1.05 : 1.0,
                  duration: const Duration(milliseconds: 700),
                  child: Image.network(
                    widget.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.white.withValues(alpha: 0.02),
                      child: Center(
                        child: Icon(
                          Icons.article_outlined,
                          color: Colors.white.withValues(alpha: 0.05),
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            else
              Positioned.fill(
                child: Container(color: Colors.white.withValues(alpha: 0.02)),
              ),
            Positioned.fill(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _isHovered ? 0.0 : 0.2,
                child: Container(color: Colors.black),
              ),
            ),
            if (widget.isFeatured)
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  color: Colors.black.withValues(alpha: 0.5),
                  child: Text(
                    '★ FEATURED',
                    style: GoogleFonts.spaceMono(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadata(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Text(
          widget.date != null ? '${widget.date!.day}.${widget.date!.month}.${widget.date!.year}' : 'NO DATE',
          style: GoogleFonts.spaceMono(
            textStyle: TextStyle(
              color: colorScheme.primary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(width: 30, height: 1, color: Colors.white.withValues(alpha: 0.2)),
        const SizedBox(width: 16),
        Text(
          'ARTICLES',
          style: GoogleFonts.spaceMono(
            textStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReadMore(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            color: _isHovered ? Colors.white : Colors.transparent,
          ),
          child: Icon(
            Icons.arrow_outward,
            size: 20,
            color: _isHovered ? Colors.black : Colors.white,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          'YAZIYI OKU',
          style: GoogleFonts.spaceMono(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
      ],
    );
  }
}
