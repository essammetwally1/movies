import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/auth/forgot_password.dart';
import 'package:movies/auth/register_screen.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/components/custom_text_form_feild.dart';
import 'package:movies/components/localization_switch.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/user_model.dart';
import 'package:movies/provider/user_provider.dart';
import 'package:movies/screens/profile.dart';
import 'package:movies/utilis.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Image.asset('assets/loginlogo.png'),
                  SizedBox(height: 70),

                  CustomTextFormField(
                    hintText: 'Email',
                    iconPathName: 'mail',
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email';
                      } else if (!value.contains('@gmail.com')) {
                        return 'Enter Valid Email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 16),

                  CustomTextFormField(
                    hintText: 'Password',
                    iconPathName: 'password',
                    controller: passwordController,
                    isPassword: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter password';
                      } else if (value.length < 9) {
                        return 'Enter valid password -more than 9 letters-';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerRight,

                    child: TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushNamed(ForgotPasswordScreen.routeName);
                      },
                      child: Text('Forget Password ?'),
                    ),
                  ),
                  SizedBox(height: 16),

                  CustomElevatedButton(
                    textElevatedButton: 'Login',
                    isLoading: isLoading,

                    onPressed: login,
                  ),
                  SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don’t Have Account ?', style: textTheme.titleSmall),
                      TextButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushNamed(RegisterScreen.routeName);
                        },
                        child: Text('Create One'),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          indent: 50,
                          color: AppTheme.primary,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'OR',
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(color: AppTheme.primary),
                        ),
                      ),

                      Expanded(
                        child: Divider(
                          thickness: 2,
                          endIndent: 50,
                          color: AppTheme.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  CustomElevatedButton(
                    textElevatedButton: 'Login With Google',
                    onPressed: () {},
                  ),
                  SizedBox(height: 16),

                  LocalizationSwitch(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<UserModel?> getUserProfile(String token) async {
    const String userProfileUrl = 'https://route-movie-apis.vercel.app/profile';

    try {
      final response = await http.get(
        Uri.parse(userProfileUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      log('User profile response status: ${response.statusCode}');
      log('User profile response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['data'] != null) {
          final user = UserModel.fromJson(responseData['data']);
          log('User profile loaded: ${user.name}');
          return user;
        } else {
          log('Profile response has no data');
        }
      } else {
        log('Failed to fetch profile: ${response.statusCode}');
        log('Response body: ${response.body}');
      }
      return null;
    } catch (error, st) {
      log('Error fetching profile: $error\n$st');
      return null;
    }
  }

  Future<void> loginUser() async {
    const String apiUrl = 'https://route-movie-apis.vercel.app/auth/login';

    final Map<String, dynamic> requestBody = {
      "email": emailController.text.trim(),
      "password": passwordController.text,
    };

    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.body.isEmpty) {
        Utilis.showErrorMessage('Server returned empty response');
        return;
      }

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final String? token = responseData['data'] as String?;
        final String? message = responseData['message'] as String?;

        if (token == null || token.isEmpty) {
          Utilis.showErrorMessage('No token received');
          return;
        }

        // Save token for future
        // await TokenStorage.save(token);

        // Now fetch profile
        final UserModel? user = await getUserProfile(token);
        user!.printInfo();

        if (user != null) {
          Provider.of<UserProvider>(
            context,
            listen: false,
          ).updateCurrentUser(user);

          Utilis.showSuccessMessage(message ?? 'Login successful');
          Navigator.of(
            context,
          ).pushReplacementNamed(ProfileUpdateScreen.routeName);
        } else {
          Utilis.showErrorMessage('Failed to load user profile');
        }
      } else {
        final errorMessage =
            responseData['message'] ??
            'Login failed. Please check your credentials.';
        log('Login failed: $errorMessage');
        Utilis.showErrorMessage(errorMessage);
      }
    } on FormatException catch (e) {
      log('JSON parsing error: $e');
      Utilis.showErrorMessage(
        'Server response format error. Please try again.',
      );
    } on http.ClientException catch (e) {
      log('Network error: $e');
      Utilis.showErrorMessage('Network error: ${e.message}');
    } catch (error) {
      log('Error during login: $error');
      Utilis.showErrorMessage('An unexpected error occurred');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void login() {
    if (globalKey.currentState!.validate()) {
      loginUser();
    }
  }
}
