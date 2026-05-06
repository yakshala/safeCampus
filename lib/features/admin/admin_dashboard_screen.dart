import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/stat_card.dart';
/// Admin dashboard with user management and system controls
/// Tabbed interface for different administrative functions
class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});
  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}
class _AdminDashboardScreenState extends State<AdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 0.2],
            colors: [
              AppColors.primaryDark,
              AppColors.surfaceDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildUsersTab(),
                    _buildAlertsTab(),
                    _buildReportsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Material(
            color: AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              borderRadius: BorderRadius.circular(12),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Iconsax.arrow_left,
                  color: AppColors.textPrimaryDark,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin Dashboard',
                  style: AppTypography.headlineSmall,
                ),
                Text(
                  'System Management',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ],
            ),
          ),
          // Admin avatar
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Iconsax.security_user,
              color: AppColors.primaryDark,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(4),
        labelColor: AppColors.primaryDark,
        unselectedLabelColor: AppColors.textSecondaryDark,
        labelStyle: AppTypography.labelMedium,
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Users'),
          Tab(text: 'Alerts'),
          Tab(text: 'Reports'),
        ],
      ),
    )
    .animate()
    .fadeIn()
    .slideY(begin: -0.1, end: 0);
  }
  Widget _buildUsersTab() {
    final users = [
      _UserData('John Doe', 'john.doe@campus.edu', 'Admin', true),
      _UserData('Jane Smith', 'jane.smith@campus.edu', 'Security', true),
      _UserData('Bob Wilson', 'bob.wilson@campus.edu', 'Viewer', false),
      _UserData('Alice Brown', 'alice.brown@campus.edu', 'Security', true),
      _UserData('Charlie Davis', 'charlie.d@campus.edu', 'Viewer', true),
    ];
    
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: users.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats row
              Row(
                children: [
                  Expanded(
                    child: CompactStatCard(
                      title: 'Total Users',
                      value: '${users.length}',
                      icon: Iconsax.people,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CompactStatCard(
                      title: 'Active Now',
                      value: '${users.where((u) => u.isActive).length}',
                      icon: Iconsax.activity,
                      color: AppColors.online,
                    ),
                  ),
                ],
              )
              .animate()
              .fadeIn()
              .slideY(begin: 0.1, end: 0),
              
              const SizedBox(height: 24),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('User Management', style: AppTypography.titleLarge),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Iconsax.add, size: 18),
                    label: const Text('Add User'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          );
        }
        
        return _buildUserTile(users[index - 1], index - 1);
      },
    );
  }
  Widget _buildUserTile(_UserData user, int index) {
    return GlassContainer(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.accent.withOpacity(0.8),
                  AppColors.accentDark,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                user.name.split(' ').map((n) => n[0]).take(2).join(),
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.primaryDark,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(user.name, style: AppTypography.titleSmall),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getRoleColor(user.role).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        user.role,
                        style: AppTypography.badge.copyWith(
                          color: _getRoleColor(user.role),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ],
            ),
          ),
          
          // Status indicator
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: user.isActive ? AppColors.online : AppColors.offline,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // More button
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.more),
            color: AppColors.textSecondaryDark,
          ),
        ],
      ),
    )
    .animate(delay: Duration(milliseconds: 50 * index))
    .fadeIn()
    .slideX(begin: 0.05, end: 0);
  }
  Color _getRoleColor(String role) {
    switch (role) {
      case 'Admin':
        return AppColors.alertCritical;
      case 'Security':
        return AppColors.accent;
      default:
        return AppColors.textSecondaryDark;
    }
  }
  Widget _buildAlertsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Alert configuration cards
          Text('Alert Configuration', style: AppTypography.titleLarge),
          const SizedBox(height: 16),
          
          _buildConfigCard(
            'Weapon Detection',
            'AI-powered weapon identification',
            true,
            Iconsax.shield_cross,
            AppColors.alertCritical,
          ),
          _buildConfigCard(
            'Crowd Detection',
            'Monitor overcrowding thresholds',
            true,
            Iconsax.people,
            AppColors.alertHigh,
          ),
          _buildConfigCard(
            'Intrusion Detection',
            'Perimeter breach alerts',
            true,
            Iconsax.danger,
            AppColors.alertMedium,
          ),
          _buildConfigCard(
            'Fire/Smoke Detection',
            'Thermal anomaly monitoring',
            false,
            Iconsax.flash,
            AppColors.alertLow,
          ),
        ],
      ),
    );
  }
  Widget _buildConfigCard(
    String title,
    String subtitle,
    bool isEnabled,
    IconData icon,
    Color color,
  ) {
    return GlassContainer(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.titleSmall),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: (value) {},
            activeColor: AppColors.accent,
          ),
        ],
      ),
    )
    .animate()
    .fadeIn()
    .slideX(begin: 0.05, end: 0);
  }
  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Generate Reports', style: AppTypography.titleLarge),
          const SizedBox(height: 16),
          
          _buildReportOption(
            'Daily Summary',
            'Generate today\'s incident report',
            Iconsax.document_text,
            () {},
          ),
          _buildReportOption(
            'Weekly Analytics',
            'Security metrics for the past week',
            Iconsax.chart_2,
            () {},
          ),
          _buildReportOption(
            'Monthly Overview',
            'Comprehensive monthly report',
            Iconsax.calendar,
            () {},
          ),
          _buildReportOption(
            'Custom Report',
            'Configure custom date range',
            Iconsax.setting_4,
            () {},
          ),
        ],
      ),
    );
  }
  Widget _buildReportOption(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GlassContainer(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.accent, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.titleSmall),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Iconsax.arrow_right_3,
            color: AppColors.textTertiaryDark,
            size: 20,
          ),
        ],
      ),
    )
    .animate()
    .fadeIn()
    .slideX(begin: 0.05, end: 0);
  }
}
class _UserData {
  final String name;
  final String email;
  final String role;
  final bool isActive;
  
  const _UserData(this.name, this.email, this.role, this.isActive);
}