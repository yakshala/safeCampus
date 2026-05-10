import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/alert_tile.dart';
import '../../widgets/glass_card.dart';
import '../../services/mock_data_service.dart';
import '../alerts/models/alert_model.dart';
/// Main dashboard screen - the heart of the security application
/// Shows real-time statistics, recent alerts, and quick actions
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});
  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}
class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedNavIndex = 0;
  
  final List<_NavItem> _navItems = const [
    _NavItem(icon: Iconsax.home_2, activeIcon: Iconsax.home_25, label: 'Home'),
    _NavItem(icon: Iconsax.video, activeIcon: Iconsax.video5, label: 'Monitor'),
    _NavItem(icon: Iconsax.notification, activeIcon: Iconsax.notification5, label: 'Alerts'),
    _NavItem(icon: Iconsax.map, activeIcon: Iconsax.map5, label: 'Map'),
    _NavItem(icon: Iconsax.setting_2, activeIcon: Iconsax.setting5, label: 'Settings'),
  ];
  @override
  Widget build(BuildContext context) {
    final stats = MockDataService.getDashboardStats();
    final alerts = MockDataService.getAlerts().take(3).toList();
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 0.3],
            colors: [
              AppColors.primaryDark,
              AppColors.surfaceDark,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // App bar
              CustomAppBar(
                title: 'Dashboard',
                subtitle: 'Good morning, John',
                onNotificationTap: () => context.push('/alerts'),
                notificationCount: stats['activeAlerts'] as int,
              ),
              
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                 child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    _buildCameraConnectionCard(),

    const SizedBox(height: 24),

    // Quick stats grid
    _buildStatsGrid(stats),
                      const SizedBox(height: 28),
                      
                      // Quick actions
                      _buildQuickActions(),
                      
                      const SizedBox(height: 28),
                      
                      // Recent alerts section
                      _buildRecentAlerts(alerts),
                      
                      const SizedBox(height: 28),
                      
                      // System status card
                      _buildSystemStatus(stats),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
      // Premium bottom navigation
      bottomNavigationBar: _buildBottomNav(),
      extendBody: true,
    );
  }
  Widget _buildCameraConnectionCard() {
  return GlassCard(
    padding: const EdgeInsets.all(18),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.online.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Iconsax.video,
                color: AppColors.online,
                size: 28,
              ),
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .shimmer(duration: 1800.ms),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Live Camera Connected',
                    style: AppTypography.titleSmall,
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Main Gate CCTV',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondaryDark,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'RTSP • 192.168.1.25:8554',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textTertiaryDark,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.online.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.online,
                      shape: BoxShape.circle,
                    ),
                  )
                      .animate(
                        onPlay: (controller) =>
                            controller.repeat(),
                      )
                      .fade(
                        begin: 0.2,
                        end: 1,
                        duration: 800.ms,
                      ),

                  const SizedBox(width: 6),

                  Text(
                    'LIVE',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.online,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: _buildConnectionMetric(
                'Latency',
                '42ms',
                AppColors.accent,
                Iconsax.flash_1,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildConnectionMetric(
                'FPS',
                '24',
                AppColors.online,
                Iconsax.activity,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildConnectionMetric(
                'Signal',
                'Strong',
                AppColors.alertMedium,
                Iconsax.wifi,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => context.push('/monitoring'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent.withOpacity(0.15),
              foregroundColor: AppColors.accent,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Iconsax.play),
            label: const Text('Open Live Feed'),
          ),
        ),
      ],
    ),
  )
      .animate()
      .fadeIn(delay: 100.ms)
      .slideY(begin: -0.05, end: 0);
}
Widget _buildConnectionMetric(
  String label,
  String value,
  Color color,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 10,
    ),
    decoration: BoxDecoration(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 18,
        ),

        const SizedBox(height: 8),

        Text(
          value,
          style: AppTypography.labelMedium.copyWith(
            color: color,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textTertiaryDark,
          ),
        ),
      ],
    ),
  );
}
  Widget _buildStatsGrid(Map<String, dynamic> stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: AppTypography.titleLarge,
        )
        .animate()
        .fadeIn()
        .slideX(begin: -0.05, end: 0),
        
        const SizedBox(height: 16),
        
        // Stats in 2x2 grid
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Active Alerts',
                value: stats['activeAlerts'] as int,
                icon: Iconsax.warning_2,
                accentColor: AppColors.alertCritical,
                trend: stats['alertsTrend'] as double,
                onTap: () => context.push('/alerts'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: 'Cameras Online',
                value: stats['camerasOnline'] as int,
                subtitle: 'of ${stats['totalCameras']}',
                icon: Iconsax.video,
                accentColor: AppColors.online,
                trend: stats['camerasTrend'] as double,
                onTap: () => context.push('/monitoring'),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Incidents Today',
                value: stats['incidentsToday'] as int,
                icon: Iconsax.document_text,
                accentColor: AppColors.alertMedium,
                trend: stats['incidentsTrend'] as double,
                onTap: () => context.push('/reports'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: 'System Health',
                value: stats['systemHealth'] as int,
                subtitle: 'Operational',
                icon: Iconsax.health,
                accentColor: AppColors.accent,
                trend: stats['healthTrend'] as double,
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildQuickActions() {
    final actions = [
      _QuickAction(
        icon: Iconsax.video,
        label: 'Live Feed',
        color: AppColors.accent,
        onTap: () => context.push('/monitoring'),
      ),
      _QuickAction(
        icon: Iconsax.map,
        label: 'Campus Map',
        color: AppColors.online,
        onTap: () => context.push('/map'),
      ),
      _QuickAction(
        icon: Iconsax.document_text,
        label: 'Reports',
        color: AppColors.alertMedium,
        onTap: () => context.push('/reports'),
      ),
      _QuickAction(
        icon: Iconsax.security_user,
        label: 'Admin',
        color: AppColors.alertHigh,
        onTap: () => context.push('/admin'),
      ),
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: AppTypography.titleLarge,
        )
        .animate()
        .fadeIn(delay: 100.ms)
        .slideX(begin: -0.05, end: 0),
        
        const SizedBox(height: 16),
        
        Row(
          children: actions.asMap().entries.map((entry) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: entry.key < actions.length - 1 ? 10 : 0,
                ),
                child: _buildActionButton(entry.value, entry.key),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
  Widget _buildActionButton(_QuickAction action, int index) {
    return GlassContainer(
      onTap: action.onTap,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: action.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              action.icon,
              color: action.color,
              size: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            action.label,
            style: AppTypography.labelMedium,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    )
    .animate(delay: Duration(milliseconds: 150 + (index * 50)))
    .fadeIn()
    .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
  }
  Widget _buildRecentAlerts(List<AlertModel> alerts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Alerts',
              style: AppTypography.titleLarge,
            ),
            TextButton(
              onPressed: () => context.push('/alerts'),
              child: Text(
                'View All',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(delay: 200.ms)
        .slideX(begin: -0.05, end: 0),
        
        const SizedBox(height: 12),
        
        ...alerts.asMap().entries.map((entry) => AlertTile(
          alert: entry.value,
          animationIndex: entry.key,
          onTap: () {
            // Show alert details
          },
        )),
      ],
    );
  }
  Widget _buildSystemStatus(Map<String, dynamic> stats) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.online.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Iconsax.cpu,
                  color: AppColors.online,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'System Status',
                    style: AppTypography.titleSmall,
                  ),
                  Text(
                    'All systems operational',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.online,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.online.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.online,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Healthy',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.online,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Status bars
          _buildStatusBar('AI Detection', 0.98, AppColors.accent),
          const SizedBox(height: 12),
          _buildStatusBar('Network', 0.95, AppColors.online),
          const SizedBox(height: 12),
          _buildStatusBar('Storage', 0.72, AppColors.alertMedium),
        ],
      ),
    )
    .animate()
    .fadeIn(delay: 400.ms)
    .slideY(begin: 0.05, end: 0);
  }
  Widget _buildStatusBar(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondaryDark,
              ),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: AppTypography.labelSmall.copyWith(
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: AppColors.surfaceCard,
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
  Widget _buildBottomNav() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _navItems.asMap().entries.map((entry) {
              final isSelected = entry.key == _selectedNavIndex;
              return _buildNavItem(
                entry.value,
                isSelected,
                () {
                  setState(() => _selectedNavIndex = entry.key);
                  // Navigate based on index
                  switch (entry.key) {
                    case 1:
                      context.push('/monitoring');
                      break;
                    case 2:
                      context.push('/alerts');
                      break;
                    case 3:
                      context.push('/map');
                      break;
                    case 4:
                      context.push('/admin');
                      break;
                  }
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
  Widget _buildNavItem(_NavItem item, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.accent.withOpacity(0.15) 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? item.activeIcon : item.icon,
              color: isSelected 
                  ? AppColors.accent 
                  : AppColors.textTertiaryDark,
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(height: 4),
              Text(
                item.label,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}