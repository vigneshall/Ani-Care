import 'package:flutter/material.dart';
import '../../models/training_models.dart';
import '../../utils/constants.dart';
import 'exam_screen.dart';

class ExamsTab extends StatelessWidget {
  const ExamsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final exams = [
      Exam(
        id: '1',
        title: 'Rescue Protocol Exam',
        questionCount: 20,
        timeLimit: 30,
      ),
      Exam(
        id: '2',
        title: 'Medical Assistant Quiz',
        questionCount: 15,
        timeLimit: 20,
      ),
      Exam(
        id: '3',
        title: 'Animal Welfare Laws Test',
        questionCount: 25,
        timeLimit: 40,
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: exams.length,
      itemBuilder: (context, index) {
        final exam = exams[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.warning.withOpacity(0.2),
              child: Icon(Icons.quiz, color: AppColors.warning, size: 30),
            ),
            title: Text(
              exam.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('${exam.questionCount} Questions • ${exam.timeLimit} Minutes'),
            ),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExamScreen(exam: exam),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Start'),
            ),
          ),
        );
      },
    );
  }
}
