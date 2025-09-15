import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/components/movie_shoots_section.dart';
import 'package:movies/components/rate_item.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/auth/api_service.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const String routeName = '/moviedetails';

  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  List<MovieModel> similarMovies = [];
  bool isSimilarLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final movie = ModalRoute.of(context)!.settings.arguments as MovieModel;
    _loadSimilarMovies(movie.id);
  }

  Future<void> _loadSimilarMovies(int movieId) async {
    try {
      final fetched = await MovieService.fetchMovieSuggestions(movieId);
      if (!mounted) return;
      setState(() {
        similarMovies = fetched;
        isSimilarLoading = false;
      });
    } catch (e) {
      setState(() {
        similarMovies = [];
        isSimilarLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as MovieModel;
    final Size screenSize = MediaQuery.sizeOf(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  child: Image.network(
                    movie.image,
                    width: double.infinity,
                    height: screenSize.height * .7,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppTheme.white,
                      height: screenSize.height * .7,
                      child: Icon(
                        Icons.broken_image,
                        color: AppTheme.white,
                        size: 60,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 25,
                  right: 20,
                  left: 20,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: SvgPicture.asset('assets/icons/arrow.svg'),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset('assets/icons/save.svg'),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 20,
                  left: 20,
                  child: Center(
                    child: Text(
                      movie.title,
                      style: textTheme.labelLarge,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  CustomElevatedButton(
                    textElevatedButton: 'Watch',
                    onPressed: () {},
                    color: AppTheme.red,
                    textStyle: textTheme.labelLarge,
                  ),
                  const SizedBox(height: 16),

                  // بيانات سريعة
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RateItem(iconePath: 'love', rate: movie.id.toString()),
                      RateItem(iconePath: 'time', rate: "${movie.runtime} min"),
                      RateItem(
                        iconePath: 'star',
                        rate: movie.rating.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Text('Screen Shots', style: textTheme.labelLarge),
                  const SizedBox(height: 12),
                  MovieShotsSection(),

                  const SizedBox(height: 25),

                  Text('Similar', style: textTheme.labelLarge),
                  const SizedBox(height: 12),
                  if (isSimilarLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (similarMovies.isEmpty)
                    const Text("No similar movies found")
                  else
                    SizedBox(
                      height: (screenSize.height * 0.36 * 2),
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.6,
                        children: similarMovies
                            .map(
                              (m) => ImageDisplayer(
                                movieImage: m.image,
                                rating: m.rating,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  const SizedBox(height: 12),

                  Text('Summary', style: textTheme.labelLarge),
                  const SizedBox(height: 12),
                  Text(movie.summary, style: textTheme.titleMedium),
                  const SizedBox(height: 20),

                  Text('Cast', style: textTheme.labelLarge),
                  const SizedBox(height: 12),
                  if (movie.cast.isEmpty)
                    const Text(
                      "No cast info available",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.red,
                      ),
                    )
                  else
                    Column(
                      children: movie.cast.map((geners) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.grey,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  geners.imageUrl,
                                  width: 80,
                                  height: 70,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        width: 80,
                                        height: 70,
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.error,
                                          color: Colors.grey,
                                        ),
                                      ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      geners.name,
                                      style: textTheme.titleLarge!.copyWith(
                                        color: AppTheme.white,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      geners.characterName,
                                      style: textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 20),

                  Text('Genres', style: textTheme.labelLarge),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: movie.genres
                        .map(
                          (g) => Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(g, style: textTheme.titleMedium),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageDisplayer extends StatelessWidget {
  final String movieImage;
  final double rating;

  const ImageDisplayer({
    super.key,
    required this.movieImage,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            movieImage,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: AppTheme.white,
              child: const Icon(Icons.broken_image, color: Colors.white),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    rating.toString(),
                    style: const TextStyle(
                      color: AppTheme.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 3),
                  const Icon(Icons.star, color: AppTheme.primary, size: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
