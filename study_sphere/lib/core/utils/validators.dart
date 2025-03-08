import '../constants/app_constants.dart';

/// Utility class for input validation
class Validators {
  /// Validates an email address
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.requiredFieldMessage;
    }

    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

    if (!emailRegExp.hasMatch(value)) {
      return AppConstants.emailValidationMessage;
    }

    return null;
  }

  /// Validates a password field
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.requiredFieldMessage;
    }

    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }

    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    final hasLowercase = value.contains(RegExp(r'[a-z]'));
    final hasDigit = value.contains(RegExp(r'[0-9]'));
    final hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (!hasUppercase || !hasLowercase || !hasDigit || !hasSpecialChar) {
      return AppConstants.passwordValidationMessage;
    }

    return null;
  }

  /// Validates that a field is not empty
  static String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppConstants.requiredFieldMessage;
    }
    return null;
  }

  /// Validates that passwords match
  static String? validatePasswordsMatch(
    String? password,
    String? confirmPassword,
  ) {
    if (password != confirmPassword) {
      return AuthConstants.passwordsDoNotMatch;
    }
    return null;
  }

  /// Validates that an university email is used
  static String? validateUniversityEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.requiredFieldMessage;
    }

    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.(edu|ac\.[a-zA-Z]{2,})$',
    );

    if (!emailRegExp.hasMatch(value)) {
      return 'Please use a valid university email address';
    }

    return null;
  }
}
