import 'package:flutter/material.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/components/custom_text_form_feild.dart';
import 'package:movies/utilis.dart';

class ResetPasswordBottomSheet extends StatefulWidget {
  const ResetPasswordBottomSheet({super.key});

  @override
  State<ResetPasswordBottomSheet> createState() =>
      _ResetPasswordBottomSheetState();
}

class _ResetPasswordBottomSheetState extends State<ResetPasswordBottomSheet> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: globalKey,
        child: Column(
          children: [
            SizedBox(height: 16),

            CustomTextFormField(
              controller: oldPasswordController,
              isPassword: true,
              hintText: 'Old password',
              iconPathName: 'password',
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
              isPassword: true,
              controller: newPasswordController,
              hintText: 'New password',
              iconPathName: 'password',
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
              isPassword: true,
              controller: confirmNewPasswordController,
              hintText: 'Confirm new password',
              iconPathName: 'password',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter confirm password';
                } else if (value != newPasswordController.text) {
                  return 'Passwords do not match';
                } else {
                  return null;
                }
              },
            ),

            SizedBox(height: 16),
            CustomElevatedButton(
              textElevatedButton: 'Reset Password',
              onPressed: resetPassword,
            ),
          ],
        ),
      ),
    );
  }

  void resetPassword() {
    if (globalKey.currentState!.validate()) {
      Utilis.showSuccessMessage('Success reset password');
    }
  }
}
