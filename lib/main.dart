

import 'package:movies/app_theme.dart';
import 'package:movies/auth/forgot_password.dart';
import 'package:movies/auth/login_screen.dart';
import 'package:movies/auth/register_screen.dart';
import 'package:movies/screens/home_screen.dart';
<<<<<<< HEAD
import 'package:movies/screens/profile.dart';
=======
>>>>>>> c4e52f8432fae1d98dc254b5afb696d422df4665

void main() {
  runApp(MoviesApp());
}

class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
<<<<<<< HEAD
        ProfileUpdateScreen.routeName: (context) => ProfileUpdateScreen(),
=======
>>>>>>> c4e52f8432fae1d98dc254b5afb696d422df4665
      },
      initialRoute: LoginScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.dartTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
