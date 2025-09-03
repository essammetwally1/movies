import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/auth/forgot_password.dart';
import 'package:movies/auth/register_screen.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/components/custom_text_form_feild.dart';
import 'package:movies/components/localization_switch.dart';
import 'package:movies/screens/profile.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Image.asset('assets/loginlogo.png'),
                SizedBox(height: 70),

                CustomTextFormField(hintText: 'Email', iconPathName: 'mail'),
                SizedBox(height: 16),

                CustomTextFormField(
                  hintText: 'Password',
                  iconPathName: 'password',
                  isPassword: true,
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
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamed(ProfileUpdateScreen.routeName);
                  },
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
    );
  }
}
