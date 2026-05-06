import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
/// Premium splash screen with animated logo reveal
/// Creates a strong first impression for security application
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to login after animation completes
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        context.go('/login');
      }
    });
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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated shield icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: AppColors.accentGradient,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  size: 50,
                  color: AppColors.primaryDark,
                ),
              )
              .animate()
              .scale(
                duration: 600.ms,
                curve: Curves.easeOutBack,
              )
              .then(delay: 200.ms)
              .shimmer(
                duration: 1200.ms,
                color: Colors.white.withOpacity(0.3),
              ),
              
              const SizedBox(height: 32),
              
              // App name
              Text(
                'SafeCampus',
                style: AppTypography.displaySmall.copyWith(
                  color: AppColors.textPrimaryDark,
                  fontWeight: FontWeight.w700,
                ),
              )
              .animate()
              .fadeIn(delay: 400.ms, duration: 500.ms)
              .slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 8),
              
              // Tagline
              Text(
                'AI-Powered Security',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.accent,
                  letterSpacing: 2,
                ),
              )
              .animate()
              .fadeIn(delay: 600.ms, duration: 500.ms)
              .slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 80),
              
              // Loading indicator
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.accent.withOpacity(0.7),
                  ),
                ),
              )
              .animate()
              .fadeIn(delay: 800.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}