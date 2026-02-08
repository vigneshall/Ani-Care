import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class DistressScreen extends StatefulWidget {
  const DistressScreen({super.key});

  @override
  State<DistressScreen> createState() => _DistressScreenState();
}

class _DistressScreenState extends State<DistressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  String? _selectedArea;

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  void _sendAlert() {
    if (_formKey.currentState!.validate() && _selectedArea != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Emergency alert sent successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      _locationController.clear();
      setState(() => _selectedArea = null);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Distress Mode")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: AppColors.distress.withOpacity(0.1),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: AppColors.distress, size: 32),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Report an animal in distress and alert nearby volunteers',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text("Location Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: "Manual Location",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                  hintText: 'Enter street address or landmark',
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Location is required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedArea,
                decoration: const InputDecoration(
                  labelText: "Area",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.map),
                ),
                items: ["Mumbai", "Navi Mumbai", "Kharghar", "Vashi", "Nerul", "Panvel"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedArea = val),
                validator: (value) => value == null ? 'Area is required' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _sendAlert,
                  icon: const Icon(Icons.emergency),
                  label: const Text("SEND EMERGENCY ALERT"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.distress,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
