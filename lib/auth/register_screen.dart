import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies/components/avatar_section.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/components/custom_text_form_feild.dart';
import 'package:movies/components/localization_switch.dart';
import 'package:movies/models/user_model.dart';
import 'package:movies/provider/user_provider.dart';
import 'package:movies/screens/profile.dart';
import 'package:http/http.dart' as http;
import 'package:movies/utilis.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int avatarIndex = 1;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: globalKey,
              child: Column(
                children: [
                  AvatarSection(selectAvatar: selectAvatar),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    controller: nameController,
                    hintText: 'Name',
                    iconPathName: 'name',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 16),

                  CustomTextFormField(
                    controller: emailController,
                    hintText: 'Email',
                    iconPathName: 'mail',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter e-mail';
                      } else if (!value.contains('@gmail.com')) {
                        return 'Enter valid e-mail';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 16),

                  CustomTextFormField(
                    controller: passwordController,
                    hintText: 'Password',
                    iconPathName: 'password',
                    isPassword: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter password';
                      } else if (value.length < 9) {
                        return 'Password must be at least 9 characters';
                      } else if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
                        return 'Password must contain lowercase letter';
                      } else if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                        return 'Password must contain uppercase letter';
                      } else if (!RegExp(r'^(?=.*[0-9])').hasMatch(value)) {
                        return 'Password must contain number';
                      } else if (!RegExp(
                        r'^(?=.*[!@#$%^&*(),.?":{}|<>])',
                      ).hasMatch(value)) {
                        return 'Password must contain special character';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 16),

                  CustomTextFormField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    iconPathName: 'password',
                    isPassword: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter confirm password';
                      } else if (value != passwordController.text) {
                        return 'Passwords do not match';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 16),

                  CustomTextFormField(
                    controller: phoneController,
                    hintText: 'Phone Number',
                    iconPathName: 'phone',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter phone number';
                      } else if (!value.startsWith('+2')) {
                        return 'Phone number must start with +2';
                      } else if (!RegExp(r'^\+2[0-9]{11}$').hasMatch(value)) {
                        return 'Enter valid phone number (+2 followed by 11 digits)';
                      } else {
                        return null;
                      }
                    },
                  ),

                  SizedBox(height: 16),

                  CustomElevatedButton(
                    isLoading: isLoading,
                    textElevatedButton: 'Create Account',
                    onPressed: register,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already Have Account ?',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Login'),
                      ),
                    ],
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

  void selectAvatar(int index) {
    avatarIndex = index;
  }

  Future<void> registerUser() async {
    const String apiUrl = 'https://route-movie-apis.vercel.app/auth/register';

    final Map<String, dynamic> requestBody = {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "confirmPassword": confirmPasswordController.text,
      "phone": phoneController.text,
      "avaterId": avatarIndex,
    };

    try {
      setState(() {
        isLoading = false;
      });
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        log('Registration successful: ${responseData}');
        final user = UserModel.fromJson(responseData['data']);
        Provider.of<UserProvider>(
          context,
          listen: false,
        ).updateCurrentUser(user);
        Navigator.of(context).pushNamed(ProfileUpdateScreen.routeName);
      } else {
        final errorData = jsonDecode(response.body);
        log('Registration failed: ${errorData['message']}');
        Utilis.showErrorMessage(errorData['message'] ?? 'Registration failed');
      }
    } catch (error) {
      log('Error during registration: $error');
      Utilis.showErrorMessage('Network error. Please try again.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void register() {
    if (globalKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        globalKey.currentState!.validate();
        return;
      }

      registerUser();
    }
  }
}
