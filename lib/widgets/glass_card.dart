import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
/// Premium glassmorphism card with blur effect and subtle border
/// Used for elevated content that needs visual distinction
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blur;
  final Color? borderColor;
  final VoidCallback? onTap;
  
  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 16,
    this.blur = 10,
    this.borderColor,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(borderRadius),
              child: Container(
                padding: padding ?? const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // Gradient background for glass effect
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.05),
                          ]
                        : [
                            Colors.white.withOpacity(0.7),
                            Colors.white.withOpacity(0.5),
                          ],
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                  // Subtle border for depth
                  border: Border.all(
                    color: borderColor ?? 
                        (isDark 
                            ? Colors.white.withOpacity(0.1) 
                            : Colors.white.withOpacity(0.3)),
                    width: 1.5,
                  ),
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/// Simplified glass container without backdrop blur
/// Better performance for lists and grids
class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final VoidCallback? onTap;
  
  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 16,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark 
                  ? AppColors.surfaceCard.withOpacity(0.7)
                  : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.08)
                    : Colors.grey.withOpacity(0.15),
                width: 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}