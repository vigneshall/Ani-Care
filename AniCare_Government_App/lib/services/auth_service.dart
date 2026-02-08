import 'package:flutter/material.dart';

enum UserRole { government, ngo, csr }

class AuthService with ChangeNotifier {
  bool _isAuthenticated = false;
  UserRole _role = UserRole.government;
  String _userName = "Gov Admin";

  bool get isAuthenticated => _isAuthenticated;
  UserRole get role => _role;
  String get userName => _userName;

  Future<bool> login(String email, String password) async {
    // Mock login logic
    await Future.delayed(const Duration(seconds: 2));
    _isAuthenticated = true;
    _role = UserRole.government;
    notifyListeners();
    return true;
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
