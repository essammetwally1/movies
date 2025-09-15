import 'package:flutter/material.dart';
import 'package:movies/auth/api_service.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/components/image_displayer.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/screens/movie_details_screen.dart' hide ImageDisplayer;

class SeeMoreScreen extends StatefulWidget {
  static const String routeName = '/seemorescreen';
  const SeeMoreScreen({Key? key}) : super(key: key);

  @override
  State<SeeMoreScreen> createState() => _SeeMoreScreenState();
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  List<MovieModel> movies = [];
  bool isLoading = true;
  bool isLoadingMore = false;
  int currentPage = 1;
  bool hasMore = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMovies();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoadingMore &&
          hasMore) {
        _loadMoreMovies();
      }
    });
  }

  Future<void> _loadMovies() async {
    try {
      final fetchedMovies = await MovieService.fetchMovies(page: currentPage);
      setState(() {
        movies = fetchedMovies;
        isLoading = false;
        hasMore = fetchedMovies.isNotEmpty;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadMoreMovies() async {
    setState(() {
      isLoadingMore = true;
    });
    try {
      final nextPage = currentPage + 1;
      final fetchedMovies = await MovieService.fetchMovies(page: nextPage);

      setState(() {
        currentPage = nextPage;
        movies.addAll(fetchedMovies);
        isLoadingMore = false;
        hasMore = fetchedMovies.isNotEmpty;
      });
    } catch (e) {
      print("Error loading more: $e");
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
      appBar: AppBar(
        title: const Text("All Movies"),
        backgroundColor: AppTheme.black,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: movies.length + (isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= movies.length) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppTheme.primary),
                  );
                }

                final movie = movies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MovieDetailsScreen.routeName,
                      arguments: movie,
                    );
                  },
                  child: ImageDisplayer(movie: movie),
                );
              },
            ),
    );
  }
}
