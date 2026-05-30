import 'package:dailycore/core/service/auth_service.dart';
import 'package:dailycore/core/service/save_user.dart';
import 'package:dailycore/data/model/user_model.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final SaveUser _saveUser = SaveUser();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  UserModel? _currentUser;
  UserModel? get user => _currentUser;

  bool get isLogin => _currentUser != null;

  Future<void> loadUser() async {
    _currentUser = await _saveUser.getUser();
    notifyListeners();
  }

  // register user
  Future<bool> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _authService.registerUser(
        username: username,
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // login user
  Future<bool> login({required String email, required String password}) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final user = await _authService.loginUser(email: email, password: password);
      _currentUser = user;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // logout user
  Future<void> logout() async {
    await _authService.logoutUser();
    await _saveUser.removeUser();
    _currentUser = null;
    notifyListeners();
  }
}
