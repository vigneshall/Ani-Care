import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../providers/prediction_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/home_widgets.dart';
import 'register_pet_dialog.dart';
import 'update_pet_dialog.dart';
import 'book_appointment_dialog.dart';
import 'doctor_list_screen.dart';
import 'distress_report_dialog.dart';
import 'reports_screen.dart';
import 'ai_chat_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ani-Care Dashboard"),
        actions: [
          IconButton(icon: const Icon(Icons.person), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Doctors Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DoctorListScreen()),
                ),
                icon: const Icon(Icons.medical_services),
                label: const Text("Contact Doctors / Vets"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Prediction Panel
            const Text("Live Predictions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Consumer<PredictionProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading && provider.predictions.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.predictions.length,
                    itemBuilder: (context, index) {
                      return PredictionCard(prediction: provider.predictions[index]);
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Quick Actions Grid
            const Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                QuickActionButton(
                  icon: Icons.pets,
                  label: "Register",
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => const RegisterPetDialog(),
                  ),
                ),
                QuickActionButton(
                  icon: Icons.update,
                  label: "Update",
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => const UpdatePetDialog(),
                  ),
                ),
                QuickActionButton(
                  icon: Icons.report_problem,
                  label: "Distress",
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => const DistressReportDialog(),
                  ),
                ),
                QuickActionButton(
                  icon: Icons.calendar_today,
                  label: "Book",
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => const BookAppointmentDialog(),
                  ),
                ),
                QuickActionButton(
                  icon: Icons.smart_toy,
                  label: "AI Chat",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AIChatScreen()),
                  ),
                ),
                QuickActionButton(
                  icon: Icons.card_giftcard,
                  label: "Rewards",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  ),
                ),
                QuickActionButton(
                  icon: Icons.description,
                  label: "Reports",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReportsScreen()),
                  ),
                ),
                QuickActionButton(
                  icon: Icons.local_hospital,
                  label: "Vets",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DoctorListScreen()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Charts Section
            const Text("Insights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildChartCard("Injured vs Healthy", _buildPieChart()),
            _buildChartCard("Monthly Rescues", _buildBarChart()),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(height: 200, child: chart),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(value: 70, color: AppColors.success, title: '70%'),
          PieChartSectionData(value: 30, color: AppColors.distress, title: '30%'),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        barGroups: [
          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8, color: AppColors.primary)]),
          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 10, color: AppColors.primary)]),
          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 14, color: AppColors.primary)]),
          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 12, color: AppColors.primary)]),
        ],
      ),
    );
  }
}
