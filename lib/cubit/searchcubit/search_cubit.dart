import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/auth/api_service.dart';
import 'package:movies/cubit/searchcubit/search_state.dart';
import 'package:movies/models/movie_model.dart';

// States

// Cubit
class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  List<MovieModel> _allMovies = [];
  String _currentQuery = '';

  // Load all movies first
  Future<void> loadAllMovies() async {
    emit(SearchLoading());

    try {
      _allMovies = await MovieService.fetchMovies();
      emit(SearchLoaded(movies: _allMovies, query: _currentQuery));
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }

  // Search movies by title
  void searchMovies(String query) {
    _currentQuery = query.trim();

    if (_currentQuery.isEmpty) {
      emit(SearchLoaded(movies: _allMovies, query: _currentQuery));
      return;
    }

    if (_allMovies.isEmpty) {
      emit(SearchError(message: 'No movies loaded. Please try again.'));
      return;
    }

    // Filter movies by title (case insensitive)
    final filteredMovies = _allMovies.where((movie) {
      return movie.title.toLowerCase().contains(_currentQuery.toLowerCase());
    }).toList();

    emit(SearchLoaded(movies: filteredMovies, query: _currentQuery));
  }

  // Clear search
  void clearSearch() {
    _currentQuery = '';
    emit(SearchLoaded(movies: _allMovies, query: _currentQuery));
  }

  // Get current query
  String get currentQuery => _currentQuery;
}
