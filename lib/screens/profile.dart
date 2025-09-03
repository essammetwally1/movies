import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/components/custom_text_form_feild.dart';

class ProfileUpdateScreen extends StatelessWidget {
  static const String routeName = '/profileupdate';
  const ProfileUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick Avatar')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/avatar/avatar1.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                hintText: 'User Name',
                iconPathName: 'profile',
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                hintText: '01000000000',
                iconPathName: 'phone',
              ),
              SizedBox(height: 16),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Reset Password',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: AppTheme.white),
                ),
              ),
              Spacer(),
              CustomElevatedButton(
                textElevatedButton: 'Delete Account',
                onPressed: () {},
                color: AppTheme.red,
              ),
              SizedBox(height: 16),
              CustomElevatedButton(
                textElevatedButton: 'Update Data',
                onPressed: () {},
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
