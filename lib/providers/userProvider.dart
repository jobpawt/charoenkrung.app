import 'package:charoenkrung_app/data/userData.dart';
import 'package:flutter/material.dart';

class UserProvider  extends ChangeNotifier  {
  UserData user;

  void login(UserData user) {
    this.user = user;
    notifyListeners();
  }

  void logout() {
    this.user = null;
    notifyListeners();
  }
}