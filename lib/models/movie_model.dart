class MovieModel {
  final int id;
  final String url;
  final String title;
  final String image;
  final double rating;
  final int runtime;
  final String summary;
  final List<String> genres;
  final List<CastModel> cast;

  MovieModel({
    required this.id,
    required this.url,
    required this.title,
    required this.image,
    required this.rating,
    required this.runtime,
    required this.summary,
    required this.genres,
    required this.cast,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      title: json['title'] ?? '',
      image: json['medium_cover_image'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      runtime: json['runtime'] ?? 0,
      summary: json['description_full'] ?? '',
      genres:
          (json['genres'] as List<dynamic>?)
              ?.map((g) => g.toString())
              .toList() ??
          [],
      cast:
          (json['cast'] as List<dynamic>?)
              ?.map((c) => CastModel.fromJson(c))
              .toList() ??
          [],
    );
  }
}

class CastModel {
  final String name;
  final String characterName;
  final String imageUrl;

  CastModel({
    required this.name,
    required this.characterName,
    required this.imageUrl,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'] ?? '',
      characterName: json['character_name'] ?? '',
      imageUrl: json['url_small_image'] ?? '',
    );
  }
}
