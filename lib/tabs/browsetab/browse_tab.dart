import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/tabs/browsetab/tab_item.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/auth/api_service.dart';

class BrowseTab extends StatefulWidget {
  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  int selectedTab = 0;
  late Future<List<MovieModel>> moviesFuture;

  @override
  void initState() {
    super.initState();
    moviesFuture = MovieService.fetchMovies();
  }

  List<String> extractGenres(List<MovieModel> movies) {
    final genreSet = <String>{};
    for (var movie in movies) {
      genreSet.addAll(movie.genres);
    }
    return genreSet.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<MovieModel>>(
        future: moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final movies = snapshot.data ?? [];
          final genreSet = <String>{};
          for (var movie in movies) {
            genreSet.addAll(movie.genres);
          }
          final genres = genreSet.toList();
          if (genres.isEmpty) {
            return Center(child: Text('No genres found'));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(genres.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = index;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 12, right: 2),
                        child: TabItem(
                          isSelected: selectedTab == index,
                          label: genres[index],
                          selectedForegroundColor: AppTheme.black,
                          selectedbackgroundColor: AppTheme.primary,
                          unselectedForegroundColor: AppTheme.primary,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    final genre = genres[selectedTab];
                    final genreMovies = movies
                        .where((movie) => movie.genres.contains(genre))
                        .toList();
                    if (genreMovies.isEmpty) {
                      return Center(child: Text("No movies for $genre"));
                    }
                    return GridView.builder(
                      padding: EdgeInsets.all(6),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 11,
                        mainAxisSpacing: 11,
                      ),
                      itemCount: genreMovies.length,
                      itemBuilder: (context, index) {
                        final movie = genreMovies[index];
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                movie.image,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: AppTheme.white,
                                      child: Icon(
                                        Icons.error,
                                        color: AppTheme.red,
                                      ),
                                    ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      movie.rating.toString(),
                                      style: TextStyle(
                                        color: AppTheme.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Icon(
                                      Icons.star,
                                      color: AppTheme.primary,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
