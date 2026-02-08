import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/training_models.dart';
import '../../utils/constants.dart';
import 'exam_result_screen.dart';

class ExamScreen extends StatefulWidget {
  final Exam exam;

  const ExamScreen({super.key, required this.exam});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  int currentQuestion = 0;
  Map<int, int> answers = {};
  late Timer timer;
  late int remainingSeconds;
  late List<Question> questions;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.exam.timeLimit * 60;
    questions = _generateQuestions();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
        } else {
          _submitExam();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  List<Question> _generateQuestions() {
    return List.generate(
      widget.exam.questionCount,
      (index) => Question(
        question: 'Sample question ${index + 1} for ${widget.exam.title}?',
        options: ['Option A', 'Option B', 'Option C', 'Option D'],
        correctAnswer: index % 4,
      ),
    );
  }

  void _submitExam() {
    timer.cancel();
    int correct = 0;
    for (int i = 0; i < questions.length; i++) {
      if (answers[i] == questions[i].correctAnswer) {
        correct++;
      }
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ExamResultScreen(
          examTitle: widget.exam.title,
          totalQuestions: questions.length,
          correctAnswers: correct,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return WillPopScope(
      onWillPop: () async {
        final result = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit Exam?'),
            content: const Text('Your progress will be lost.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Exit'),
              ),
            ],
          ),
        );
        return result ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: (currentQuestion + 1) / questions.length,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${currentQuestion + 1} of ${questions.length}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      questions[currentQuestion].question,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 24),
                    ...questions[currentQuestion].options.asMap().entries.map((entry) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        color: answers[currentQuestion] == entry.key
                            ? AppColors.primary.withOpacity(0.2)
                            : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: answers[currentQuestion] == entry.key
                                ? AppColors.primary
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: RadioListTile<int>(
                          value: entry.key,
                          groupValue: answers[currentQuestion],
                          onChanged: (value) {
                            setState(() {
                              answers[currentQuestion] = value!;
                            });
                          },
                          title: Text(entry.value),
                          activeColor: AppColors.primary,
                        ),
                      );
                    }).toList(),
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
                        onPressed: () {
                          setState(() {
                            currentQuestion--;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: AppColors.primary),
                        ),
                        child: const Text('Previous'),
                      ),
                    ),
                  if (currentQuestion > 0) const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (currentQuestion < questions.length - 1) {
                          setState(() {
                            currentQuestion++;
                          });
                        } else {
                          _submitExam();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        currentQuestion < questions.length - 1 ? 'Next' : 'Submit',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
