import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../core/theme/app_colors.dart';
/// Skeleton loading placeholders for premium loading states
/// Provides visual feedback during data fetching
class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  
  const ShimmerLoading({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = 12,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Shimmer.fromColors(
      baseColor: isDark 
          ? AppColors.surfaceCard 
          : Colors.grey.shade300,
      highlightColor: isDark 
          ? AppColors.surfaceElevated 
          : Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
/// Shimmer card placeholder matching StatCard dimensions
class ShimmerStatCard extends StatelessWidget {
  const ShimmerStatCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerLoading(width: 48, height: 48),
          const SizedBox(height: 16),
          const ShimmerLoading(width: 80, height: 40),
          const SizedBox(height: 8),
          const ShimmerLoading(width: 100, height: 16),
        ],
      ),
    );
  }
}
/// Shimmer placeholder for alert tiles
class ShimmerAlertTile extends StatelessWidget {
  const ShimmerAlertTile({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const ShimmerLoading(width: 48, height: 48),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerLoading(width: 60, height: 16),
                const SizedBox(height: 8),
                const ShimmerLoading(height: 18),
                const SizedBox(height: 6),
                const ShimmerLoading(width: 120, height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/// Shimmer placeholder for camera cards
class ShimmerCameraCard extends StatelessWidget {
  const ShimmerCameraCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceCard.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AspectRatio(
            aspectRatio: 16 / 10,
            child: ShimmerLoading(
              height: double.infinity,
              borderRadius: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerLoading(width: 120, height: 18),
                const SizedBox(height: 8),
                const ShimmerLoading(width: 80, height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}