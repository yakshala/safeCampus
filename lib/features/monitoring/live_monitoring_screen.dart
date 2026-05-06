import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/camera_card.dart';
import '../../widgets/shimmer_loading.dart';
import '../../widgets/glass_card.dart';
import '../../services/mock_data_service.dart';
import '../../models/camera_model.dart';
/// Live camera monitoring screen with grid layout
/// Displays all camera feeds with status indicators
class LiveMonitoringScreen extends StatefulWidget {
  const LiveMonitoringScreen({super.key});
  @override
  State<LiveMonitoringScreen> createState() => _LiveMonitoringScreenState();
}
class _LiveMonitoringScreenState extends State<LiveMonitoringScreen> {
  bool _isLoading = true;
  List<CameraModel> _cameras = [];
  String _filterStatus = 'all'; // 'all', 'online', 'offline', 'alert'
  @override
  void initState() {
    super.initState();
    _loadCameras();
  }
  Future<void> _loadCameras() async {
    // Simulate API loading
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() {
        _cameras = MockDataService.getCameras();
        _isLoading = false;
      });
    }
  }
  List<CameraModel> get _filteredCameras {
    switch (_filterStatus) {
      case 'online':
        return _cameras.where((c) => c.isOnline).toList();
      case 'offline':
        return _cameras.where((c) => !c.isOnline).toList();
      case 'alert':
        return _cameras.where((c) => c.hasActiveAlert).toList();
      default:
        return _cameras;
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
              // Header
              _buildHeader(),
              
              // Filter chips
              _buildFilterChips(),
              
              // Camera grid
              Expanded(
                child: _isLoading
                    ? _buildLoadingGrid()
                    : _buildCameraGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildHeader() {
    final onlineCount = _cameras.where((c) => c.isOnline).length;
    
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Back button
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
                      'Live Monitoring',
                      style: AppTypography.headlineSmall,
                    ),
                    Text(
                      '$onlineCount of ${_cameras.length} cameras online',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Grid/List toggle
              GlassContainer(
                padding: const EdgeInsets.all(10),
                borderRadius: 12,
                child: const Icon(
                  Iconsax.grid_2,
                  color: AppColors.accent,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildFilterChips() {
    final filters = [
      _FilterChip('All', 'all', _cameras.length),
      _FilterChip('Online', 'online', _cameras.where((c) => c.isOnline).length),
      _FilterChip('Offline', 'offline', _cameras.where((c) => !c.isOnline).length),
      _FilterChip('Alerts', 'alert', _cameras.where((c) => c.hasActiveAlert).length),
    ];
    
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = _filterStatus == filter.value;
          
          return GestureDetector(
            onTap: () => setState(() => _filterStatus = filter.value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppColors.accent 
                    : AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected 
                      ? AppColors.accent 
                      : Colors.transparent,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    filter.label,
                    style: AppTypography.labelMedium.copyWith(
                      color: isSelected 
                          ? AppColors.primaryDark 
                          : AppColors.textSecondaryDark,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? AppColors.primaryDark.withOpacity(0.2)
                          : AppColors.textTertiaryDark.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${filter.count}',
                      style: AppTypography.badge.copyWith(
                        color: isSelected 
                            ? AppColors.primaryDark 
                            : AppColors.textSecondaryDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .animate()
          .fadeIn(delay: Duration(milliseconds: 50 * index));
        },
      ),
    );
  }
  Widget _buildLoadingGrid() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: 6,
        itemBuilder: (context, index) => const ShimmerCameraCard(),
      ),
    );
  }
  Widget _buildCameraGrid() {
    final cameras = _filteredCameras;
    
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: cameras.length,
      itemBuilder: (context, index) {
        return CameraCard(
          camera: cameras[index],
          animationIndex: index,
          onTap: () {
            // Open full-screen camera view
          },
        );
      },
    );
  }
}
class _FilterChip {
  final String label;
  final String value;
  final int count;
  
  const _FilterChip(this.label, this.value, this.count);
}