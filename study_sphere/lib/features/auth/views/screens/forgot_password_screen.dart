import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../providers/auth_provider.dart';

/// Screen for requesting password reset
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.sendPasswordResetEmail(email);

      if (success && mounted) {
        setState(() {
          _emailSent = true;
        });
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
        title: const Text(AuthConstants.resetPassword),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child:
              _emailSent ? _buildSuccessView() : _buildResetForm(authProvider),
        ),
      ),
    );
  }

  Widget _buildResetForm(AuthProvider authProvider) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Info text
          Text(
            'Enter your email address below and we will send you instructions to reset your password.',
            style: AppTextStyles.body,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 32),

          // Email field
          AppTextField(
            label: AuthConstants.email,
            hint: 'Enter your email address',
            controller: _emailController,
            validator: Validators.validateEmail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            prefixIcon: const Icon(Icons.email_outlined),
            onSubmitted: (_) => _resetPassword(),
          ),

          const SizedBox(height: 32),

          // Reset button
          AppButton(
            text: AuthConstants.resetPassword,
            onPressed: _resetPassword,
            isLoading: authProvider.isLoading,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.check_circle_outline,
          color: AppColors.success,
          size: 72,
        ),

        const SizedBox(height: 24),

        Text(
          'Password Reset Email Sent',
          style: AppTextStyles.heading2,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 16),

        Text(
          'We have sent password reset instructions to:',
          style: AppTextStyles.body,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 8),

        Text(
          _emailController.text,
          style: AppTextStyles.subtitle.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 16),

        Text(
          'Please check your email and follow the instructions to reset your password.',
          style: AppTextStyles.body,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 32),

        AppButton(
          text: 'Back to Login',
          onPressed: () {
            Navigator.pop(context);
          },
          type: ButtonType.secondary,
        ),
      ],
    );
  }
}
