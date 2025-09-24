import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/auth/api_service.dart';
import 'package:movies/cubit/browse/browse_state.dart';
import 'package:movies/models/movie_model.dart';

class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit() : super(BrowseLoading()) {
    loadMovies();
  }

  Future<void> loadMovies() async {
    try {
      final movies = await MovieService.fetchMovies();
      final genres = _extractGenres(movies);

      emit(BrowseLoaded(movies: movies, genres: genres));
    } catch (e) {
      emit(BrowseError(e.toString()));
    }
  }

  void selectGenre(int index) {
    if (state is BrowseLoaded) {
      final currentState = state as BrowseLoaded;
      emit(currentState.copyWith(selectedGenreIndex: index));
    }
  }

  List<String> _extractGenres(List<MovieModel> movies) {
    final genreSet = <String>{};
    for (var movie in movies) {
      genreSet.addAll(movie.genres);
    }
    return genreSet.toList();
  }
}
