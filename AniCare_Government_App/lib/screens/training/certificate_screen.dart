import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';

class CertificateScreen extends StatelessWidget {
  final String courseName;
  final String userName;

  const CertificateScreen({
    super.key,
    required this.courseName,
    this.userName = 'John Doe',
  });

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('MMMM dd, yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificate'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Certificate downloaded!')),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, spreadRadius: 5),
              ],
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.05,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.pets, size: 200),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppTheme.primaryTeal, AppTheme.primaryBlueGreen],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          'CERTIFICATE OF COMPLETION',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'This is to certify that',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        userName,
                        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'has successfully completed',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryTeal.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.primaryTeal, width: 2),
                        ),
                        child: Text(
                          courseName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primaryTeal),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text('Date', style: TextStyle(color: Colors.grey, fontSize: 12)),
                              const SizedBox(height: 8),
                              Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('Certificate ID', style: TextStyle(color: Colors.grey, fontSize: 12)),
                              const SizedBox(height: 8),
                              Text('AC${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      const Divider(),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.pets, color: AppTheme.primaryTeal, size: 24),
                          const SizedBox(width: 8),
                          const Text(
                            'Ani-Care Gov+NGO Platform',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryTeal),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Animal Welfare Training & Certification',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
