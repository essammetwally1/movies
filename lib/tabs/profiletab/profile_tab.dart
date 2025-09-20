import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/auth/login_screen.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/provider/user_provider.dart';
import 'package:movies/tabs/profiletab/edit_profile.dart';
import 'package:movies/tabs/profiletab/watch_list_view.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              color: AppTheme.darkGrey,
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                'assets/avatar/avatar${userProvider.currentUser!.avaterId}.png',
                                fit: BoxFit.cover,
                                height: size.width * 0.3,
                                width: size.width * 0.3,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              userProvider.currentUser!.name,
                              style: textTheme.labelLarge,
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('12', style: textTheme.labelLarge),
                            const SizedBox(height: 8),
                            Text('Wish List', style: textTheme.labelLarge),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('12', style: textTheme.labelLarge),
                            const SizedBox(height: 8),
                            Text('History', style: textTheme.labelLarge),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
                          child: CustomElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditProfile(),
                                ),
                              );
                            },
                            textElevatedButton: 'Edit Profile',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: AppTheme.black,
                                  title: Text(
                                    "Confirm Logout",
                                    style: textTheme.labelLarge,
                                  ),
                                  content: Text(
                                    "Are you sure you want to log out?",
                                    style: textTheme.titleLarge!.copyWith(
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text(
                                        "Cancel",
                                        style: textTheme.titleLarge!.copyWith(
                                          color: AppTheme.primary,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Provider.of<UserProvider>(
                                          context,
                                          listen: false,
                                        ).currentUser = null;
                                        Navigator.of(
                                          context,
                                        ).pushReplacementNamed(
                                          LoginScreen.routeName,
                                        );
                                        log("User logged out");
                                      },
                                      child: Text(
                                        "Logout",
                                        style: textTheme.titleLarge!.copyWith(
                                          color: AppTheme.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            iconPath: 'exit',
                            color: AppTheme.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Container(
              color: AppTheme.darkGrey,
              child: TabBar(
                dividerColor: Colors.transparent,
                labelColor: AppTheme.primary,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3, color: AppTheme.primary),
                  insets: EdgeInsets.symmetric(horizontal: 0),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Column(
                    children: [
                      SvgPicture.asset('assets/icons/watchlist.svg'),
                      SizedBox(height: 5),
                      Text(
                        'Watch List',
                        style: textTheme.titleLarge!.copyWith(
                          color: AppTheme.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                  Column(
                    children: [
                      SvgPicture.asset('assets/icons/history.svg'),
                      SizedBox(height: 5),

                      Text(
                        'History',
                        style: textTheme.titleLarge!.copyWith(
                          color: AppTheme.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                children: [
                  WatchListView(),

                  Center(
                    child: Text(
                      "Your History goes here",
                      style: textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
