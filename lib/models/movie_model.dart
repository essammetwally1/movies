class MovieModel {
  final String title;
  final String image;
  final double rating;

  MovieModel({required this.title, required this.image, required this.rating});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'] ?? '',
      image: json['medium_cover_image'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
