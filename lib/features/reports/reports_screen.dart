import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/glass_card.dart';
/// Reports and analytics screen with interactive charts
/// Displays security metrics and trends
class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});
  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}
class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedPeriod = 'week';
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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPeriodSelector(),
                      const SizedBox(height: 24),
                      _buildIncidentTrendChart(),
                      const SizedBox(height: 24),
                      _buildAlertDistribution(),
                      const SizedBox(height: 24),
                      _buildCameraActivityChart(),
                    ],
                  ),
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
                  'Reports & Analytics',
                  style: AppTypography.headlineSmall,
                ),
                Text(
                  'Security insights',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ],
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
                  Iconsax.export,
                  color: AppColors.accent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildPeriodSelector() {
    final periods = ['day', 'week', 'month', 'year'];
    
    return Row(
      children: periods.map((period) {
        final isSelected = _selectedPeriod == period;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedPeriod = period),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 12),
              margin: EdgeInsets.only(
                right: period != periods.last ? 8 : 0,
              ),
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppColors.accent 
                    : AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  period[0].toUpperCase() + period.substring(1),
                  style: AppTypography.labelMedium.copyWith(
                    color: isSelected 
                        ? AppColors.primaryDark 
                        : AppColors.textSecondaryDark,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    )
    .animate()
    .fadeIn()
    .slideY(begin: -0.1, end: 0);
  }
  Widget _buildIncidentTrendChart() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Incident Trends', style: AppTypography.titleMedium),
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
                    const Icon(
                      Icons.trending_down,
                      color: AppColors.online,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '-12%',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.online,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 10,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.textTertiaryDark.withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                        if (value.toInt() < days.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              days[value.toInt()],
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textTertiaryDark,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 12),
                      FlSpot(1, 18),
                      FlSpot(2, 15),
                      FlSpot(3, 8),
                      FlSpot(4, 14),
                      FlSpot(5, 10),
                      FlSpot(6, 7),
                    ],
                    isCurved: true,
                    color: AppColors.accent,
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.accent.withOpacity(0.3),
                          AppColors.accent.withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )
    .animate()
    .fadeIn(delay: 100.ms)
    .slideY(begin: 0.05, end: 0);
  }
  Widget _buildAlertDistribution() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Alert Distribution', style: AppTypography.titleMedium),
          const SizedBox(height: 24),
          Row(
            children: [
              // Pie chart
              SizedBox(
                width: 120,
                height: 120,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 30,
                    sections: [
                      PieChartSectionData(
                        value: 35,
                        color: AppColors.alertCritical,
                        radius: 25,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: 25,
                        color: AppColors.alertHigh,
                        radius: 25,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: 25,
                        color: AppColors.alertMedium,
                        radius: 25,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: 15,
                        color: AppColors.alertLow,
                        radius: 25,
                        showTitle: false,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              // Legend
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _legendRow('Weapon', 35, AppColors.alertCritical),
                    const SizedBox(height: 12),
                    _legendRow('Crowd', 25, AppColors.alertHigh),
                    const SizedBox(height: 12),
                    _legendRow('Intrusion', 25, AppColors.alertMedium),
                    const SizedBox(height: 12),
                    _legendRow('Other', 15, AppColors.alertLow),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    )
    .animate()
    .fadeIn(delay: 200.ms)
    .slideY(begin: 0.05, end: 0);
  }
  Widget _legendRow(String label, int percentage, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondaryDark,
            ),
          ),
        ),
        Text(
          '$percentage%',
          style: AppTypography.labelMedium,
        ),
      ],
    );
  }
  Widget _buildCameraActivityChart() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Camera Activity', style: AppTypography.titleMedium),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const labels = ['Cam 1', 'Cam 2', 'Cam 3', 'Cam 4', 'Cam 5'];
                        if (value.toInt() < labels.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              labels[value.toInt()],
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textTertiaryDark,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 25,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.textTertiaryDark.withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _makeBarGroup(0, 85),
                  _makeBarGroup(1, 72),
                  _makeBarGroup(2, 95),
                  _makeBarGroup(3, 45),
                  _makeBarGroup(4, 88),
                ],
              ),
            ),
          ),
        ],
      ),
    )
    .animate()
    .fadeIn(delay: 300.ms)
    .slideY(begin: 0.05, end: 0);
  }
  BarChartGroupData _makeBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          gradient: AppColors.accentGradient,
          width: 24,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(6),
          ),
        ),
      ],
    );
  }
}