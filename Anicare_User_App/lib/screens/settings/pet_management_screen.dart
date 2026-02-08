import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/pet_provider.dart';
import '../../utils/constants.dart';
import '../home/register_pet_dialog.dart';
import '../home/update_pet_dialog.dart';

class PetManagementScreen extends StatelessWidget {
  const PetManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => const RegisterPetDialog(),
            ),
          ),
        ],
      ),
      body: Consumer<PetProvider>(
        builder: (context, provider, _) {
          if (provider.pets.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pets, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('No pets registered', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => const RegisterPetDialog(),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('Register Pet'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.pets.length,
            itemBuilder: (context, index) {
              final pet = provider.pets[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Icon(Icons.pets, color: AppColors.primary),
                  ),
                  title: Text(pet.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${pet.breed} • ${pet.age} • ${pet.gender}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: AppColors.primary),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => const UpdatePetDialog(),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDelete(context, provider, pet.id),
                      ),
                    ],
                  ),
                  onTap: () => _showPetDetails(context, pet),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showPetDetails(BuildContext context, pet) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(pet.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Breed', pet.breed),
            _buildDetailRow('Gender', pet.gender),
            _buildDetailRow('Age', pet.age),
            _buildDetailRow('Health Status', pet.healthStatus),
            _buildDetailRow('Vaccination', pet.vaccinationStatus),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, PetProvider provider, String petId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Pet'),
        content: const Text('Are you sure you want to delete this pet?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              provider.deletePet(petId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Pet deleted successfully')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
