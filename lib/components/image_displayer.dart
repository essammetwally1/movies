import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/models/movie_model.dart';

class ImageDisplayer extends StatelessWidget {
  const ImageDisplayer({super.key, required this.movie});

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            movie.mediumCoverImage,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                "https://static.vecteezy.com/system/resources/previews/022/059/000/original/no-image-available-icon-vector.jpg",
                fit: BoxFit.cover,
              );
            },
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
                    movie.rating.toString(),
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
