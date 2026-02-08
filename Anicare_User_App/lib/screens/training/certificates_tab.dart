import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/training_models.dart';
import '../../utils/constants.dart';
import 'certificate_screen.dart';

class CertificatesTab extends StatelessWidget {
  const CertificatesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final certificates = [
      Certificate(
        id: '1',
        name: 'Emergency First Aid',
        issueDate: DateTime.now().subtract(const Duration(days: 30)),
        certificateId: 'AC1234567890',
      ),
      Certificate(
        id: '2',
        name: 'Animal Behavior 101',
        issueDate: DateTime.now().subtract(const Duration(days: 60)),
        certificateId: 'AC0987654321',
      ),
    ];

    if (certificates.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.card_membership, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No certificates yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Complete exams to earn certificates',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: certificates.length,
      itemBuilder: (context, index) {
        final certificate = certificates[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.success.withOpacity(0.2),
              child: Icon(Icons.card_membership, color: AppColors.success, size: 30),
            ),
            title: Text(
              certificate.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('Issued: ${DateFormat('MMM dd, yyyy').format(certificate.issueDate)}'),
            ),
            trailing: IconButton(
              icon: Icon(Icons.visibility, color: AppColors.primary),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CertificateScreen(certificate: certificate),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
