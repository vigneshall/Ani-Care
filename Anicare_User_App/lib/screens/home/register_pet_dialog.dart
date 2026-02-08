import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/app_models.dart';
import '../../providers/pet_provider.dart';
import '../../utils/constants.dart';

class RegisterPetDialog extends StatefulWidget {
  const RegisterPetDialog({super.key});

  @override
  State<RegisterPetDialog> createState() => _RegisterPetDialogState();
}

class _RegisterPetDialogState extends State<RegisterPetDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _breed;
  late String _gender;
  late String _age;
  late String _healthStatus;
  late String _vaccinationStatus;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Register Pet'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Pet Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Name is required' : null,
                onSaved: (value) => _name = value ?? '',
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Breed',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Breed is required' : null,
                onSaved: (value) => _breed = value ?? '',
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: ['Male', 'Female', 'Unknown']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: (value) => value == null ? 'Gender is required' : null,
                onChanged: (value) => _gender = value ?? '',
                onSaved: (value) => _gender = value ?? '',
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Age is required' : null,
                onSaved: (value) => _age = value ?? '',
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Health Status',
                  border: OutlineInputBorder(),
                ),
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
                items: ['Vaccinated', 'Not Vaccinated', 'Unknown']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: (value) => value == null ? 'Vaccination status is required' : null,
                onChanged: (value) => _vaccinationStatus = value ?? '',
                onSaved: (value) => _vaccinationStatus = value ?? '',
              ),
            ],
          ),
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
          child: const Text('Register'),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final pet = Pet(
        id: DateTime.now().toString(),
        name: _name,
        breed: _breed,
        gender: _gender,
        age: _age,
        healthStatus: _healthStatus,
        vaccinationStatus: _vaccinationStatus,
      );

      context.read<PetProvider>().addPet(pet);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$_name registered successfully!'),
          backgroundColor: AppColors.success,
        ),
      );

      Navigator.pop(context);
    }
  }
}
