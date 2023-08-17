import 'package:album_manager/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _selectedUser;

  User? get selectedUser => _selectedUser;

  void setSelectedUser(User user) {
    _selectedUser = user;
    notifyListeners();
  }
}
