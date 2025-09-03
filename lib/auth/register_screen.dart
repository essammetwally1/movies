import 'package:flutter/material.dart';
import 'package:movies/components/avatar_section.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/components/custom_text_form_feild.dart';
import 'package:movies/components/localization_switch.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = '/register';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                AvatarSection(),
                SizedBox(height: 16),
                CustomTextFormField(hintText: 'Name', iconPathName: 'name'),
                SizedBox(height: 16),

                CustomTextFormField(hintText: 'Email', iconPathName: 'mail'),
                SizedBox(height: 16),

                CustomTextFormField(
                  hintText: 'Password',
                  iconPathName: 'password',
                  isPassword: true,
                ),
                SizedBox(height: 16),

                CustomTextFormField(
                  hintText: 'Confirm Password',
                  iconPathName: 'password',
                  isPassword: true,
                ),
                SizedBox(height: 16),

                CustomTextFormField(
                  hintText: 'Phone Number',
                  iconPathName: 'phone',
                ),
                SizedBox(height: 16),

                CustomElevatedButton(
                  textElevatedButton: 'Create Account',
                  onPressed: () {},
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
    );
  }
}
