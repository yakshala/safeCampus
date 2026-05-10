import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
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
  Size get preferredSize =>
      const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,

      child: Padding(
        padding:
            const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 6,
          bottom: 10,
        ),

        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // BACK BUTTON
            if (showBackButton)
              _buildIconButton(
                icon: Iconsax.arrow_left,

                onTap: () {
                  Navigator.of(context)
                      .pop();
                },
              )
            else
              const SizedBox(width: 0),

            if (showBackButton)
              const SizedBox(width: 12),

            // GREETING SECTION
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                mainAxisAlignment:
                    MainAxisAlignment
                        .center,

                children: [

                  // GOOD MORNING TEXT
                  Text(
                    subtitle ??
                        'Good Morning, John',

                    style:
                        AppTypography
                            .headlineSmall
                            .copyWith(
                      fontSize: 25,
                      fontWeight:
                          FontWeight.w700,

                      color: AppColors
                          .textPrimaryDark,

                      height: 1.1,
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),

            // EXTRA ACTIONS
            if (actions != null)
              ...actions!,

            // NOTIFICATION BUTTON
            if (onNotificationTap !=
                null) ...[
              const SizedBox(width: 8),

              _buildNotificationButton(),
            ],

            // USER AVATAR
            const SizedBox(width: 12),

            _buildUserAvatar(),
          ],
        ),
      ),
    );
  }

  // ICON BUTTON

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.surfaceCard,

      borderRadius:
          BorderRadius.circular(14),

      child: InkWell(
        onTap: onTap,

        borderRadius:
            BorderRadius.circular(14),

        child: Container(
          padding: const EdgeInsets.all(
            10,
          ),

          child: Icon(
            icon,

            color:
                AppColors.textPrimaryDark,

            size: 22,
          ),
        ),
      ),
    );
  }

  // NOTIFICATION BUTTON

  Widget _buildNotificationButton() {
    return Material(
      color: AppColors.surfaceCard,

      borderRadius:
          BorderRadius.circular(14),

      child: InkWell(
        onTap: onNotificationTap,

        borderRadius:
            BorderRadius.circular(14),

        child: Container(
          padding: const EdgeInsets.all(
            10,
          ),

          child: Stack(
            clipBehavior: Clip.none,

            children: [

              const Icon(
                Iconsax.notification,

                color:
                    AppColors.textPrimaryDark,

                size: 22,
              ),

              if (notificationCount >
                  0)
                Positioned(
                  top: -4,
                  right: -4,

                  child: Container(
                    padding:
                        const EdgeInsets.all(
                      4,
                    ),

                    decoration:
                        const BoxDecoration(
                      color: AppColors
                          .alertCritical,

                      shape:
                          BoxShape.circle,
                    ),

                    constraints:
                        const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),

                    child: Text(
                      notificationCount >
                              9
                          ? '9+'
                          : '$notificationCount',

                      style:
                          AppTypography
                              .badge
                              .copyWith(
                        color: Colors.white,
                        fontSize: 9,
                      ),

                      textAlign:
                          TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // USER AVATAR

  Widget _buildUserAvatar() {
    return Container(
      width: 44,
      height: 44,

      decoration: BoxDecoration(
        gradient:
            AppColors.accentGradient,

        borderRadius:
            BorderRadius.circular(14),
      ),

      child: Center(
        child: Text(
          'JD',

          style:
              AppTypography.labelLarge
                  .copyWith(
            color: AppColors.primaryDark,
            fontWeight:
                FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}