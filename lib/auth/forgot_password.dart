import 'package:flutter/material.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/components/custom_text_form_feild.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = '/forgotpassword';
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Image.asset('assets/forgotpassword.png'),
                SizedBox(height: 16),

                CustomTextFormField(hintText: 'Email', iconPathName: 'mail'),
                SizedBox(height: 16),
                CustomElevatedButton(
                  textElevatedButton: 'Verify Email',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
