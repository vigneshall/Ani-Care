import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/app_models.dart';
import 'pet_provider.dart';

class PredictionProvider with ChangeNotifier {
  List<Prediction> _predictions = [];
  List<Prediction> get predictions => _predictions;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Timer? _timer;
  final Random _random = Random();
  PetProvider? _petProvider;

  PredictionProvider();

  void setPetProvider(PetProvider petProvider) {
    _petProvider = petProvider;
    _fetchPredictions();
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _fetchPredictions();
    });
  }

  Future<void> _fetchPredictions() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call/ML model processing
    await Future.delayed(const Duration(seconds: 1));
    
    final hasPets = _petProvider?.pets.isNotEmpty ?? false;
    
    if (hasPets) {
      // Dynamic predictions when pets are registered
      _predictions = [
        Prediction(
          title: "Health Risk",
          riskLevel: _random.nextDouble() * 0.5,
          confidence: 75 + _random.nextInt(20).toDouble(),
          lastUpdated: DateTime.now(),
        ),
        Prediction(
          title: "Distress Prob",
          riskLevel: _random.nextDouble() * 0.3,
          confidence: 80 + _random.nextInt(15).toDouble(),
          lastUpdated: DateTime.now(),
        ),
        Prediction(
          title: "Disease Outbreak",
          riskLevel: _random.nextDouble() * 0.6,
          confidence: 70 + _random.nextInt(20).toDouble(),
          lastUpdated: DateTime.now(),
        ),
        Prediction(
          title: "Feeding Shortage",
          riskLevel: _random.nextDouble() * 0.2,
          confidence: 85 + _random.nextInt(15).toDouble(),
          lastUpdated: DateTime.now(),
        ),
        Prediction(
          title: "Construction Impact",
          riskLevel: _random.nextDouble() * 0.7,
          confidence: 65 + _random.nextInt(25).toDouble(),
          lastUpdated: DateTime.now(),
        ),
      ];
    } else {
      // Static predictions when no pets registered
      _predictions = [
        Prediction(
          title: "Health Risk",
          riskLevel: 0.25,
          confidence: 85.0,
          lastUpdated: DateTime.now(),
        ),
        Prediction(
          title: "Distress Prob",
          riskLevel: 0.15,
          confidence: 90.0,
          lastUpdated: DateTime.now(),
        ),
        Prediction(
          title: "Disease Outbreak",
          riskLevel: 0.35,
          confidence: 80.0,
          lastUpdated: DateTime.now(),
        ),
        Prediction(
          title: "Feeding Shortage",
          riskLevel: 0.10,
          confidence: 92.0,
          lastUpdated: DateTime.now(),
        ),
        Prediction(
          title: "Construction Impact",
          riskLevel: 0.45,
          confidence: 75.0,
          lastUpdated: DateTime.now(),
        ),
      ];
    }

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
