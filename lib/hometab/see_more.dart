import 'package:flutter/material.dart';
import 'package:movies/auth/api_service.dart';
import 'package:movies/app_theme.dart';

class SeeMoreScreen extends StatefulWidget {
  const SeeMoreScreen({Key? key}) : super(key: key);

  @override
  State<SeeMoreScreen> createState() => _SeeMoreScreenState();
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  List<dynamic> movies = [];
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
        title: Text("All Movies"),
        backgroundColor: AppTheme.black,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: movies.length + (isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= movies.length) {
                  return Center(
                    child: CircularProgressIndicator(color: AppTheme.primary),
                  );
                }

                final movie = movies[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        movie["medium_cover_image"] ?? "",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            "https://static.vecteezy.com/system/resources/previews/022/059/000/original/no-image-available-icon-vector.jpg",
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                movie["rating"].toString(),
                                style: TextStyle(
                                  color: AppTheme.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 3),
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
                  ),
                );
              },
            ),
    );
  }
}
