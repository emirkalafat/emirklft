import 'package:blog_web_site/features/projects/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class ProjectCardNew extends StatefulWidget {
  final ProjectModel project;
  const ProjectCardNew({super.key, required this.project});

  @override
  State<ProjectCardNew> createState() => _ProjectCardNewState();
}

class _ProjectCardNewState extends State<ProjectCardNew> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    switch (widget.project.variant) {
      case 'featured':
        return _buildFeaturedVariant(context);
      case 'split':
        return _buildSplitVariant(context);
      default:
        return _buildTileVariant(context);
    }
  }

  Widget _buildTileVariant(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: _isHovered ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.05),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: [
              // Background Image
              if (widget.project.image != null)
                Positioned.fill(
                  child: AnimatedScale(
                    scale: _isHovered ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 700),
                    child: Opacity(
                      opacity: _isHovered ? 0.3 : 0.6,
                      child: Image.network(
                        widget.project.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.9),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => context.go('/projects/${widget.project.id}'),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.project.name.toUpperCase(),
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: -1,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: 40,
                          height: 1,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.project.explanation,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (widget.project.stack != null)
                          Wrap(
                            spacing: 8,
                            children: widget.project.stack!.map((tag) => Text(
                              tag,
                              style: GoogleFonts.spaceMono(
                                textStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.3),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )).toList(),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              // Top Right Arrow
              Positioned(
                top: 20,
                right: 20,
                child: AnimatedOpacity(
                  opacity: _isHovered ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(Icons.arrow_outward, color: Colors.white, size: 32),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedVariant(BuildContext context) {
    // Featured spans 2 columns in a grid ideally, but here we define its height/width
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: _isHovered ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.05),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: [
              // Background Image
              if (widget.project.image != null)
                Positioned.fill(
                  child: AnimatedScale(
                    scale: _isHovered ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 700),
                    child: Opacity(
                      opacity: _isHovered ? 0.4 : 0.6,
                      child: Image.network(
                        widget.project.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.7],
                    ),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(48.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.project.stack != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Wrap(
                          spacing: 12,
                          children: widget.project.stack!.map((tag) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white.withOpacity(0.2)),
                              color: Colors.white.withOpacity(0.05),
                            ),
                            child: Text(
                              tag.toUpperCase(),
                              style: GoogleFonts.spaceMono(
                                textStyle: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )).toList(),
                        ),
                      ),
                    Text(
                      widget.project.name,
                      style: GoogleFonts.playfairDisplay(
                        textStyle: const TextStyle(
                          fontSize: 48,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          height: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Text(
                        widget.project.explanation,
                        style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14, height: 1.6),
                      ),
                    ),
                    const SizedBox(height: 24),
                    AnimatedTranslation(
                      offset: _isHovered ? Offset.zero : const Offset(0, 20),
                      child: AnimatedOpacity(
                        opacity: _isHovered ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: TextButton.icon(
                          onPressed: () => context.go('/projects/${widget.project.id}'),
                          icon: const Text('PROJEYİ GÖR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          label: const Icon(Icons.arrow_outward, color: Colors.white, size: 16),
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        ),
                      ),
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

  Widget _buildSplitVariant(BuildContext context) {
    // A side-by-side variant (simplified for now to match dimensions)
    return _buildTileVariant(context);
  }
}

class AnimatedTranslation extends StatelessWidget {
  final Widget child;
  final Offset offset;

  const AnimatedTranslation({super.key, required this.child, required this.offset});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: Matrix4.translationValues(offset.dx, offset.dy, 0),
      child: child,
    );
  }
}
