import 'package:flutter/material.dart';
import '../../models/training_models.dart';
import '../../utils/constants.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: AppColors.primary,
              child: Center(
                child: Icon(
                  _getIcon(course.icon),
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(course.duration, style: TextStyle(color: AppColors.primary)),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getLevelColor(course.level),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          course.level,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Course Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Course Modules',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...course.modules.asMap().entries.map((entry) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: Text(
                            '${entry.key + 1}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(entry.value),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Successfully enrolled in ${course.title}!'),
                            backgroundColor: AppColors.success,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Enroll Now',
                        style: TextStyle(fontSize: 18),
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

  IconData _getIcon(String icon) {
    switch (icon) {
      case 'medical_services':
        return Icons.medical_services;
      case 'pets':
        return Icons.pets;
      case 'business':
        return Icons.business;
      case 'gavel':
        return Icons.gavel;
      default:
        return Icons.school;
    }
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case 'Beginner':
        return AppColors.success;
      case 'Intermediate':
        return AppColors.warning;
      case 'Advanced':
        return AppColors.distress;
      default:
        return Colors.grey;
    }
  }
}
