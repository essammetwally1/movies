import 'package:flutter/material.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/components/custom_text_form_feild.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgotpassword';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: globalKey,
              child: Column(
                children: [
                  Image.asset('assets/forgotpassword.png'),
                  SizedBox(height: 16),

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
                  CustomElevatedButton(
                    textElevatedButton: 'Verify Email',
                    onPressed: verifyEmail,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void verifyEmail() {
    if (globalKey.currentState!.validate()) {
      Navigator.of(context).pop();
    }
  }
}
