import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import 'gradient_button.dart';
/// Premium empty state widget with animation
/// Used when no data is available for a screen
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;
  
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated icon container
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withOpacity(0.1),
              ),
              child: Icon(
                icon,
                size: 48,
                color: AppColors.accent.withOpacity(0.7),
              ),
            )
            .animate()
            .fadeIn(duration: 400.ms)
            .scale(delay: 100.ms, curve: Curves.easeOutBack),
            
            const SizedBox(height: 24),
            
            // Title
            Text(
              title,
              style: AppTypography.titleLarge,
              textAlign: TextAlign.center,
            )
            .animate()
            .fadeIn(delay: 150.ms, duration: 400.ms)
            .slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 8),
            
            // Description
            Text(
              description,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondaryDark,
              ),
              textAlign: TextAlign.center,
            )
            .animate()
            .fadeIn(delay: 250.ms, duration: 400.ms)
            .slideY(begin: 0.2, end: 0),
            
            // Optional action button
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 32),
              GradientButton(
                text: actionLabel!,
                onPressed: onAction,
              )
              .animate()
              .fadeIn(delay: 350.ms, duration: 400.ms)
              .slideY(begin: 0.2, end: 0),
            ],
          ],
        ),
      ),
    );
  }
}