import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import 'glass_card.dart';
import 'animated_counter.dart';
/// Premium statistic card with animated counter and trend indicator
/// Designed for dashboard metrics display
class StatCard extends StatelessWidget {
  final String title;
  final int value;
  final String? subtitle;
  final IconData icon;
  final Color? accentColor;
  final double? trend; // Percentage change
  final VoidCallback? onTap;
  
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    this.accentColor,
    this.trend,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppColors.accent;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassContainer(
      onTap: onTap,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon with colored background
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              // Trend indicator
              if (trend != null)
                _buildTrendBadge(trend!),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Animated value counter
          AnimatedCounter(
            value: value,
            style: AppTypography.statNumber.copyWith(
              color: isDark 
                  ? AppColors.textPrimaryDark 
                  : AppColors.textPrimaryLight,
            ),
          ),
          
          const SizedBox(height: 4),
          
          // Title
          Text(
            title,
            style: AppTypography.titleSmall.copyWith(
              color: isDark 
                  ? AppColors.textSecondaryDark 
                  : AppColors.textSecondaryLight,
            ),
          ),
          
          // Optional subtitle
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              style: AppTypography.caption.copyWith(
                color: isDark 
                    ? AppColors.textTertiaryDark 
                    : AppColors.textTertiaryLight,
              ),
            ),
          ],
        ],
      ),
    )
    .animate()
    .fadeIn(duration: 400.ms)
    .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
  }
  Widget _buildTrendBadge(double trend) {
    final isPositive = trend >= 0;
    final color = isPositive ? AppColors.online : AppColors.error;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive 
                ? Icons.trending_up_rounded 
                : Icons.trending_down_rounded,
            color: color,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            '${isPositive ? '+' : ''}${trend.toStringAsFixed(1)}%',
            style: AppTypography.badge.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
/// Compact stat card for smaller grid layouts
class CompactStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  
  const CompactStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: AppTypography.titleLarge,
                ),
                Text(
                  title,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}