import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/components/custom_text_form_feild.dart';
import 'package:movies/components/localization_switch.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/loginlogo.png'),
          CustomTextFormField(hintText: 'Email', iconPathName: 'mail'),
          CustomTextFormField(
            hintText: 'Password',
            iconPathName: 'password',
            isPassword: true,
          ),
          Align(
            alignment: Alignment.centerRight,

            child: TextButton(
              onPressed: () {},
              child: Text('Forget Password ?'),
            ),
          ),
          CustomElevatedButton(textElevatedButton: 'Login', onPressed: () {}),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don’t Have Account ?', style: textTheme.titleSmall),
              TextButton(onPressed: () {}, child: Text('Create One')),
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
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: AppTheme.primary),
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

          CustomElevatedButton(
            textElevatedButton: 'Login With Google',
            onPressed: () {},
          ),
          LocalizationSwitch(),
        ],
      ),
    );
  }
}
