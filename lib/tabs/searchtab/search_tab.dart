import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/components/custom_text_form_feild.dart';
import 'package:movies/components/image_displayer.dart';
import 'package:movies/cubit/searchcubit/search_cubit.dart';
import 'package:movies/cubit/searchcubit/search_state.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/screens/movie_details_screen.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController controller = TextEditingController();

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..loadAllMovies(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Search Field
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    final cubit = context.read<SearchCubit>();

                    return CustomTextFormField(
                      hintText: 'Search by movie title...',
                      iconPathName: 'search',
                      controller: controller,
                      onChange: (value) {
                        cubit.searchMovies(value);
                      },
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Search Results
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      return _buildSearchResults(state, context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(SearchState state, BuildContext context) {
    if (state is SearchLoading) {
      return _buildLoadingState();
    } else if (state is SearchError) {
      return _buildErrorState(state.message, context);
    } else if (state is SearchLoaded) {
      return _buildResultsGrid(state.movies, state.query, context);
    } else {
      return _buildInitialState(context);
    }
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorState(String message, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppTheme.red),
          const SizedBox(height: 16),
          Text(
            'Oops!',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppTheme.white),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: AppTheme.grey),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<SearchCubit>().loadAllMovies();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.blue,
              foregroundColor: AppTheme.white,
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState(context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: AppTheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text('Search for movies', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            'Type in the search bar to find your favorite movies',
            style: textTheme.titleMedium?.copyWith(color: AppTheme.primary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildResultsGrid(
    List<MovieModel> movies,
    String query,
    BuildContext context,
  ) {
    if (query.isEmpty) {
      return _buildInitialState(context);
    }

    if (movies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.movie_filter,
              size: 64,
              color: AppTheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No movies found',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppTheme.white),
            ),
            const SizedBox(height: 8),
            Text(
              'Try searching with different keywords',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppTheme.primary),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Results count
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            'Found ${movies.length} movie${movies.length == 1 ? '' : 's'} for "$query"',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),

        // Movies Grid (2 columns)
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return _buildMovieGridItem(movies[index], context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMovieGridItem(MovieModel movie, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToMovieDetails(movie, context);
      },
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ImageDisplayer(movieImage: movie.image, rating: movie.rating),
        ),
      ),
    );
  }

  void _navigateToMovieDetails(MovieModel movie, BuildContext context) {
    Navigator.pushNamed(
      context,
      MovieDetailsScreen.routeName,
      arguments: movie,
    );
  }
}
