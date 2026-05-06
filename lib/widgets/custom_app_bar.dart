import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
/// Custom app bar with notification badge and user avatar
/// Consistent header design across all screens
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onNotificationTap;
  final int notificationCount;
  
  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.showBackButton = false,
    this.onNotificationTap,
    this.notificationCount = 0,
  });
  @override
  Size get preferredSize => const Size.fromHeight(70);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            // Back button or menu
            if (showBackButton)
              _buildIconButton(
                icon: Iconsax.arrow_left,
                onTap: () => Navigator.of(context).pop(),
              )
            else
              const SizedBox(width: 0),
            
            if (showBackButton) const SizedBox(width: 12),
            
            // Title section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                  Text(
                    title,
                    style: AppTypography.headlineSmall,
                  ),
                ],
              ),
            ),
            
            // Actions
            if (actions != null) ...actions!,
            
            // Notification bell with badge
            if (onNotificationTap != null) ...[
              const SizedBox(width: 8),
              _buildNotificationButton(),
            ],
            
            // User avatar
            const SizedBox(width: 12),
            _buildUserAvatar(),
          ],
        ),
      ),
    );
  }
  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.surfaceCard,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            color: AppColors.textPrimaryDark,
            size: 22,
          ),
        ),
      ),
    );
  }
  Widget _buildNotificationButton() {
    return Material(
      color: AppColors.surfaceCard,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onNotificationTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Iconsax.notification,
                color: AppColors.textPrimaryDark,
                size: 22,
              ),
              if (notificationCount > 0)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.alertCritical,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      notificationCount > 9 ? '9+' : '$notificationCount',
                      style: AppTypography.badge.copyWith(
                        color: Colors.white,
                        fontSize: 9,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildUserAvatar() {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        gradient: AppColors.accentGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          'JD',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}