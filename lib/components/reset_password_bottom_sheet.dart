import 'package:flutter/material.dart';
import 'package:movies/auth/api_service.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/components/custom_text_form_feild.dart';
import 'package:movies/models/user_model.dart';
import 'package:movies/provider/user_provider.dart';
import 'package:movies/utilis.dart';
import 'package:provider/provider.dart';

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
  bool isLoading = false;

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: globalKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),

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
                const SizedBox(height: 16),
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

                const SizedBox(height: 16),
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

                const SizedBox(height: 16),
                CustomElevatedButton(
                  textElevatedButton: 'Reset Password',
                  onPressed: resetPassword,
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    final UserModel? userModel = Provider.of<UserProvider>(
      context,
      listen: false,
    ).currentUser;

    if (userModel == null ||
        userModel.token == null ||
        userModel.token!.isEmpty) {
      Utilis.showErrorMessage('User not logged in or token missing');
      return;
    }

    if (globalKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final result = await AuthApiService.resetPassword(
          oldPassword: oldPasswordController.text,
          newPassword: newPasswordController.text,
          token: userModel.token!,
        );

        if (result['success'] == true) {
          Utilis.showSuccessMessage(result['message']);
          Navigator.of(context).pop();
        }
      } catch (error) {
        Utilis.showErrorMessage(error.toString());
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
