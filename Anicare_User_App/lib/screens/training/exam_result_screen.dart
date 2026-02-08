import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/training_models.dart';
import '../../utils/constants.dart';
import 'certificate_screen.dart';

class ExamResultScreen extends StatelessWidget {
  final String examTitle;
  final int totalQuestions;
  final int correctAnswers;

  const ExamResultScreen({
    super.key,
    required this.examTitle,
    required this.totalQuestions,
    required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (correctAnswers / totalQuestions * 100).round();
    final passed = percentage >= 70;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: passed
                ? [AppColors.success.withOpacity(0.8), AppColors.success]
                : [AppColors.distress.withOpacity(0.8), AppColors.distress],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Card(
              margin: const EdgeInsets.all(24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      passed ? Icons.check_circle : Icons.cancel,
                      size: 100,
                      color: passed ? AppColors.success : AppColors.distress,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      passed ? 'Congratulations!' : 'Keep Trying!',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '$percentage%',
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: passed ? AppColors.success : AppColors.distress,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$correctAnswers out of $totalQuestions correct',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 32),
                    if (passed)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            final certificate = Certificate(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                              name: examTitle,
                              issueDate: DateTime.now(),
                              certificateId: 'AC${DateTime.now().millisecondsSinceEpoch}',
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CertificateScreen(certificate: certificate),
                              ),
                            );
                          },
                          icon: const Icon(Icons.card_membership),
                          label: const Text('Get Certificate'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Back to Exams'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
