import 'package:flutter/material.dart';
import '../services/navigation_service.dart';

class ColumnNavOverlay extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onClose;
  final int currentIndex;

  const ColumnNavOverlay({
    super.key,
    required this.isOpen,
    required this.onClose,
    required this.currentIndex,
  });

  @override
  State<ColumnNavOverlay> createState() => _ColumnNavOverlayState();
}

class _ColumnNavOverlayState extends State<ColumnNavOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    if (widget.isOpen) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(ColumnNavOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen && !oldWidget.isOpen) {
      _controller.forward();
    } else if (!widget.isOpen && oldWidget.isOpen) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Semi-transparent background fade
          GestureDetector(
            onTap: widget.onClose,
            child: Container(
              color: Colors.black.withValues(alpha: 0.95),
              width: size.width,
              height: size.height,
            ),
          ),

          // Sliding Columns
          Flex(
            direction: isSmall ? Axis.vertical : Axis.horizontal,
            children: [
              if (!isSmall) const SizedBox(width: 80),
              if (isSmall) const SizedBox(height: 60),
              ...NavigationService.menuItems.map((item) {
                final index = NavigationService.menuItems.indexOf(item);
                final isSelected = index == widget.currentIndex;

                return Expanded(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      // Staggered slide effect
                      final slideProgress = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                          index * 0.1,
                          0.5 + (index * 0.1),
                          curve: Curves.easeOutQuart,
                        ),
                      ).value;

                      return Transform.translate(
                        offset: isSmall
                            ? Offset(size.width * (1 - slideProgress), 0)
                            : Offset(0, size.height * (1 - slideProgress)),
                        child: Opacity(
                          opacity: slideProgress.clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.05),
                              border: Border(
                                right: isSmall
                                    ? BorderSide.none
                                    : BorderSide(
                                        color: Colors.white
                                            .withValues(alpha: 0.05)),
                                bottom: isSmall
                                    ? BorderSide(
                                        color: Colors.white
                                            .withValues(alpha: 0.05))
                                    : BorderSide.none,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                NavigationService.navigateTo(context, index);
                                widget.onClose();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${item.number} — ${item.label.toUpperCase()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: isSelected
                                                ? colorScheme.primary
                                                : Colors.white
                                                    .withValues(alpha: 0.4),
                                            letterSpacing: 2,
                                            fontSize: isSmall ? 10 : null,
                                          ),
                                    ),
                                    SizedBox(height: isSmall ? 8 : 20),
                                    Text(
                                      item.label,
                                      style: (isSmall
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                              : Theme.of(context)
                                                  .textTheme
                                                  .displaySmall)
                                          ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (!isSmall) ...[
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          item.description,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Colors.white
                                                    .withValues(alpha: 0.4),
                                              ),
                                        ),
                                      ),
                                    ],
                                    if (isSelected)
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: isSmall ? 8 : 20),
                                        child: Container(
                                          width: 40,
                                          height: 2,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),

          // Close button at top right
          Positioned(
            top: 20,
            right: 20,
            child: FadeTransition(
              opacity: _controller,
              child: IconButton(
                onPressed: widget.onClose,
                icon: const Icon(Icons.close, color: Colors.white, size: 32),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
