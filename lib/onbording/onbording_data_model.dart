class OnbordingDataModel {
  String imageBath;
  String description;
  String title;
  bool isLast;
  bool isFirst;

  OnbordingDataModel({
    required this.title,
    required this.description,
    required this.imageBath,
    this.isLast = false,
    this.isFirst = false,
  });

  static List<OnbordingDataModel> onboringList = [
    OnbordingDataModel(
      title: "   Find Your Next\n Favorite Movie Here",
      description:
          "Get access to a huge library of movies to suit all tastes. You will surely like it.",
      imageBath: "onbording",
      isFirst: true,
    ),
    OnbordingDataModel(
      title: "Discover Movies",
      description:
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease",
      imageBath: "onbording2",
    ),
    OnbordingDataModel(
      title: "Explore All Genres",
      description:
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day",
      imageBath: "onbording3",
    ),
    OnbordingDataModel(
      title: "Create Watchlists",
      description:
          "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
      imageBath: "onbording4",
    ),
    OnbordingDataModel(
      title: "Rate, Review,and Learn",
      description:
          "Share your thoughts on the movies you've watched Dive deep into film details and help others discover great movies with your reviews",
      imageBath: "onbording5",
    ),
    OnbordingDataModel(
      title: "Start Watching Now",
      description: "",
      imageBath: "onbording6",
      isLast: true,
    ),
  ];
}
