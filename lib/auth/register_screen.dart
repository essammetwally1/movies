import 'package:flutter/material.dart';
import 'package:movies/components/avatar_section.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/components/custom_text_form_feild.dart';
import 'package:movies/components/localization_switch.dart';
import 'package:movies/screens/profile.dart';

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
  TextEditingController confirmPasswordController =
      TextEditingController(); // Add this controller
  TextEditingController phoneController = TextEditingController();

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
                  AvatarSection(),
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
                        return 'Enter valid password -more than 9 letters-';
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
                      } else if (value.length < 11) {
                        return 'Enter valid phone number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 16),

                  CustomElevatedButton(
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

  void register() {
    if (globalKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        globalKey.currentState!.validate();
        return;
      }

      Navigator.of(context).pushNamed(ProfileUpdateScreen.routeName);
    }
  }
}
