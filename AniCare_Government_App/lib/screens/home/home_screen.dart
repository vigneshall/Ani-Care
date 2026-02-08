import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/interactive_map.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Government Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Notifications'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.warning, color: AppTheme.emergencyRed),
                        title: const Text('Emergency Alert'),
                        subtitle: const Text('12 new emergencies reported'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.info, color: AppTheme.infoBlue),
                        title: const Text('System Update'),
                        subtitle: const Text('New features available'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: AppTheme.primaryTeal,
                        child: Icon(Icons.person, size: 40, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      const Text('Government Officer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const Text('officer@anicare.gov', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 24),
                      ListTile(
                        leading: const Icon(Icons.person_outline),
                        title: const Text('View Profile'),
                        onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings_outlined),
                        title: const Text('Settings'),
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: AppTheme.primaryTeal,
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overview Panel',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: const [
                StatCard(
                  title: 'Active Animals',
                  value: '1,284',
                  icon: Icons.pets,
                  color: AppTheme.accentBlue,
                ),
                StatCard(
                  title: 'Total Rescues',
                  value: '452',
                  icon: Icons.health_and_safety,
                  color: AppTheme.successGreen,
                ),
                StatCard(
                  title: 'Emergencies',
                  value: '12',
                  icon: Icons.emergency,
                  color: AppTheme.emergencyRed,
                ),
                StatCard(
                  title: 'Disease Alerts',
                  value: '5',
                  icon: Icons.warning_amber,
                  color: AppTheme.warningOrange,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Smart Geo Map & Heatmap',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey[300]!),
              ),
              clipBehavior: Clip.antiAlias,
              child: const InteractiveMap(),
            ),
            const SizedBox(height: 24),
            const Text(
              'NGO Performance Index',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildNGOList(),
          ],
        ),
      ),
    );
  }

  Widget _buildNGOList() {
    final ngos = [
      {'name': 'Paws Rescue', 'score': '9.8', 'status': 'Excellent'},
      {'name': 'Animal Shield', 'score': '8.5', 'status': 'Good'},
      {'name': 'City Vets NGO', 'score': '7.2', 'status': 'Average'},
    ];

    return Column(
      children: ngos.map((ngo) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppTheme.primaryTeal.withOpacity(0.1),
            child: Text(ngo['name']![0], style: const TextStyle(color: AppTheme.primaryTeal, fontWeight: FontWeight.bold)),
          ),
          title: Text(ngo['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Status: ${ngo['status']}'),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.primaryTeal,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              ngo['score']!,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      )).toList(),
    );
  }
}
