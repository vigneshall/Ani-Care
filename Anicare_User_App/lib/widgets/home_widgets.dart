import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../utils/constants.dart';

class PredictionCard extends StatelessWidget {
  final Prediction prediction;
  const PredictionCard({super.key, required this.prediction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(prediction.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const Spacer(),
          Text("${(prediction.riskLevel * 100).toInt()}%", 
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _getColor(prediction.riskLevel))),
          const Text("Risk Level", style: TextStyle(fontSize: 10, color: Colors.grey)),
          const Spacer(),
          Text("Conf: ${prediction.confidence}%", style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  Color _getColor(double level) {
    if (level < 0.3) return AppColors.success;
    if (level < 0.6) return AppColors.warning;
    return AppColors.distress;
  }
}

class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const QuickActionButton({super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 10), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
