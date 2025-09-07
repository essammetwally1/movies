import 'package:flutter/material.dart';
import 'package:movies/hometab/home_tab.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeTab());
  }
}
