import 'dart:math';

class MLService {
  // Mock ML prediction logic
  static Map<String, double> getPredictions() {
    final random = Random();
    return {
      "Health Risk": random.nextDouble(),
      "Distress Probability": random.nextDouble(),
      "Disease Outbreak": random.nextDouble(),
      "Feeding Shortage": random.nextDouble(),
      "Construction Impact": random.nextDouble(),
    };
  }
}
