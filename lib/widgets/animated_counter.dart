import 'package:flutter/material.dart';
/// Animated number counter with smooth rolling effect
/// Creates a premium feel for statistics and metrics
class AnimatedCounter extends StatelessWidget {
  final int value;
  final TextStyle? style;
  final Duration duration;
  final String? prefix;
  final String? suffix;
  
  const AnimatedCounter({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 1200),
    this.prefix,
    this.suffix,
  });
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.toDouble()),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Text(
          '${prefix ?? ''}${value.toInt()}${suffix ?? ''}',
          style: style ?? Theme.of(context).textTheme.displaySmall,
        );
      },
    );
  }
}
/// Animated counter with decimal support
class AnimatedDecimalCounter extends StatelessWidget {
  final double value;
  final int decimals;
  final TextStyle? style;
  final Duration duration;
  final String? prefix;
  final String? suffix;
  
  const AnimatedDecimalCounter({
    super.key,
    required this.value,
    this.decimals = 1,
    this.style,
    this.duration = const Duration(milliseconds: 1200),
    this.prefix,
    this.suffix,
  });
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Text(
          '${prefix ?? ''}${value.toStringAsFixed(decimals)}${suffix ?? ''}',
          style: style ?? Theme.of(context).textTheme.displaySmall,
        );
      },
    );
  }
}