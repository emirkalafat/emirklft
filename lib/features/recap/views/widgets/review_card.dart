import 'package:blog_web_site/features/recap/models/activity.dart';
import 'package:blog_web_site/shared/widgets/animated_translation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewCard extends StatefulWidget {
  final Activity activity;
  final VoidCallback? onTap;

  const ReviewCard({
    super.key,
    required this.activity,
    this.onTap,
  });

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 900;
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 80),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Media Image (Poster style)
              if (!isSmall)
                _buildPoster(context, 3, 200),
              
              if (!isSmall) const SizedBox(width: 60),

              // Content Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title & Rating Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.activity.title.toUpperCase(),
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: -1,
                                ),
                          ),
                        ),
                        _buildRating(context),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    // Metadata
                    Text(
                      '${widget.activity.type.name.toUpperCase()} // ${widget.activity.startedDate?.year ?? 'N/A'}',
                      style: GoogleFonts.spaceMono(
                        textStyle: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Quote/Summary with Border
                    Container(
                      padding: const EdgeInsets.only(left: 24),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: _isHovered ? colorScheme.primary : Colors.white.withValues(alpha: 0.1),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        widget.activity.personalNote ?? widget.activity.description,
                        style: GoogleFonts.playfairDisplay(
                          textStyle: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Technical Note
                    if (widget.activity.personalNote != null)
                       Padding(
                         padding: const EdgeInsets.only(bottom: 24),
                         child: Text(
                           widget.activity.description,
                           style: TextStyle(
                             color: Colors.white.withValues(alpha: 0.3),
                             fontSize: 13,
                             height: 1.4,
                           ),
                         ),
                       ),

                    // Full Review Link
                    Row(
                      children: [
                        Text(
                          'İNCELEMEYİ OKU',
                          style: GoogleFonts.spaceMono(
                            textStyle: TextStyle(
                              color: _isHovered ? colorScheme.primary : Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        AnimatedTranslation(
                          offset: _isHovered ? const Offset(5, 0) : Offset.zero,
                          child: Icon(
                            Icons.arrow_right_alt,
                            color: _isHovered ? colorScheme.primary : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPoster(BuildContext context, int flex, double width) {
    return Container(
      width: width,
      height: width * 1.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          if (widget.activity.imageUrl != null)
            Positioned.fill(
              child: AnimatedScale(
                scale: _isHovered ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 700),
                child: Image.network(
                  widget.activity.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.white.withValues(alpha: 0.02),
                    child: const Center(child: Icon(Icons.movie_outlined, color: Colors.white10)),
                  ),
                ),
              ),
            ),
          Positioned.fill(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isHovered ? 0.0 : 0.3,
              child: Container(color: Colors.black),
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.black.withValues(alpha: 0.6),
              child: Text(
                widget.activity.type.name.toUpperCase(),
                style: GoogleFonts.spaceMono(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRating(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final rating = widget.activity.personalRating ?? 0.0;
    
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() 
              ? Icons.star 
              : (index < rating ? Icons.star_half : Icons.star_outline),
          size: 20,
          color: index < rating ? colorScheme.primary : Colors.white.withValues(alpha: 0.1),
        );
      }),
    );
  }
}
