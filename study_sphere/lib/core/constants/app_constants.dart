/// Application constants used throughout the application
class AppConstants {
  // App Info
  static const String appName = 'StudySphere';
  static const String appVersion = '1.0.0';

  // Route Names
  static const String splashRoute = '/';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String homeRoute = '/home';
  static const String profileRoute = '/profile';
  static const String studySpotDetailsRoute = '/study-spot-details';
  static const String settingsRoute = '/settings';

  // Shared Preferences Keys
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String userEmailKey = 'user_email';
  static const String isDarkModeKey = 'is_dark_mode';
  static const String onboardingCompletedKey = 'onboarding_completed';

  // Error Messages
  static const String defaultErrorMessage =
      'Something went wrong. Please try again.';
  static const String networkErrorMessage =
      'Network error. Please check your connection.';
  static const String authErrorMessage =
      'Authentication failed. Please check your credentials.';
  static const String emailAlreadyInUseError =
      'This email is already in use. Please try another.';
  static const String weakPasswordError =
      'Password is too weak. Please use a stronger password.';
  static const String invalidEmailError =
      'Invalid email address. Please check and try again.';
  static const String userNotFoundError =
      'User not found. Please check your email or register.';
  static const String wrongPasswordError = 'Wrong password. Please try again.';

  // Validation Rules
  static const int minPasswordLength = 8;
  static const String passwordValidationMessage =
      'Password must be at least 8 characters and include uppercase, lowercase, number, and special character.';
  static const String emailValidationMessage =
      'Please enter a valid email address.';
  static const String requiredFieldMessage = 'This field is required.';

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 500);
  static const Duration longAnimationDuration = Duration(milliseconds: 1000);
}

/// Authentication related constants
class AuthConstants {
  static const String signIn = 'Sign In';
  static const String signUp = 'Sign Up';
  static const String forgotPassword = 'Forgot Password?';
  static const String createAccount = 'Create Account';
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String dontHaveAccount = "Don't have an account? ";
  static const String resetPassword = 'Reset Password';
  static const String verifyEmail = 'Verify Email';
  static const String resendVerificationEmail = 'Resend Verification Email';
  static const String signInWithGoogle = 'Sign in with Google';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String name = 'Full Name';
  static const String university = 'University';
  static const String agreeToTerms =
      'I agree to the Terms of Service and Privacy Policy';
  static const String passwordsDoNotMatch = 'Passwords do not match';
}

/// Onboarding related constants
class OnboardingConstants {
  static const String skip = 'Skip';
  static const String next = 'Next';
  static const String getStarted = 'Get Started';

  static const List<Map<String, String>> onboardingItems = [
    {
      'title': 'Find Your Perfect Study Spot',
      'description':
          'Discover study locations based on your preferences for noise levels, amenities, and more.',
      'image': 'assets/images/onboarding_1.png',
    },
    {
      'title': 'Real-Time Availability',
      'description':
          'See which locations have seats available right now and avoid wasting time searching.',
      'image': 'assets/images/onboarding_2.png',
    },
    {
      'title': 'Connect with Peers',
      'description':
          'Share your favorite study spots and see where your friends like to study.',
      'image': 'assets/images/onboarding_3.png',
    },
  ];
}

/// Study spot filter constants
class FilterConstants {
  static const String noise = 'Noise Level';
  static const String distance = 'Distance';
  static const String openNow = 'Open Now';
  static const String hasOutlets = 'Power Outlets';
  static const String hasWifi = 'WiFi';
  static const String hasCoffee = 'Coffee Nearby';
  static const String hasFood = 'Food Available';
  static const String hasNaturalLight = 'Natural Light';
  static const String isAccessible = 'Accessibility';
  static const String groupFriendly = 'Group Friendly';

  static const List<String> noiseOptions = [
    'Silent',
    'Quiet',
    'Moderate',
    'Any',
  ];
  static const List<String> distanceOptions = [
    '< 5 min',
    '< 10 min',
    '< 20 min',
    'Any',
  ];
}
