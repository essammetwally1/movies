import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/components/custom_eleveted_button.dart';
import 'package:movies/components/custom_text_form_feild.dart';
import 'package:movies/components/reset_password_bottom_sheet.dart';
import 'package:movies/models/user_model.dart';
import 'package:movies/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileUpdateScreen extends StatefulWidget {
  static const String routeName = '/profileupdate';
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel? userModel = Provider.of<UserProvider>(context).currentUser;
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
                  'assets/avatar/avatar${userModel!.avaterId}.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                hintText: userModel.name,
                iconPathName: 'profile',
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                hintText: userModel.phone,
                iconPathName: 'phone',
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: AppTheme.backgroundDark,
                      context: context,
<<<<<<< HEAD
                      isScrollControlled: true, // Important for top positioning
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(
                            20,
                          ), // Changed to bottom for top sheet
=======
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20),
>>>>>>> feature/auth
                        ),
                      ),
                      builder: (context) {
                        return DraggableScrollableSheet(
                          expand: false,
<<<<<<< HEAD
                          initialChildSize: 0.6, // Adjust height as needed
=======
                          initialChildSize: 0.85,
>>>>>>> feature/auth
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
