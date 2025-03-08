import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';
import '../../features/auth/models/user_model.dart';

/// Authentication result containing user and error information
class AuthResult {
  final UserModel? user;
  final String? errorMessage;

  AuthResult({this.user, this.errorMessage});

  bool get isSuccess => user != null && errorMessage == null;
}

/// Service for handling authentication-related operations
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get the current authenticated user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Stream of auth state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Reference to the users collection in Firestore
  CollectionReference get _usersCollection => _firestore.collection('users');

  /// Create a new user account with email and password
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String name,
    String? university,
  }) async {
    try {
      // Create the user in Firebase Auth
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        return AuthResult(errorMessage: AppConstants.authErrorMessage);
      }

      // Create user model
      final user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
        university: university,
        createdAt: DateTime.now(),
        isEmailVerified: false,
      );

      // Save user data to Firestore
      await _usersCollection.doc(user.id).set(user.toMap());

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      // Store user info in SharedPreferences
      await _saveUserToPrefs(user);

      return AuthResult(user: user);
    } on FirebaseAuthException catch (e) {
      return AuthResult(errorMessage: _getFirebaseAuthErrorMessage(e.code));
    } catch (e) {
      return AuthResult(errorMessage: e.toString());
    }
  }

  /// Sign in with email and password
  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        return AuthResult(errorMessage: AppConstants.authErrorMessage);
      }

      // Update last login time
      final now = DateTime.now();
      await _usersCollection.doc(userCredential.user!.uid).update({
        'lastLoginAt': now,
      });

      // Get user data from Firestore
      final userData = await _getUserData(userCredential.user!.uid);
      if (userData == null) {
        return AuthResult(errorMessage: 'User data not found');
      }

      final user = UserModel.fromFirebase(
        userData,
        userCredential.user!.uid,
      ).copyWith(
        lastLoginAt: now,
        isEmailVerified: userCredential.user!.emailVerified,
      );

      // Store user info in SharedPreferences
      await _saveUserToPrefs(user);

      return AuthResult(user: user);
    } on FirebaseAuthException catch (e) {
      return AuthResult(errorMessage: _getFirebaseAuthErrorMessage(e.code));
    } catch (e) {
      return AuthResult(errorMessage: e.toString());
    }
  }

  /// Sign out the current user
  Future<void> signOut() async {
    await _firebaseAuth.signOut();

    // Clear stored user data
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.tokenKey);
    await prefs.remove(AppConstants.userIdKey);
    await prefs.remove(AppConstants.userEmailKey);
  }

  /// Send password reset email
  Future<AuthResult> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return AuthResult();
    } on FirebaseAuthException catch (e) {
      return AuthResult(errorMessage: _getFirebaseAuthErrorMessage(e.code));
    } catch (e) {
      return AuthResult(errorMessage: e.toString());
    }
  }

  /// Check if email is already in use
  Future<bool> isEmailAlreadyInUse(String email) async {
    try {
      final methods = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      return methods.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Get current user data from Firestore
  Future<UserModel?> getCurrentUserData() async {
    if (currentUser == null) return null;

    final userData = await _getUserData(currentUser!.uid);
    if (userData == null) return null;

    return UserModel.fromFirebase(
      userData,
      currentUser!.uid,
    ).copyWith(isEmailVerified: currentUser!.emailVerified);
  }

  /// Send email verification to current user
  Future<void> sendEmailVerification() async {
    await currentUser?.sendEmailVerification();
  }

  /// Update user profile
  Future<AuthResult> updateUserProfile({
    required String userId,
    String? name,
    String? university,
    String? photoUrl,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (name != null) updates['name'] = name;
      if (university != null) updates['university'] = university;
      if (photoUrl != null) updates['photoUrl'] = photoUrl;

      await _usersCollection.doc(userId).update(updates);

      final userData = await _getUserData(userId);
      if (userData == null) {
        return AuthResult(errorMessage: 'User data not found');
      }

      final updatedUser = UserModel.fromFirebase(userData, userId);

      return AuthResult(user: updatedUser);
    } catch (e) {
      return AuthResult(errorMessage: e.toString());
    }
  }

  /// Helper method to get user data from Firestore
  Future<Map<String, dynamic>?> _getUserData(String userId) async {
    final docSnapshot = await _usersCollection.doc(userId).get();
    return docSnapshot.exists
        ? docSnapshot.data() as Map<String, dynamic>
        : null;
  }

  /// Helper method to save user data to SharedPreferences
  Future<void> _saveUserToPrefs(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.userIdKey, user.id);
    await prefs.setString(AppConstants.userEmailKey, user.email);

    // Store token (if you're using custom tokens)
    final token = await currentUser?.getIdToken();
    if (token != null) {
      await prefs.setString(AppConstants.tokenKey, token);
    }
  }

  /// Helper method to map Firebase Auth error codes to user-friendly messages
  String _getFirebaseAuthErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return AppConstants.emailAlreadyInUseError;
      case 'invalid-email':
        return AppConstants.invalidEmailError;
      case 'user-disabled':
        return 'This user account has been disabled';
      case 'user-not-found':
        return AppConstants.userNotFoundError;
      case 'wrong-password':
        return AppConstants.wrongPasswordError;
      case 'weak-password':
        return AppConstants.weakPasswordError;
      case 'operation-not-allowed':
        return 'This operation is not allowed';
      case 'too-many-requests':
        return 'Too many failed login attempts. Please try again later';
      case 'network-request-failed':
        return AppConstants.networkErrorMessage;
      default:
        return AppConstants.defaultErrorMessage;
    }
  }
}
