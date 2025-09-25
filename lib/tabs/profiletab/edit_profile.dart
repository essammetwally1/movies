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

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool seeAvatarSection = false;
  bool isLoading = false;
  late int avatarIndex;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (userProvider.currentUser != null) {
      nameController.text = userProvider.currentUser!.name;
      phoneController.text = userProvider.currentUser!.phone;
      avatarIndex = userProvider.currentUser!.avaterId;
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = Provider.of<UserProvider>(context).currentUser;

    if (userModel == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: const Center(child: Text('User not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
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
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: AppTheme.grey,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 60,
                                  color: AppTheme.white,
                                ),
                              );
                            },
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: userModel.name,
                  iconPathName: 'profile',
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Your Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
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
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
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
                              return const ResetPasswordBottomSheet();
                            },
                          );
                        },
                      );
                    },
                    child: Text(
                      'Reset Password',
                      style:
                          Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppTheme.white,
                          ) ??
                          TextStyle(color: AppTheme.white),
                    ),
                  ),
                ),

                const Spacer(),
                CustomElevatedButton(
                  textElevatedButton: 'Delete Account',
                  onPressed: () {},
                  color: AppTheme.red,
                ),
                const SizedBox(height: 16),
                CustomElevatedButton(
                  textElevatedButton: 'Update Data',
                  isLoading: isLoading,
                  onPressed: updateData,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateData() {
    // FIXED: Added null check before accessing currentState
    if (globalKey.currentState != null && globalKey.currentState!.validate()) {
      updateUser();
    } else {
      // Optional: Show error if form is not valid
      Utilis.showErrorMessage('Please fix the errors above');
    }
  }

  Future<void> updateUser() async {
    UserProvider userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    if (nameController.text == userProvider.currentUser!.name &&
        phoneController.text == userProvider.currentUser!.phone &&
        avatarIndex == userProvider.currentUser!.avaterId) {
      Utilis.showErrorMessage('No changes made to update');
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final currentUser = userProvider.currentUser;

      // Add null check for currentUser
      if (currentUser == null) {
        Utilis.showErrorMessage('User not found');
        return;
      }

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
      Navigator.of(context).pop();
    }
  }

  void selectAvatar(int index) {
    setState(() {
      avatarIndex = index;
    });
  }
}
