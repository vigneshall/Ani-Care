import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import 'courses_tab.dart';
import 'exams_tab.dart';
import 'certificates_tab.dart';
import 'ratings_tab.dart';

class TrainingCertificationScreen extends StatelessWidget {
  const TrainingCertificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Training & Certification'),
          bottom: const TabBar(
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            tabs: [
              Tab(text: 'Courses'),
              Tab(text: 'Exams'),
              Tab(text: 'Certificates'),
              Tab(text: 'Ratings'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CoursesTab(),
            ExamsTab(),
            CertificatesTab(),
            RatingsTab(),
          ],
        ),
      ),
    );
  }
}
