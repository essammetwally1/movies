import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/components/movie_shoots_section.dart';
import 'package:movies/components/rate_item.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = '/moviedetails';
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.only(
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
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.white.withValues(alpha: .2),
                        blurRadius: 20,
                        offset: Offset(0, -10),
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
                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RateItem(iconePath: 'love', rate: '99'),
                    RateItem(iconePath: 'time', rate: '120'),
                    RateItem(iconePath: 'star', rate: '10'),
                  ],
                ),
                SizedBox(height: 10),
                Text('Screen Shots', style: textTheme.labelLarge),
                SizedBox(height: 10),
                MovieShotsSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
