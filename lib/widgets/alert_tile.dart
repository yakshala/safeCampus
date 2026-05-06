import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../features/alerts/models/alert_model.dart';
import 'glass_card.dart';
/// Premium alert tile with severity indicators and smooth animations
/// Designed for quick scanning and visual hierarchy
class AlertTile extends StatelessWidget {
  final AlertModel alert;
  final VoidCallback? onTap;
  final int animationIndex;
  
  const AlertTile({
    super.key,
    required this.alert,
    this.onTap,
    this.animationIndex = 0,
  });
  @override
  Widget build(BuildContext context) {
    final severityColor = _getSeverityColor(alert.severity);
    final severityBg = _getSeverityBackground(alert.severity);
    
    return GlassContainer(
      onTap: onTap,
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Severity indicator bar
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: severityColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Alert type icon with colored background
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: severityBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getAlertIcon(alert.type),
                        color: severityColor,
                        size: 24,
                      ),
                    ),
                    
                    const SizedBox(width: 14),
                    
                    // Alert details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Alert type chip
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: severityBg,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  alert.type.label,
                                  style: AppTypography.badge.copyWith(
                                    color: severityColor,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              // Time
                              Text(
                                alert.timeAgo,
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textTertiaryDark,
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 8),
                          
                          // Alert title
                          Text(
                            alert.title,
                            style: AppTypography.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          const SizedBox(height: 4),
                          
                          // Location with icon
                          Row(
                            children: [
                              Icon(
                                Iconsax.location,
                                size: 14,
                                color: AppColors.textTertiaryDark,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  alert.location,
                                  style: AppTypography.bodySmall.copyWith(
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
                    
                    const SizedBox(width: 8),
                    
                    // Arrow indicator
                    Icon(
                      Iconsax.arrow_right_3,
                      color: AppColors.textTertiaryDark,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
    .animate(delay: Duration(milliseconds: animationIndex * 50))
    .fadeIn(duration: 300.ms)
    .slideX(begin: 0.05, end: 0, curve: Curves.easeOutCubic);
  }
  Color _getSeverityColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.critical:
        return AppColors.alertCritical;
      case AlertSeverity.high:
        return AppColors.alertHigh;
      case AlertSeverity.medium:
        return AppColors.alertMedium;
      case AlertSeverity.low:
        return AppColors.alertLow;
    }
  }
  Color _getSeverityBackground(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.critical:
        return AppColors.alertCriticalBg;
      case AlertSeverity.high:
        return AppColors.alertHighBg;
      case AlertSeverity.medium:
        return AppColors.alertMediumBg;
      case AlertSeverity.low:
        return AppColors.alertLowBg;
    }
  }
  IconData _getAlertIcon(AlertType type) {
    switch (type) {
      case AlertType.weapon:
        return Iconsax.shield_cross;
      case AlertType.crowd:
        return Iconsax.people;
      case AlertType.intrusion:
        return Iconsax.danger;
      case AlertType.suspicious:
        return Iconsax.eye;
      case AlertType.fire:
        return Iconsax.flash;
      case AlertType.unauthorized:
        return Iconsax.lock;
    }
  }
}