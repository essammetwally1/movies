import 'package:movies/models/movie_model.dart';

abstract class BrowseState {}

class BrowseLoading extends BrowseState {}

class BrowseLoaded extends BrowseState {
  final List<MovieModel> movies;
  final List<String> genres;
  final int selectedGenreIndex;

  BrowseLoaded({
    required this.movies,
    required this.genres,
    this.selectedGenreIndex = 0,
  });

  List<MovieModel> moviesByGenre(String genre) {
    return movies.where((m) => m.genres.contains(genre)).toList();
  }

  BrowseLoaded copyWith({
    List<MovieModel>? movies,
    List<String>? genres,
    int? selectedGenreIndex,
  }) {
    return BrowseLoaded(
      movies: movies ?? this.movies,
      genres: genres ?? this.genres,
      selectedGenreIndex: selectedGenreIndex ?? this.selectedGenreIndex,
    );
  }
}

class BrowseError extends BrowseState {
  final String message;
  BrowseError(this.message);
}
