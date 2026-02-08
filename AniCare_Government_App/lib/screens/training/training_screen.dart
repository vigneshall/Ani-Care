import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'course_detail_screen.dart';
import 'exam_screen.dart';
import 'certificate_screen.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Training & Certification'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            tabs: [
              Tab(icon: Icon(Icons.menu_book, color: Colors.white), text: 'Courses'),
              Tab(icon: Icon(Icons.quiz, color: Colors.white), text: 'Exams'),
              Tab(icon: Icon(Icons.card_membership, color: Colors.white), text: 'Certificates'),
              Tab(icon: Icon(Icons.star, color: Colors.white), text: 'Ratings'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCoursesTab(),
            Builder(builder: (context) => _buildExamsTab(context)),
            Builder(builder: (context) => _buildCertificatesTab(context)),
            _buildRatingsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildCoursesTab() {
    final courses = [
      {'title': 'Emergency First Aid', 'duration': '4 Hours', 'level': 'Beginner', 'description': 'Learn essential first aid techniques for animal emergencies including wound care, CPR, and emergency response protocols.', 'enrolled': 245, 'completed': 189, 'icon': Icons.medical_services},
      {'title': 'Animal Behavior 101', 'duration': '6 Hours', 'level': 'Intermediate', 'description': 'Understand animal psychology, body language, and behavioral patterns to improve rescue and care operations.', 'enrolled': 178, 'completed': 142, 'icon': Icons.pets},
      {'title': 'NGO Management', 'duration': '10 Hours', 'level': 'Advanced', 'description': 'Master organizational management, fundraising strategies, and volunteer coordination for animal welfare NGOs.', 'enrolled': 156, 'completed': 98, 'icon': Icons.business_center},
      {'title': 'Legal Rights of Animals', 'duration': '3 Hours', 'level': 'Beginner', 'description': 'Comprehensive overview of animal protection laws, rights, and legal frameworks in India.', 'enrolled': 312, 'completed': 267, 'icon': Icons.gavel},
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
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primaryTeal, AppTheme.primaryBlueGreen],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Icon(course['icon']! as IconData, size: 60, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(course['title']! as String, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.people, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text('${course['enrolled']} enrolled', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        const SizedBox(width: 12),
                        const Icon(Icons.check_circle, size: 16, color: AppTheme.successGreen),
                        const SizedBox(width: 4),
                        Text('${course['completed']} completed', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(course['duration']! as String, style: const TextStyle(color: Colors.grey)),
                        const SizedBox(width: 16),
                        const Icon(Icons.bar_chart, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(course['level']! as String, style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseDetailScreen(
                                title: course['title']! as String,
                                duration: course['duration']! as String,
                                level: course['level']! as String,
                                description: course['description']! as String,
                                enrolled: course['enrolled'] as int,
                                completed: course['completed'] as int,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryTeal,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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

  Widget _buildExamsTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildExamCard(context, 'Rescue Protocol Exam', 20, 30, 156),
        _buildExamCard(context, 'Medical Assistant Quiz', 15, 20, 203),
        _buildExamCard(context, 'Animal Welfare Laws Test', 25, 40, 189),
      ],
    );
  }

  Widget _buildExamCard(BuildContext context, String title, int questions, int time, int registered) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppTheme.warningOrange,
          child: Icon(Icons.assignment, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('$questions Questions • $time Mins'),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.people, size: 14, color: AppTheme.primaryTeal),
                const SizedBox(width: 4),
                Text('$registered registered', style: const TextStyle(color: AppTheme.primaryTeal, fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
        trailing: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExamScreen(
                  title: title,
                  totalQuestions: questions,
                  durationMinutes: time,
                ),
              ),
            );
          },
          child: const Text('Start'),
        ),
      ),
    );
  }

  Widget _buildCertificatesTab(BuildContext context) {
    final certificates = [
      {'name': 'Emergency First Aid', 'date': 'Jan 15, 2024', 'collected': 189},
      {'name': 'Animal Behavior 101', 'date': 'Feb 20, 2024', 'collected': 142},
      {'name': 'NGO Management', 'date': 'Mar 05, 2024', 'collected': 98},
      {'name': 'Legal Rights of Animals', 'date': 'Mar 10, 2024', 'collected': 267},
      {'name': 'Rescue Protocol Exam', 'date': 'Jan 28, 2024', 'collected': 134},
      {'name': 'Medical Assistant Quiz', 'date': 'Feb 12, 2024', 'collected': 178},
      {'name': 'Animal Welfare Laws Test', 'date': 'Mar 18, 2024', 'collected': 156},
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...certificates.map((cert) => Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppTheme.successGreen,
              child: Icon(Icons.card_membership, color: Colors.white),
            ),
            title: Text(cert['name']! as String, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text('Issued: ${cert['date']}'),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.download, size: 14, color: AppTheme.primaryTeal),
                    const SizedBox(width: 4),
                    Text('${cert['collected']} collected', style: const TextStyle(color: AppTheme.primaryTeal, fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.visibility, color: AppTheme.primaryTeal),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CertificateScreen(courseName: cert['name']! as String),
                  ),
                );
              },
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildRatingsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('NGO Leaderboard', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildRatingItem('Paws Rescue', 4.9, '124 Reviews'),
        _buildRatingItem('Animal Shield', 4.7, '89 Reviews'),
        _buildRatingItem('City Vets NGO', 4.5, '56 Reviews'),
      ],
    );
  }

  Widget _buildRatingItem(String name, double rating, String reviews) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(child: Text(name[0])),
      title: Text(name),
      subtitle: Text(reviews),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 20),
          const SizedBox(width: 4),
          Text(rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
