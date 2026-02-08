import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/app_models.dart';
import '../../providers/pet_provider.dart';
import '../../utils/constants.dart';

class BookAppointmentDialog extends StatefulWidget {
  const BookAppointmentDialog({super.key});

  @override
  State<BookAppointmentDialog> createState() => _BookAppointmentDialogState();
}

class _BookAppointmentDialogState extends State<BookAppointmentDialog> {
  final _formKey = GlobalKey<FormState>();
  Pet? _selectedPet;
  String _vetName = '';
  String _appointmentType = '';
  DateTime? _selectedDate;
  String _selectedTime = '';

  final List<String> _appointmentTypes = [
    'General Checkup',
    'Vaccination',
    'Treatment',
    'Dental',
    'Surgery Consultation',
  ];

  final List<String> _timeSlots = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Book Appointment'),
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
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Vet Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value?.isEmpty ?? true ? 'Vet name is required' : null,
                    onSaved: (value) => _vetName = value ?? '',
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Appointment Type',
                      border: OutlineInputBorder(),
                    ),
                    items: _appointmentTypes
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    validator: (value) => value == null ? 'Appointment type is required' : null,
                    onChanged: (value) => setState(() => _appointmentType = value ?? ''),
                    onSaved: (value) => _appointmentType = value ?? '',
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'Select Date'
                                : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Time Slot',
                      border: OutlineInputBorder(),
                    ),
                    items: _timeSlots
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    validator: (value) => value == null ? 'Time slot is required' : null,
                    onChanged: (value) => setState(() => _selectedTime = value ?? ''),
                    onSaved: (value) => _selectedTime = value ?? '',
                  ),
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
          child: const Text('Book'),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        _selectedPet != null &&
        _selectedDate != null) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Appointment booked for ${_selectedPet!.name} with $_vetName on ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year} at $_selectedTime - Type: $_appointmentType',
          ),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 3),
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
