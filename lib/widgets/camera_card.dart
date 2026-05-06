import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../models/camera_model.dart';
import 'status_badge.dart';
import 'glass_card.dart';
/// Premium camera feed card with live preview and status indicators
/// Includes loading states and smooth transitions
class CameraCard extends StatelessWidget {
  final CameraModel camera;
  final VoidCallback? onTap;
  final int animationIndex;
  
  const CameraCard({
    super.key,
    required this.camera,
    this.onTap,
    this.animationIndex = 0,
  });
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      onTap: onTap,
      padding: EdgeInsets.zero,
      borderRadius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Camera preview area
          AspectRatio(
            aspectRatio: 16 / 10,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Mock camera feed background
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: camera.isOnline
                          ? [
                              AppColors.primary.withOpacity(0.3),
                              AppColors.primaryDark.withOpacity(0.5),
                            ]
                          : [
                              Colors.grey.shade800,
                              Colors.grey.shade900,
                            ],
                    ),
                  ),
                  child: Center(
                    child: camera.isOnline
                        ? Icon(
                            Iconsax.video,
                            size: 40,
                            color: AppColors.textSecondaryDark.withOpacity(0.5),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Iconsax.video_slash,
                                size: 32,
                                color: AppColors.offline,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Offline',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.offline,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                
                // Live indicator overlay
                if (camera.isOnline)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'LIVE',
                            style: AppTypography.badge.copyWith(
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                
                // AI detection indicator
                if (camera.hasActiveAlert)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.alertCritical.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Iconsax.warning_2,
                        color: Colors.white,
                        size: 16,
                      ),
                    )
                    .animate(onPlay: (c) => c.repeat())
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.1, 1.1),
                      duration: 800.ms,
                    )
                    .then()
                    .scale(
                      begin: const Offset(1.1, 1.1),
                      end: const Offset(1, 1),
                      duration: 800.ms,
                    ),
                  ),
                
                // Full-screen button
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Iconsax.maximize_4,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Camera info
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        camera.name,
                        style: AppTypography.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Iconsax.location,
                            size: 12,
                            color: AppColors.textTertiaryDark,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              camera.location,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondaryDark,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                StatusBadge(
                  label: camera.isOnline ? 'Online' : 'Offline',
                  isActive: camera.isOnline,
                ),
              ],
            ),
          ),
        ],
      ),
    )
    .animate(delay: Duration(milliseconds: animationIndex * 80))
    .fadeIn(duration: 400.ms)
    .scale(
      begin: const Offset(0.95, 0.95),
      end: const Offset(1, 1),
      curve: Curves.easeOutCubic,
    );
  }
}