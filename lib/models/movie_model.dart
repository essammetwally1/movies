// models/movie_model.dart
class MovieModel {
  final int id;
  final String url;
  final String title;
  final int runtime;
  final double rating;
  final String mediumCoverImage;

  MovieModel({
    required this.id,
    required this.url,
    required this.title,
    required this.runtime,
    required this.rating,
    required this.mediumCoverImage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      title: json['title'] ?? '',
      runtime: json['runtime'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
      mediumCoverImage: json['medium_cover_image'] ?? '',
    );
  }
}
