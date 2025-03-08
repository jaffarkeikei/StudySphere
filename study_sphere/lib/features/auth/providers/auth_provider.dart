import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../shared/services/auth_service.dart';
import '../models/user_model.dart';

/// Provider to manage authentication state
class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  /// Get the current user
  UserModel? get user => _user;

  /// Check if user is authenticated
  bool get isAuthenticated => _user != null;

  /// Check if authentication is in progress
  bool get isLoading => _isLoading;

  /// Get error message from last operation
  String? get errorMessage => _errorMessage;

  /// Check if user's email is verified
  bool get isEmailVerified => _user?.isEmailVerified ?? false;

  /// Initialize the auth provider and try to restore session
  Future<void> initialize() async {
    _setLoading(true);
    try {
      // Listen to auth state changes
      _authService.authStateChanges.listen(_handleAuthStateChange);

      // Try to get current user data
      final currentUserData = await _authService.getCurrentUserData();
      _user = currentUserData;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  /// Handle auth state changes from Firebase
  void _handleAuthStateChange(User? firebaseUser) async {
    if (firebaseUser == null) {
      // User logged out
      _user = null;
      notifyListeners();
      return;
    }

    // If we already have the user data and it matches the current Firebase user,
    // we don't need to fetch it again
    if (_user != null && _user!.id == firebaseUser.uid) {
      // Just update the email verification status
      if (_user!.isEmailVerified != firebaseUser.emailVerified) {
        _user = _user!.copyWith(isEmailVerified: firebaseUser.emailVerified);
        notifyListeners();
      }
      return;
    }

    // Otherwise fetch the user data
    _setLoading(true);
    try {
      final currentUserData = await _authService.getCurrentUserData();
      _user = currentUserData;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  /// Sign up a new user
  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
    String? university,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final result = await _authService.signUp(
        email: email,
        password: password,
        name: name,
        university: university,
      );

      if (result.isSuccess) {
        _user = result.user;
        return true;
      } else {
        _errorMessage = result.errorMessage;
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Sign in an existing user
  Future<bool> signIn({required String email, required String password}) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final result = await _authService.signIn(
        email: email,
        password: password,
      );

      if (result.isSuccess) {
        _user = result.user;
        return true;
      } else {
        _errorMessage = result.errorMessage;
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Sign out the current user
  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _user = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  /// Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final result = await _authService.sendPasswordResetEmail(email);

      if (result.errorMessage != null) {
        _errorMessage = result.errorMessage;
        return false;
      }

      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Send email verification to current user
  Future<bool> sendEmailVerification() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      await _authService.sendEmailVerification();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Check if email is already in use
  Future<bool> isEmailAlreadyInUse(String email) async {
    return await _authService.isEmailAlreadyInUse(email);
  }

  /// Update user profile
  Future<bool> updateUserProfile({
    String? name,
    String? university,
    String? photoUrl,
  }) async {
    if (_user == null) return false;

    _setLoading(true);
    _errorMessage = null;

    try {
      final result = await _authService.updateUserProfile(
        userId: _user!.id,
        name: name,
        university: university,
        photoUrl: photoUrl,
      );

      if (result.isSuccess) {
        _user = result.user;
        return true;
      } else {
        _errorMessage = result.errorMessage;
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Helper method to update loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
