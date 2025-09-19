import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';

class ImageDisplayer extends StatelessWidget {
  final String movieImage;
  final double rating;

  const ImageDisplayer({
    super.key,
    required this.movieImage,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            movieImage,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: AppTheme.white,
              child: const Icon(Icons.broken_image, color: Colors.white),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    rating.toString(),
                    style: const TextStyle(
                      color: AppTheme.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 3),
                  const Icon(Icons.star, color: AppTheme.primary, size: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
