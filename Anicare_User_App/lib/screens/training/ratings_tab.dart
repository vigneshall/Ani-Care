import 'package:flutter/material.dart';
import '../../models/training_models.dart';
import '../../utils/constants.dart';

class RatingsTab extends StatelessWidget {
  const RatingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ratings = [
      NGORating(name: 'Paws Rescue', rating: 4.9, reviewCount: 245),
      NGORating(name: 'Animal Shield', rating: 4.7, reviewCount: 189),
      NGORating(name: 'City Vets NGO', rating: 4.5, reviewCount: 156),
      NGORating(name: 'Pet Care Foundation', rating: 4.3, reviewCount: 132),
      NGORating(name: 'Stray Support', rating: 4.2, reviewCount: 98),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: ratings.length,
      itemBuilder: (context, index) {
        final rating = ratings[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: _getMedalColor(index),
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              rating.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    rating.rating.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${rating.reviewCount} reviews)',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getMedalColor(int index) {
    switch (index) {
      case 0:
        return Colors.amber;
      case 1:
        return Colors.grey.shade400;
      case 2:
        return Colors.brown.shade300;
      default:
        return AppColors.primary;
    }
  }
}
