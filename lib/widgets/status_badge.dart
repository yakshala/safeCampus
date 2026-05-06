import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
/// Animated status badge with pulsing dot indicator
/// Used for camera status, system health, etc.
class StatusBadge extends StatefulWidget {
  final String label;
  final bool isActive;
  final bool showPulse;
  
  const StatusBadge({
    super.key,
    required this.label,
    required this.isActive,
    this.showPulse = true,
  });
  @override
  State<StatusBadge> createState() => _StatusBadgeState();
}
class _StatusBadgeState extends State<StatusBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    if (widget.isActive && widget.showPulse) {
      _controller.repeat(reverse: true);
    }
  }
  @override
  void didUpdateWidget(StatusBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && widget.showPulse && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isActive || !widget.showPulse) {
      _controller.stop();
      _controller.reset();
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final color = widget.isActive ? AppColors.online : AppColors.offline;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pulsing dot
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  boxShadow: widget.isActive && widget.showPulse
                      ? [
                          BoxShadow(
                            color: color.withOpacity(0.4),
                            blurRadius: 4 * _pulseAnimation.value,
                            spreadRadius: 1 * _pulseAnimation.value,
                          ),
                        ]
                      : null,
                ),
              );
            },
          ),
          const SizedBox(width: 6),
          Text(
            widget.label,
            style: AppTypography.labelSmall.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
/// Simple severity indicator dot
class SeverityDot extends StatelessWidget {
  final Color color;
  final double size;
  
  const SeverityDot({
    super.key,
    required this.color,
    this.size = 8,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }
}