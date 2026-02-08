import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/pdf_service.dart';
import '../../utils/constants.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rewards & Certificates')),
      body: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          final user = auth.currentUser;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Icon(Icons.emoji_events, size: 64, color: AppColors.primary),
                        const SizedBox(height: 16),
                        Text(
                          '${user?.points ?? 0} Points',
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${user?.totalRescues ?? 0} Total Rescues',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Certificates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 12),
                _buildCertificateCard(
                  context,
                  'Animal Welfare Champion',
                  '10+ Rescues',
                  Icons.workspace_premium,
                  (user?.totalRescues ?? 0) >= 10,
                ),
                _buildCertificateCard(
                  context,
                  'Community Hero',
                  '5+ Rescues',
                  Icons.volunteer_activism,
                  (user?.totalRescues ?? 0) >= 5,
                ),
                _buildCertificateCard(
                  context,
                  'First Responder',
                  '1+ Rescue',
                  Icons.medical_services,
                  (user?.totalRescues ?? 0) >= 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCertificateCard(BuildContext context, String title, String requirement, IconData icon, bool unlocked) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: unlocked ? AppColors.primary : Colors.grey),
        title: Text(title),
        subtitle: Text(requirement),
        trailing: unlocked
            ? ElevatedButton.icon(
                onPressed: () => PDFService.generateCertificate(title),
                icon: const Icon(Icons.download, size: 16),
                label: const Text('Download'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              )
            : const Icon(Icons.lock, color: Colors.grey),
      ),
    );
  }
}
