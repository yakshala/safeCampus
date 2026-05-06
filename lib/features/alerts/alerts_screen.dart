import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/alert_tile.dart';
import '../../widgets/shimmer_loading.dart';
import '../../widgets/empty_state.dart';
import '../../services/mock_data_service.dart';
import 'models/alert_model.dart';
/// Alerts screen showing all security alerts with filtering
/// Color-coded severity and real-time updates
class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});
  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}
class _AlertsScreenState extends State<AlertsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  List<AlertModel> _alerts = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadAlerts();
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  Future<void> _loadAlerts() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      setState(() {
        _alerts = MockDataService.getAlerts();
        _isLoading = false;
      });
    }
  }
  List<AlertModel> _getFilteredAlerts(int tabIndex) {
    switch (tabIndex) {
      case 1:
        return _alerts.where((a) => 
            a.severity == AlertSeverity.critical || 
            a.severity == AlertSeverity.high).toList();
      case 2:
        return _alerts.where((a) => !a.isResolved).toList();
      case 3:
        return _alerts.where((a) => a.isResolved).toList();
      default:
        return _alerts;
    }
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
                  children: List.generate(4, (index) {
                    return _isLoading
                        ? _buildLoadingState()
                        : _buildAlertsList(_getFilteredAlerts(index));
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildHeader() {
    final activeCount = _alerts.where((a) => !a.isResolved).length;
    
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
                  'Security Alerts',
                  style: AppTypography.headlineSmall,
                ),
                Text(
                  '$activeCount active alerts',
                  style: AppTypography.bodySmall.copyWith(
                    color: activeCount > 0 
                        ? AppColors.alertCritical 
                        : AppColors.online,
                  ),
                ),
              ],
            ),
          ),
          // Filter button
          Material(
            color: AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Iconsax.filter,
                  color: AppColors.textPrimaryDark,
                ),
              ),
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
          Tab(text: 'All'),
          Tab(text: 'Critical'),
          Tab(text: 'Active'),
          Tab(text: 'Resolved'),
        ],
      ),
    )
    .animate()
    .fadeIn()
    .slideY(begin: -0.1, end: 0);
  }
  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 5,
      itemBuilder: (_, __) => const ShimmerAlertTile(),
    );
  }
  Widget _buildAlertsList(List<AlertModel> alerts) {
    if (alerts.isEmpty) {
      return EmptyState(
        icon: Iconsax.notification,
        title: 'No Alerts',
        description: 'There are no alerts matching this filter.',
      );
    }
    
    return RefreshIndicator(
      onRefresh: _loadAlerts,
      color: AppColors.accent,
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          return AlertTile(
            alert: alerts[index],
            animationIndex: index,
            onTap: () => _showAlertDetails(alerts[index]),
          );
        },
      ),
    );
  }
  void _showAlertDetails(AlertModel alert) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _AlertDetailsSheet(alert: alert),
    );
  }
}
class _AlertDetailsSheet extends StatelessWidget {
  final AlertModel alert;
  
  const _AlertDetailsSheet({required this.alert});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textTertiaryDark,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            alert.title,
            style: AppTypography.headlineSmall,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Iconsax.location,
                size: 16,
                color: AppColors.textSecondaryDark,
              ),
              const SizedBox(width: 6),
              Text(
                alert.location,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('View Camera'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Resolve'),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
        ],
      ),
    );
  }
}