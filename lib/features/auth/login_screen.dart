import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/glass_card.dart';
/// Premium login screen with elegant design and animations
/// Includes form validation and smooth transitions
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isLoading = false);
      context.go('/dashboard');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryDark,
              AppColors.surfaceDark,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  
                  // Header with animated logo
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            gradient: AppColors.accentGradient,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accent.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.shield_outlined,
                            size: 36,
                            color: AppColors.primaryDark,
                          ),
                        )
                        .animate()
                        .scale(curve: Curves.easeOutBack),
                        
                        const SizedBox(height: 24),
                        
                        Text(
                          'Welcome Back',
                          style: AppTypography.headlineLarge,
                        )
                        .animate()
                        .fadeIn(delay: 200.ms)
                        .slideY(begin: 0.2, end: 0),
                        
                        const SizedBox(height: 8),
                        
                        Text(
                          'Sign in to your security dashboard',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondaryDark,
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 300.ms)
                        .slideY(begin: 0.2, end: 0),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Login form card
                  GlassCard(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email field
                        Text(
                          'Email',
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: AppTypography.bodyLarge,
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            prefixIcon: const Icon(Iconsax.sms),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Password field
                        Text(
                          'Password',
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: AppTypography.bodyLarge,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            prefixIcon: const Icon(Iconsax.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword 
                                    ? Iconsax.eye 
                                    : Iconsax.eye_slash,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Forgot password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: AppTypography.labelMedium.copyWith(
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Login button
                        GradientButton(
                          text: 'Sign In',
                          isLoading: _isLoading,
                          onPressed: _handleLogin,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 500.ms)
                  .slideY(begin: 0.1, end: 0),
                  
                  const SizedBox(height: 32),
                  
                  // Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.textTertiaryDark.withOpacity(0.3),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'or continue with',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textTertiaryDark,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.textTertiaryDark.withOpacity(0.3),
                        ),
                      ),
                    ],
                  )
                  .animate()
                  .fadeIn(delay: 500.ms),
                  
                  const SizedBox(height: 24),
                  
                  // Social login buttons
                  Row(
                    children: [
                      Expanded(
                        child: _SocialButton(
                          icon: Icons.apple,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _SocialButton(
                          icon: Icons.g_mobiledata_rounded,
                          onTap: () {},
                        ),
                      ),
                    ],
                  )
                  .animate()
                  .fadeIn(delay: 600.ms),
                  
                  const SizedBox(height: 32),
                  
                  // Sign up link
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/signup'),
                          child: Text(
                            'Sign Up',
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.accent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 700.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class _SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  
  const _SocialButton({
    required this.icon,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceCard,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.textTertiaryDark.withOpacity(0.2),
            ),
          ),
          child: Icon(
            icon,
            size: 28,
            color: AppColors.textPrimaryDark,
          ),
        ),
      ),
    );
  }
}