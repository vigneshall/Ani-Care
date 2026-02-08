import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/app_models.dart';
import '../../providers/pet_provider.dart';
import '../../utils/constants.dart';

class UpdatePetDialog extends StatefulWidget {
  const UpdatePetDialog({super.key});

  @override
  State<UpdatePetDialog> createState() => _UpdatePetDialogState();
}

class _UpdatePetDialogState extends State<UpdatePetDialog> {
  final _formKey = GlobalKey<FormState>();
  Pet? _selectedPet;
  String _healthStatus = '';
  String _vaccinationStatus = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Pet Information'),
      content: SingleChildScrollView(
        child: Consumer<PetProvider>(
          builder: (context, petProvider, _) {
            if (petProvider.pets.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No pets registered yet. Please register a pet first.'),
                ),
              );
            }

            return Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<Pet>(
                    decoration: const InputDecoration(
                      labelText: 'Select Pet',
                      border: OutlineInputBorder(),
                    ),
                    items: petProvider.pets
                        .map((pet) => DropdownMenuItem(
                              value: pet,
                              child: Text(pet.name),
                            ))
                        .toList(),
                    validator: (value) => value == null ? 'Please select a pet' : null,
                    onChanged: (value) => setState(() => _selectedPet = value),
                    onSaved: (value) => _selectedPet = value,
                  ),
                  const SizedBox(height: 16),
                  if (_selectedPet != null) ...[
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Health Status',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: _selectedPet!.healthStatus,
                      items: ['Healthy', 'Injured', 'Sick', 'Unknown']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      validator: (value) => value == null ? 'Health status is required' : null,
                      onChanged: (value) => _healthStatus = value ?? '',
                      onSaved: (value) => _healthStatus = value ?? '',
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Vaccination Status',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: _selectedPet!.vaccinationStatus,
                      items: ['Vaccinated', 'Not Vaccinated', 'Unknown']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      validator: (value) => value == null ? 'Vaccination status is required' : null,
                      onChanged: (value) => _vaccinationStatus = value ?? '',
                      onSaved: (value) => _vaccinationStatus = value ?? '',
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: const Text('Update'),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedPet != null) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_selectedPet!.name} updated - Health: $_healthStatus, Vaccination: $_vaccinationStatus'),
          backgroundColor: AppColors.success,
        ),
      );

      Navigator.pop(context);
    }
  }
}
