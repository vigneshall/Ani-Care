import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../providers/distress_provider.dart';

class Report {
  final String id;
  final String title;
  final String type;
  final DateTime date;
  final String status;
  final String description;

  Report({
    required this.id,
    required this.title,
    required this.type,
    required this.date,
    required this.status,
    required this.description,
  });
}

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports & Activities'),
        elevation: 0,
      ),
      body: Consumer<DistressProvider>(
        builder: (context, provider, _) {
          final distressReports = provider.reports;
          
          return Column(
            children: [
              // Filter chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    _buildFilterChip('All'),
                    _buildFilterChip('Distress Report'),
                  ],
                ),
              ),
              // Reports list
              Expanded(
                child: distressReports.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.report_off, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('No distress reports yet', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: distressReports.length,
                        itemBuilder: (context, index) {
                          return _buildDistressReportCard(distressReports[index]);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() => _selectedFilter = label);
        },
        backgroundColor: Colors.grey[200],
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildDistressReportCard(DistressReport report) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: Icon(
          Icons.warning,
          color: _getSeverityColor(report.severity),
        ),
        title: Text(
          '${report.animalType} in Distress',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(report.location),
        trailing: _buildSeverityBadge(report.severity),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDate(report.timestamp),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    _buildSeverityBadge(report.severity),
                  ],
                ),
                const SizedBox(height: 12),
                _buildInfoRow('Animal Type', report.animalType),
                _buildInfoRow('Location', report.location),
                const SizedBox(height: 8),
                const Text(
                  'Description:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(report.description, style: const TextStyle(height: 1.5)),
                if (report.image != null)
                  const SizedBox(height: 12),
                if (report.image != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      report.image!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'Critical':
        return Colors.red;
      case 'High':
        return Colors.orange;
      case 'Medium':
        return Colors.yellow[700]!;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Widget _buildSeverityBadge(String severity) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: _getSeverityColor(severity),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        severity,
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
