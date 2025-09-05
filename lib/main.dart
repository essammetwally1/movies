import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/auth/forgot_password.dart';
import 'package:movies/auth/login_screen.dart';
import 'package:movies/auth/register_screen.dart';
import 'package:movies/onbording/onbording.dart';
import 'package:movies/provider/user_provider.dart';
import 'package:movies/screens/home_screen.dart';
import 'package:movies/screens/movie_details_screen.dart';
import 'package:movies/screens/profile.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],

      child: MoviesApp(),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
        ProfileUpdateScreen.routeName: (context) => ProfileUpdateScreen(),
        MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),

        Onbording.routeName: (context) => Onbording(),
      },
      initialRoute: MovieDetailsScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.dartTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
