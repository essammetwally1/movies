import 'package:movies/models/movie_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<MovieModel> movies;
  final String query;

  SearchLoaded({required this.movies, required this.query});
}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});
}
