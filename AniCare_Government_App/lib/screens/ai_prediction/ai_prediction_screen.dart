import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/prediction_charts.dart';
import 'package:fl_chart/fl_chart.dart';

class AIPredictionScreen extends StatelessWidget {
  const AIPredictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AI Prediction Module'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                labelPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                indicatorWeight: 3,
                tabAlignment: TabAlignment.start,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                tabs: const [
                  Tab(child: Text('Outbreak Risk', overflow: TextOverflow.visible)),
                  Tab(child: Text('Budget Forecast', overflow: TextOverflow.visible)),
                  Tab(child: Text('Shelter Demand', overflow: TextOverflow.visible)),
                  Tab(child: Text('Surgery Analysis', overflow: TextOverflow.visible)),
                  Tab(child: Text('Climate Impact', overflow: TextOverflow.visible)),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            _OutbreakRiskTab(),
            _BudgetForecastTab(),
            _ShelterDemandTab(),
            _SurgeryAnalysisTab(),
            _ClimateImpactTab(),
          ],
        ),
      ),
    );
  }
}

class _OutbreakRiskTab extends StatelessWidget {
  const _OutbreakRiskTab();

  @override
  Widget build(BuildContext context) {
    return _buildPredictionSection('City-Wide Outbreak Risk', 'Analyzing disease patterns and transmission risks.', const OutbreakRiskChart());
  }
}

class _BudgetForecastTab extends StatelessWidget {
  const _BudgetForecastTab();

  @override
  Widget build(BuildContext context) {
    return _buildPredictionSection('Budget Forecasting', 'Projecting expenses and CSR inflow for the next fiscal year.', const BudgetForecastChart());
  }
}

class _ShelterDemandTab extends StatelessWidget {
  const _ShelterDemandTab();

  @override
  Widget build(BuildContext context) {
    return _buildPredictionSection('Shelter Demand', 'Predicting area-wise capacity needs and occupancy trends.', const ShelterDemandChart());
  }
}

class _SurgeryAnalysisTab extends StatelessWidget {
  const _SurgeryAnalysisTab();

  @override
  Widget build(BuildContext context) {
    return _buildPredictionSection('Emergency Surgery', 'Analyzing surgery frequency and hospital load success rates.', const SurgeryAnalysisChart());
  }
}

class _ClimateImpactTab extends StatelessWidget {
  const _ClimateImpactTab();

  @override
  Widget build(BuildContext context) {
    return _buildPredictionSection('Climate Impact', 'Correlating weather patterns with seasonal disease risks.', const ClimateImpactChart());
  }
}

Widget _buildPredictionSection(String title, String description, Widget chart) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0,
          color: AppTheme.primaryTeal.withOpacity(0.05),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, color: AppTheme.primaryTeal, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(description, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text('Trend Analysis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: chart,
        ),
        const SizedBox(height: 24),
        const Text('Regional Breakdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: const RegionalChart(),
        ),
        const SizedBox(height: 24),
        const Text('Monthly Comparison', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: const MonthlyChart(),
        ),
        const SizedBox(height: 24),
        const Text('Key Metrics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildMetricRow('Confidence Score', '94%', Icons.verified_user, Colors.blue),
        _buildMetricRow('Risk Level', 'Medium', Icons.warning, Colors.orange),
        _buildMetricRow('Projected Growth', '+12.5%', Icons.trending_up, Colors.green),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text('Generate PDF Report'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryTeal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMetricRow(String label, String value, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(fontSize: 16)),
        const Spacer(),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
