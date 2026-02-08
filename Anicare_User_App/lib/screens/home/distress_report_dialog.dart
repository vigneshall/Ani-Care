import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../utils/constants.dart';
import '../../providers/distress_provider.dart';

class DistressReportDialog extends StatefulWidget {
  const DistressReportDialog({super.key});

  @override
  State<DistressReportDialog> createState() => _DistressReportDialogState();
}

class _DistressReportDialogState extends State<DistressReportDialog> {
  final _formKey = GlobalKey<FormState>();
  String _location = '';
  String _animalType = '';
  String _severity = '';
  String _description = '';
  bool _isSubmitting = false;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Report Animal in Distress'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                  hintText: 'Enter location or landmark',
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Location is required' : null,
                onSaved: (value) => _location = value ?? '',
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Animal Type',
                  border: OutlineInputBorder(),
                ),
                items: ['Dog', 'Cat', 'Bird', 'Rabbit', 'Other']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: (value) => value == null ? 'Animal type is required' : null,
                onChanged: (value) => setState(() => _animalType = value ?? ''),
                onSaved: (value) => _animalType = value ?? '',
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Severity Level',
                  border: OutlineInputBorder(),
                ),
                items: ['Critical', 'High', 'Medium', 'Low']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: (value) => value == null ? 'Severity is required' : null,
                onChanged: (value) => setState(() => _severity = value ?? ''),
                onSaved: (value) => _severity = value ?? '',
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  hintText: 'Describe the situation...',
                ),
                maxLines: 3,
                validator: (value) => value?.isEmpty ?? true ? 'Description is required' : null,
                onSaved: (value) => _description = value ?? '',
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.camera_alt),
                label: Text(_image == null ? 'Upload Photo' : 'Photo Selected'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
              if (_image != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(_image!, height: 100, width: double.infinity, fit: BoxFit.cover),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          style: IconButton.styleFrom(backgroundColor: Colors.black54),
                          onPressed: () => setState(() => _image = null),
                        ),
                      ),
                    ],
                  ),
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
          onPressed: _isSubmitting ? null : _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.distress,
            foregroundColor: Colors.white,
          ),
          child: _isSubmitting
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('SEND ALERT'),
        ),
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => _isSubmitting = true);

      // Create distress report
      final report = DistressReport(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        location: _location,
        animalType: _animalType,
        severity: _severity,
        description: _description,
        image: _image,
        timestamp: DateTime.now(),
      );

      // Add to provider
      if (mounted) {
        context.read<DistressProvider>().addReport(report);
      }

      // Simulate sending alert
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Severity: $_severity - $_animalType at $_location reported${_image != null ? ' with photo' : ''}'),
            backgroundColor: AppColors.distress,
            duration: const Duration(seconds: 2),
          ),
        );

        Navigator.pop(context);
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }
}
