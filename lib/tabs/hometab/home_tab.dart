import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/auth/api_service.dart';
import 'package:movies/tabs/hometab/action_view.dart';
import 'package:movies/models/movie_model.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final PageController _pageController = PageController(viewportFraction: 0.6);
  int selectedIndex = 0;
  List<MovieModel> movies = [];
  List<MovieModel> suggestions = [];
  bool isLoading = true;
  bool isSuggestionsLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    try {
      final fetchedMovies = await MovieService.fetchMovies();
      if (!mounted) return;
      setState(() {
        movies = fetchedMovies;
        isLoading = false;
      });
      if (movies.isNotEmpty) {
        _loadSuggestions(movies[0].id);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        movies = [];
        isLoading = false;
      });
    }
  }

  Future<void> _loadSuggestions(int movieId) async {
    setState(() {
      isSuggestionsLoading = true;
    });
    try {
      final fetchedSuggestions = await MovieService.fetchMovieSuggestions(
        movieId,
      );
      if (!mounted) return;
      setState(() {
        suggestions = fetchedSuggestions;
        isSuggestionsLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        suggestions = [];
        isSuggestionsLoading = false;
      });
    }
  }

  Widget _buildNetworkImage(
    String? url, {
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    if (url == null || url.isEmpty) {
      return Image.asset(
        "assets/images/no_image.png",
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
      );
    }
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          "assets/images/no_image.png",
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: AppTheme.black,
      body: Stack(
        children: [
          if (movies.isNotEmpty)
            Positioned.fill(
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildNetworkImage(
                      movies[selectedIndex].mediumCoverImage,
                      width: screenSize.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(flex: 1, child: Container(color: AppTheme.black)),
                ],
              ),
            ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset("assets/images/ava.png"),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: screenSize.height * 0.7,
              child: PageView.builder(
                controller: _pageController,
                itemCount: movies.length,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                    if (movies.isNotEmpty) {}
                  });
                },
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double scale = 1.0;
                      double opacity = 0.4;
                      if (_pageController.position.haveDimensions) {
                        final double page =
                            _pageController.page ?? index.toDouble();
                        final double diff = (page - index).abs();
                        scale = (1 - (diff * 0.3)).clamp(0.8, 1.0);
                        opacity = (1 - (diff * 0.6)).clamp(0.3, 1.0);
                      }
                      return Center(
                        child: Transform.scale(
                          scale: scale,
                          child: Opacity(
                            opacity: opacity,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: _buildNetworkImage(
                                    movie.mediumCoverImage,
                                    width: screenSize.width * 0.55,
                                    height: screenSize.height * 0.4,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme.black,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          movie.rating.toString(),
                                          style: TextStyle(
                                            color: AppTheme.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.star,
                                          color: AppTheme.primary,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 35),
                  child: Image.asset(
                    "assets/images/watch.png",
                    height: screenSize.height * 0.14,
                    fit: BoxFit.contain,
                  ),
                ),
                if (isSuggestionsLoading)
                  CircularProgressIndicator(color: AppTheme.primary)
                else if (suggestions.isNotEmpty)
                  ActionView(movies: suggestions),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
