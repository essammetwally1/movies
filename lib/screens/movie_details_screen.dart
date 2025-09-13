import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/components/movie_shoots_section.dart';
import 'package:movies/components/rate_item.dart';
import 'package:movies/models/character_model.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = '/moviedetails';
  MovieDetailsScreen({super.key});

  final List<Character> characters = [
    Character(
      imagePath: 'assets/images/film1.png',
      characterName: 'Actor Name',
      characterDescription:
          'Genius, billionaire, playboy, philanthropist. The iconic Iron Man.',
    ),
    Character(
      imagePath: 'assets/images/film2.png',
      characterName: 'Actor Name',
      characterDescription:
          'Genius, billionaire, playboy, philanthropist. The iconic Iron Man.',
    ),
    Character(
      imagePath: 'assets/images/film3.png',
      characterName: 'Actor Name',
      characterDescription:
          'Genius, billionaire, playboy, philanthropist. The iconic Iron Man.',
    ),
    Character(
      imagePath: 'assets/images/film4.png',
      characterName: 'Actor Name',
      characterDescription:
          'Genius, billionaire, playboy, philanthropist. The iconic Iron Man.',
    ),
  ];
  final List<String> genres = [
    'Action',
    'Sci-Fi',
    'Adventure',
    'Fantasy',
    'Horror',
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Image.asset(
                    'assets/images/film1.png',
                    width: double.infinity,
                    height: screenSize.height * .7,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 20,
                  right: 20,
                  left: 20,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
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

                Positioned.fill(
                  child: Center(
                    child: Image.asset(
                      'assets/images/video.png',
                      width: screenSize.width * .2,
                      height: screenSize.height * .2,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 50,
                  right: 20,
                  left: 20,
                  child: Center(
                    child: Text(
                      'Doctor Strange in the Multiverse of Madness',
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
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.white.withValues(alpha: .2),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CustomElevatedButton(
                      textElevatedButton: 'Watch',
                      onPressed: () {},
                      color: AppTheme.red,
                      textStyle: textTheme.labelLarge,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RateItem(iconePath: 'love', rate: '99'),
                      RateItem(iconePath: 'time', rate: '120'),
                      RateItem(iconePath: 'star', rate: '10'),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Text('Screen Shots', style: textTheme.labelLarge),
                  const SizedBox(height: 12),
                  MovieShotsSection(),
                  const SizedBox(height: 25),

                  Text('Similar', style: textTheme.labelLarge),
                  SizedBox(
                    height: (screenSize.height * 0.36 * 2),
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.6,
                      children: List.generate(4, (index) {
                        return SizedBox(
                          height: screenSize.height * 0.4,
                          child: ImageDisplayer(
                            movieImage: 'assets/images/film${index + 1}.png',
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text('Summary', style: textTheme.labelLarge),
                  const SizedBox(height: 12),
                  Text(
                    'Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346',
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),

                  Text('Cast', style: textTheme.labelLarge),
                  SizedBox(
                    height: characters.length * 110,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: characters.length,
                      itemBuilder: (context, index) {
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
                                child: Image.asset(
                                  characters[index].imagePath,
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 70,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 80,
                                      height: 70,
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.error,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      characters[index].characterName,
                                      style: textTheme.titleLarge!.copyWith(
                                        color: AppTheme.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      characters[index].characterDescription,
                                      style: textTheme.titleSmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text('Genres', style: textTheme.labelLarge),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 2.0,
                        ),
                    itemCount: genres.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            genres[index],
                            style: textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
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
  const ImageDisplayer({super.key, required this.movieImage});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(movieImage, fit: BoxFit.fill),
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
                    '9.0',
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
