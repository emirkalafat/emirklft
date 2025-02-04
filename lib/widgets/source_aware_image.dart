import 'package:flutter/material.dart';

class SourceAwareImage extends StatelessWidget {
  final String image;
  final bool isNetworkImage;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const SourceAwareImage({
    required this.image,
    required this.isNetworkImage,
    this.fit,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isNetworkImage) {
      return Image.network(
        image,
        fit: fit,
        width: width,
        height: height,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          );
        },
      );
    }
    
    return Image.asset(
      image,
      fit: fit,
      width: width,
      height: height,
    );
  }
}
