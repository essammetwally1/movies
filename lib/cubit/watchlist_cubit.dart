import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/models/movie_model.dart';

class WatchlistCubit extends Cubit<List<MovieModel>> {
  WatchlistCubit() : super([]);

  void toggleMovie(MovieModel movie) {
    if (isInWatchlist(movie)) {
      emit(state.where((m) => m.id != movie.id).toList()); // remove
    } else {
      emit([...state, movie]); // add
    }
  }

  bool isInWatchlist(MovieModel movie) {
    return state.any((m) => m.id == movie.id);
  }
}
