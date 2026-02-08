import 'package:flutter/material.dart';
import '../../models/training_models.dart';
import '../../utils/constants.dart';
import 'course_detail_screen.dart';

class CoursesTab extends StatelessWidget {
  const CoursesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = [
      Course(
        id: '1',
        title: 'Emergency First Aid',
        duration: '4 Hours',
        level: 'Beginner',
        icon: 'medical_services',
        description: 'Learn essential first aid techniques for animals in emergency situations.',
        modules: ['Basic Assessment (1h)', 'Wound Care (1h)', 'CPR Techniques (1h)', 'Emergency Transport (1h)'],
      ),
      Course(
        id: '2',
        title: 'Animal Behavior 101',
        duration: '6 Hours',
        level: 'Intermediate',
        icon: 'pets',
        description: 'Understand animal psychology and behavior patterns.',
        modules: ['Body Language (1.5h)', 'Stress Signals (1.5h)', 'Socialization (1.5h)', 'Training Basics (1.5h)'],
      ),
      Course(
        id: '3',
        title: 'NGO Management',
        duration: '10 Hours',
        level: 'Advanced',
        icon: 'business',
        description: 'Master the skills needed to run an animal welfare NGO.',
        modules: ['Fundraising (2.5h)', 'Team Management (2.5h)', 'Legal Compliance (2.5h)', 'Community Outreach (2.5h)'],
      ),
      Course(
        id: '4',
        title: 'Legal Rights of Animals',
        duration: '3 Hours',
        level: 'Beginner',
        icon: 'gavel',
        description: 'Learn about animal welfare laws and legal protections.',
        modules: ['Indian Laws (1h)', 'Rights & Protection (1h)', 'Reporting Abuse (1h)'],
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Center(
                  child: Icon(
                    _getIcon(course.icon),
                    size: 60,
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
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Chip(
                          label: Text(course.duration),
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          labelStyle: TextStyle(fontSize: 12, color: AppColors.primary),
                        ),
                        const SizedBox(width: 8),
                        Chip(
                          label: Text(course.level),
                          backgroundColor: _getLevelColor(course.level),
                          labelStyle: const TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseDetailScreen(course: course),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Enroll Now'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
