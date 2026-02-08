import 'package:flutter/material.dart';
import '../models/app_models.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  AppUser? _currentUser;

  bool get isAuthenticated => _isAuthenticated;
  AppUser? get currentUser => _currentUser;

  Future<void> login(String email, String password) async {
    // Implement Firebase Auth logic here
    _isAuthenticated = true;
    _currentUser = AppUser(
      id: '1',
      name: 'User',
      email: email,
      points: 150,
      totalRescues: 12,
    );
    notifyListeners();
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _currentUser = null;
    notifyListeners();
  }
}
