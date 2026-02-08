import 'package:flutter/material.dart';
import 'dart:io';

class DistressReport {
  final String id;
  final String location;
  final String animalType;
  final String severity;
  final String description;
  final File? image;
  final DateTime timestamp;

  DistressReport({
    required this.id,
    required this.location,
    required this.animalType,
    required this.severity,
    required this.description,
    this.image,
    required this.timestamp,
  });
}

class DistressProvider with ChangeNotifier {
  final List<DistressReport> _reports = [];

  List<DistressReport> get reports => _reports;

  void addReport(DistressReport report) {
    _reports.insert(0, report);
    notifyListeners();
  }
}
