import 'package:flutter/material.dart';
import 'package:movies/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;

  void updateCurrentUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }
}
