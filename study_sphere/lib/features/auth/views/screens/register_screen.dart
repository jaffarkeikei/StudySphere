import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../providers/auth_provider.dart';

/// User registration screen
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  bool _acceptTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _universityController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_acceptTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please accept the terms and conditions'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }

      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final university = _universityController.text.trim();

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.signUp(
        email: email,
        password: password,
        name: name,
        university: university.isNotEmpty ? university : null,
      );

      if (success && mounted) {
        // Show success message and navigate back to login
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Account created successfully. Please verify your email.',
            ),
            backgroundColor: AppColors.success,
          ),
        );

        // Navigate to home screen (or verification screen if we had one)
        Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
      } else if (mounted) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              authProvider.errorMessage ?? AppConstants.authErrorMessage,
            ),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AuthConstants.createAccount),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Full name field
                AppTextField(
                  label: AuthConstants.name,
                  hint: 'Enter your full name',
                  controller: _nameController,
                  validator: Validators.validateRequired,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.person_outline),
                ),

                const SizedBox(height: 24),

                // Email field
                AppTextField(
                  label: AuthConstants.email,
                  hint: 'Enter your email address',
                  controller: _emailController,
                  validator: Validators.validateUniversityEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),

                const SizedBox(height: 24),

                // University field
                AppTextField(
                  label: AuthConstants.university,
                  hint: 'Enter your university name',
                  controller: _universityController,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.school_outlined),
                ),

                const SizedBox(height: 24),

                // Password field
                AppPasswordField(
                  label: AuthConstants.password,
                  hint: 'Create a strong password',
                  controller: _passwordController,
                  validator: Validators.validatePassword,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 24),

                // Confirm password field
                AppPasswordField(
                  label: AuthConstants.confirmPassword,
                  hint: 'Confirm your password',
                  controller: _confirmPasswordController,
                  validator:
                      (value) => Validators.validatePasswordsMatch(
                        _passwordController.text,
                        value,
                      ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _register(),
                ),

                const SizedBox(height: 24),

                // Terms and conditions checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _acceptTerms,
                      onChanged: (value) {
                        setState(() {
                          _acceptTerms = value ?? false;
                        });
                      },
                      activeColor: AppColors.primary,
                    ),
                    Expanded(
                      child: Text(
                        AuthConstants.agreeToTerms,
                        style: AppTextStyles.bodySmall,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Register button
                AppButton(
                  text: AuthConstants.signUp,
                  onPressed: _register,
                  isLoading: authProvider.isLoading,
                ),

                const SizedBox(height: 24),

                // Back to login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AuthConstants.alreadyHaveAccount),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        AuthConstants.signIn,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
