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
  UserModel? get currentUser => _currentUser;

  bool get isLogin => _currentUser != null;

  Future<void> loadUser() async {
    _currentUser = await _saveUser.getUser();
    debugPrint("Auth status: ${isLogin ? 'Logged In as ${_currentUser?.email}' : 'Not Logged In'}");

    // notifyListeners is moved to a microtask to avoid "setState() during build" errors
    Future.microtask(() => notifyListeners());
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

      // 1. Create account in Firebase
      final user = await _authService.registerUser(
        username: username,
        email: email,
        password: password,
      );

      // 2. Save user locally for persistence
      await _saveUser.saveUser(user);
      // 3. Update local state
      _currentUser = user;
      
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint("Registration Error: $e");
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

      // 1. Authenticate with Firebase
      final user = await _authService.loginUser(
        email: email,
        password: password,
      );

      // 2. Save user locally
      await _saveUser.saveUser(user);
      
      // 3. Update local state
      _currentUser = user;
      
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint("Login Error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // logout user
  Future<void> logout() async {
    await _authService.logoutUser();
    await _saveUser.clearUser();

    _currentUser = null;
    notifyListeners();
  }
}
