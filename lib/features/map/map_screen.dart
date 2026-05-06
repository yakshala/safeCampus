import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/glass_card.dart';
/// Campus map screen with incident markers
/// Shows real-time location of security events
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}
class _MapScreenState extends State<MapScreen> {
  final List<_MapIncident> _incidents = [
    _MapIncident(
      id: '1',
      title: 'Weapon Detected',
      location: 'Main Entrance',
      type: 'critical',
      position: const Offset(0.3, 0.4),
    ),
    _MapIncident(
      id: '2',
      title: 'Overcrowding',
      location: 'Cafeteria',
      type: 'high',
      position: const Offset(0.6, 0.5),
    ),
    _MapIncident(
      id: '3',
      title: 'Suspicious Activity',
      location: 'Parking Lot A',
      type: 'medium',
      position: const Offset(0.2, 0.7),
    ),
  ];
  _MapIncident? _selectedIncident;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 0.15],
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
              Expanded(
                child: Stack(
                  children: [
                    // Map placeholder (replace with Google Maps)
                    _buildMapPlaceholder(),
                    
                    // Incident markers
                    ..._buildMarkers(),
                    
                    // Legend
                    Positioned(
                      right: 16,
                      bottom: 100,
                      child: _buildLegend(),
                    ),
                    
                    // Selected incident card
                    if (_selectedIncident != null)
                      Positioned(
                        left: 20,
                        right: 20,
                        bottom: 24,
                        child: _buildIncidentCard(_selectedIncident!),
                      ),
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
            child: Text(
              'Campus Map',
              style: AppTypography.headlineSmall,
            ),
          ),
          Material(
            color: AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Iconsax.gps,
                  color: AppColors.accent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildMapPlaceholder() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.textTertiaryDark.withOpacity(0.2),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Grid pattern to simulate map
            CustomPaint(
              painter: _GridPainter(),
            ),
            // Campus buildings overlay
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Iconsax.map,
                    size: 48,
                    color: AppColors.textTertiaryDark.withOpacity(0.5),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Campus Map View',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.textSecondaryDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap markers to view incidents',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textTertiaryDark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  List<Widget> _buildMarkers() {
    return _incidents.map((incident) {
      return Positioned(
        left: 20 + (MediaQuery.of(context).size.width - 40) * incident.position.dx - 20,
        top: 80 + (MediaQuery.of(context).size.height * 0.5) * incident.position.dy - 20,
        child: GestureDetector(
          onTap: () => setState(() => _selectedIncident = incident),
          child: _buildMarker(incident),
        ),
      );
    }).toList();
  }
  Widget _buildMarker(_MapIncident incident) {
    final color = _getTypeColor(incident.type);
    final isSelected = _selectedIncident?.id == incident.id;
    
    return AnimatedScale(
      scale: isSelected ? 1.2 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
        ),
        child: const Icon(
          Iconsax.warning_2,
          color: Colors.white,
          size: 18,
        ),
      )
      .animate(onPlay: (controller) => controller.repeat())
      .scale(
        begin: const Offset(1, 1),
        end: const Offset(1.1, 1.1),
        duration: 1000.ms,
      )
      .then()
      .scale(
        begin: const Offset(1.1, 1.1),
        end: const Offset(1, 1),
        duration: 1000.ms,
      ),
    );
  }
  Widget _buildLegend() {
    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _legendItem(AppColors.alertCritical, 'Critical'),
          const SizedBox(height: 8),
          _legendItem(AppColors.alertHigh, 'High'),
          const SizedBox(height: 8),
          _legendItem(AppColors.alertMedium, 'Medium'),
        ],
      ),
    )
    .animate()
    .fadeIn(delay: 300.ms)
    .slideX(begin: 0.2, end: 0);
  }
  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppTypography.labelSmall,
        ),
      ],
    );
  }
  Widget _buildIncidentCard(_MapIncident incident) {
    final color = _getTypeColor(incident.type);
    
    return GlassCard(
      padding: const EdgeInsets.all(16),
      onTap: () {},
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Iconsax.warning_2,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  incident.title,
                  style: AppTypography.titleSmall,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Iconsax.location,
                      size: 14,
                      color: AppColors.textTertiaryDark,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      incident.location,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _selectedIncident = null),
            icon: const Icon(Iconsax.close_circle),
            color: AppColors.textTertiaryDark,
          ),
        ],
      ),
    )
    .animate()
    .fadeIn()
    .slideY(begin: 0.2, end: 0);
  }
  Color _getTypeColor(String type) {
    switch (type) {
      case 'critical':
        return AppColors.alertCritical;
      case 'high':
        return AppColors.alertHigh;
      case 'medium':
        return AppColors.alertMedium;
      default:
        return AppColors.alertLow;
    }
  }
}
class _MapIncident {
  final String id;
  final String title;
  final String location;
  final String type;
  final Offset position;
  
  const _MapIncident({
    required this.id,
    required this.title,
    required this.location,
    required this.type,
    required this.position,
  });
}
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textTertiaryDark.withOpacity(0.1)
      ..strokeWidth = 1;
    const spacing = 30.0;
    
    // Vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    
    // Horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}