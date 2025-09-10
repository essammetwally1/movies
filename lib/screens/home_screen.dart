import 'package:flutter/material.dart';
import 'package:movies/components/navbar_icon.dart';
import 'package:movies/tabs/hometab/home_tab.dart';
import 'package:movies/tabs/profile_tab.dart';

import '../tabs/search_tab.dart';
import '../tabs/browse_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> tabs = const [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileTap(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],

      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 12, right: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),

          child: BottomNavigationBar(
            backgroundColor: const Color(0xFF2C2C2C),
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: NavbarIcon(iconName: 'home'),
                activeIcon: NavbarIcon(iconName: 'homeActive'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: NavbarIcon(iconName: 'search'),
                activeIcon: NavbarIcon(iconName: 'searchActive'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: NavbarIcon(iconName: 'explore'),
                activeIcon: NavbarIcon(iconName: 'exploreActive'),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: NavbarIcon(iconName: 'profile'),
                activeIcon: NavbarIcon(iconName: 'profileActive'),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
