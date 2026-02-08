class AppUser {
  final String id;
  final String name;
  final String email;
  final int points;
  final int totalRescues;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.points = 0,
    this.totalRescues = 0,
  });
}

class Pet {
  final String id;
  final String name;
  final String breed;
  final String gender;
  final String age;
  final String healthStatus;
  final String vaccinationStatus;

  Pet({
    required this.id,
    required this.name,
    required this.breed,
    required this.gender,
    required this.age,
    required this.healthStatus,
    required this.vaccinationStatus,
  });
}

class Prediction {
  final String title;
  final double riskLevel; // 0.0 to 1.0
  final double confidence; // 0 to 100
  final DateTime lastUpdated;

  Prediction({
    required this.title,
    required this.riskLevel,
    required this.confidence,
    required this.lastUpdated,
  });
}

class DistressRequest {
  final String id;
  final String userId;
  final String location;
  final String area;
  final String status;
  final DateTime timestamp;

  DistressRequest({
    required this.id,
    required this.userId,
    required this.location,
    required this.area,
    required this.status,
    required this.timestamp,
  });
}

class Doctor {
  final String id;
  final String name;
  final String specialization;
  final int experience;
  final String clinicName;
  final String location;
  final String phone;
  final String email;
  final double distance;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.experience,
    required this.clinicName,
    required this.location,
    required this.phone,
    required this.email,
    required this.distance,
  });
}
