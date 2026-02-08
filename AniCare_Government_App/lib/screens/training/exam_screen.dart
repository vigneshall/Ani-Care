import 'package:flutter/material.dart';
import 'dart:async';
import '../../theme/app_theme.dart';

class ExamScreen extends StatefulWidget {
  final String title;
  final int totalQuestions;
  final int durationMinutes;

  const ExamScreen({
    super.key,
    required this.title,
    required this.totalQuestions,
    required this.durationMinutes,
  });

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  int currentQuestion = 0;
  Map<int, int> answers = {};
  late Timer timer;
  late int remainingSeconds;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the first step in animal rescue?',
      'options': ['Assess the situation', 'Call for help', 'Approach the animal', 'Take photos'],
      'correct': 0,
    },
    {
      'question': 'Which vital sign should be checked first?',
      'options': ['Temperature', 'Breathing', 'Heart rate', 'Blood pressure'],
      'correct': 1,
    },
    {
      'question': 'What is the emergency contact number for animal rescue?',
      'options': ['100', '101', '102', '1962'],
      'correct': 3,
    },
  ];

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.durationMinutes * 60;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() => remainingSeconds--);
      } else {
        timer.cancel();
        submitExam();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void submitExam() {
    timer.cancel();
    int correct = 0;
    for (var entry in answers.entries) {
      if (entry.value == questions[entry.key]['correct']) correct++;
    }
    int score = ((correct / questions.length) * 100).round();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ExamResultScreen(
          title: widget.title,
          score: score,
          correct: correct,
          total: questions.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    String seconds = (remainingSeconds % 60).toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.timer, size: 20),
                const SizedBox(width: 4),
                Text('$minutes:$seconds', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (currentQuestion + 1) / questions.length,
            backgroundColor: Colors.grey[200],
            color: AppTheme.primaryTeal,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Question ${currentQuestion + 1} of ${questions.length}', style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  Text(questions[currentQuestion]['question'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  ...List.generate(
                    (questions[currentQuestion]['options'] as List).length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () => setState(() => answers[currentQuestion] = index),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: answers[currentQuestion] == index ? AppTheme.primaryTeal.withOpacity(0.1) : Colors.white,
                            border: Border.all(color: answers[currentQuestion] == index ? AppTheme.primaryTeal : Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: answers[currentQuestion] == index ? AppTheme.primaryTeal : Colors.grey),
                                  color: answers[currentQuestion] == index ? AppTheme.primaryTeal : Colors.transparent,
                                ),
                                child: answers[currentQuestion] == index ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(child: Text(questions[currentQuestion]['options'][index])),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (currentQuestion > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => currentQuestion--),
                      child: const Text('Previous'),
                    ),
                  ),
                if (currentQuestion > 0) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentQuestion < questions.length - 1) {
                        setState(() => currentQuestion++);
                      } else {
                        submitExam();
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryTeal, foregroundColor: Colors.white),
                    child: Text(currentQuestion < questions.length - 1 ? 'Next' : 'Submit'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExamResultScreen extends StatelessWidget {
  final String title;
  final int score;
  final int correct;
  final int total;

  const ExamResultScreen({
    super.key,
    required this.title,
    required this.score,
    required this.correct,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    bool passed = score >= 70;

    return Scaffold(
      appBar: AppBar(title: const Text('Exam Results')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(passed ? Icons.check_circle : Icons.cancel, size: 100, color: passed ? AppTheme.successGreen : AppTheme.emergencyRed),
              const SizedBox(height: 24),
              Text(passed ? 'Congratulations!' : 'Keep Trying!', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.primaryTeal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text('$score%', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: passed ? AppTheme.successGreen : AppTheme.emergencyRed)),
                    const SizedBox(height: 8),
                    Text('$correct out of $total correct', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              if (passed)
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.card_membership),
                  label: const Text('Get Certificate'),
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryTeal, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
                ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Exams'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
