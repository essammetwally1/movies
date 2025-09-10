import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/auth/api_service.dart';
import 'package:movies/components/avatar_section.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/components/custom_text_form_feild.dart';
import 'package:movies/components/reset_password_bottom_sheet.dart';
import 'package:movies/models/user_model.dart';
import 'package:movies/provider/user_provider.dart';
import 'package:movies/utilis.dart';
import 'package:provider/provider.dart';

class ProfileTap extends StatefulWidget {
  static const String routeName = '/profileupdate';
  const ProfileTap({super.key});

  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {
  bool seeAvatarSection = false;
  bool isLoading = false;
  late int avatarIndex;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserModel? userModel = Provider.of<UserProvider>(context).currentUser;
    avatarIndex = userModel!.avaterId;
    return Scaffold(
      appBar: AppBar(title: Text('Pick Avatar')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      seeAvatarSection = true;
                    });
                  },
                  onDoubleTap: () {
                    setState(() {
                      seeAvatarSection = false;
                    });
                  },
                  child: seeAvatarSection
                      ? AvatarSection(selectAvatar: selectAvatar)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/avatar/avatar${userModel.avaterId}.png',
                            height: 150,
                            width: 150,
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  hintText: userModel.name,
                  iconPathName: 'profile',
                  controller: nameController,
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
                  hintText: userModel.phone,
                  iconPathName: 'phone',
                  controller: phoneController,
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: AppTheme.backgroundDark,
                        context: context,

                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                        builder: (context) {
                          return DraggableScrollableSheet(
                            expand: false,

                            initialChildSize: 0.85,
                            maxChildSize: 0.9,
                            minChildSize: 0.4,
                            builder: (context, scrollController) {
                              return ResetPasswordBottomSheet();
                            },
                          );
                        },
                      );
                    },
                    child: Text(
                      'Reset Password',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(color: AppTheme.white),
                    ),
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
                  isLoading: isLoading,
                  onPressed: updateData,
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateData() {
    if (globalKey.currentState!.validate()) {
      updateUser();
    }
  }

  Future<void> updateUser() async {
    try {
      setState(() {
        isLoading = true;
      });

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final currentUser = userProvider.currentUser!;

      final updatedUser = UserModel(
        id: currentUser.id,
        name: nameController.text.isNotEmpty
            ? nameController.text
            : currentUser.name,
        email: currentUser.email,
        phone: phoneController.text.isNotEmpty
            ? phoneController.text
            : currentUser.phone,
        avaterId: avatarIndex,
        createdAt: currentUser.createdAt,
        updatedAt: currentUser.updatedAt,
        token: currentUser.token,
      );

      final updateResult = await AuthApiService.updateProfile(
        updatedUser: updatedUser,
      );

      if (updateResult['success'] == true) {
        userProvider.updateCurrentUser(updatedUser);

        Utilis.showSuccessMessage(
          updateResult['message'] ?? 'Profile updated successfully',
        );

        // Navigator.pop(context);
        setState(() {
          seeAvatarSection = false;
        });
      } else {
        Utilis.showErrorMessage(
          updateResult['message'] ?? 'Failed to update profile',
        );
      }
    } catch (error) {
      log('Update profile error: $error');

      Utilis.showErrorMessage('Error: ${error.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void selectAvatar(int index) {
    avatarIndex = index;
  }
}
