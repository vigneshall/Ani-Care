import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_theme.dart';

class RegionalChart extends StatelessWidget {
  const RegionalChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 12, color: AppTheme.accentBlue, width: 18)]),
          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 18, color: AppTheme.primaryTeal, width: 18)]),
          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 9, color: AppTheme.successGreen, width: 18)]),
          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 15, color: AppTheme.warningOrange, width: 18)]),
          BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 11, color: AppTheme.emergencyRed, width: 18)]),
        ],
      ),
    );
  }
}

class MonthlyChart extends StatelessWidget {
  const MonthlyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [const FlSpot(0, 4), const FlSpot(1, 5), const FlSpot(2, 4.5), const FlSpot(3, 6), const FlSpot(4, 7), const FlSpot(5, 6.5), const FlSpot(6, 8)],
            isCurved: true,
            color: AppTheme.primaryTeal,
            barWidth: 3,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(show: true, color: AppTheme.primaryTeal.withOpacity(0.2)),
          ),
        ],
      ),
    );
  }
}

class OutbreakRiskChart extends StatelessWidget {
  const OutbreakRiskChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 3),
              const FlSpot(1, 4),
              const FlSpot(2, 3.5),
              const FlSpot(3, 5),
              const FlSpot(4, 6),
              const FlSpot(5, 5.5),
              const FlSpot(6, 7),
            ],
            isCurved: true,
            color: AppTheme.emergencyRed,
            barWidth: 3,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(show: true, color: AppTheme.emergencyRed.withOpacity(0.2)),
          ),
        ],
      ),
    );
  }
}

class BudgetForecastChart extends StatelessWidget {
  const BudgetForecastChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8, color: AppTheme.primaryTeal, width: 20)]),
          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 10, color: AppTheme.primaryTeal, width: 20)]),
          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 14, color: AppTheme.primaryTeal, width: 20)]),
          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 15, color: AppTheme.accentBlue, width: 20)]),
          BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 13, color: AppTheme.accentBlue, width: 20)]),
        ],
      ),
    );
  }
}

class ShelterDemandChart extends StatelessWidget {
  const ShelterDemandChart({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(value: 35, color: AppTheme.primaryTeal, title: '35%', radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          PieChartSectionData(value: 25, color: AppTheme.accentBlue, title: '25%', radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          PieChartSectionData(value: 20, color: AppTheme.successGreen, title: '20%', radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          PieChartSectionData(value: 20, color: AppTheme.warningOrange, title: '20%', radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class SurgeryAnalysisChart extends StatelessWidget {
  const SurgeryAnalysisChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [const FlSpot(0, 5), const FlSpot(1, 6), const FlSpot(2, 5.5), const FlSpot(3, 7), const FlSpot(4, 8), const FlSpot(5, 7.5), const FlSpot(6, 9)],
            isCurved: true,
            color: AppTheme.successGreen,
            barWidth: 3,
            dotData: const FlDotData(show: true),
          ),
          LineChartBarData(
            spots: [const FlSpot(0, 3), const FlSpot(1, 4), const FlSpot(2, 3.5), const FlSpot(3, 5), const FlSpot(4, 5.5), const FlSpot(5, 5), const FlSpot(6, 6)],
            isCurved: true,
            color: AppTheme.emergencyRed,
            barWidth: 3,
            dotData: const FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}

class ClimateImpactChart extends StatelessWidget {
  const ClimateImpactChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 6, color: AppTheme.accentBlue, width: 15), BarChartRodData(toY: 8, color: AppTheme.warningOrange, width: 15)]),
          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 8, color: AppTheme.accentBlue, width: 15), BarChartRodData(toY: 10, color: AppTheme.warningOrange, width: 15)]),
          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 5, color: AppTheme.accentBlue, width: 15), BarChartRodData(toY: 7, color: AppTheme.warningOrange, width: 15)]),
          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 7, color: AppTheme.accentBlue, width: 15), BarChartRodData(toY: 9, color: AppTheme.warningOrange, width: 15)]),
        ],
      ),
    );
  }
}
