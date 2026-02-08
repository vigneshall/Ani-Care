import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/app_models.dart';

class DoctorService {
  static Future<List<Doctor>> fetchDoctors(String location) async {
    try {
      // Replace with your actual API endpoint
      final response = await http.get(
        Uri.parse('https://api.example.com/doctors?location=$location'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Doctor(
          id: json['id'].toString(),
          name: json['name'],
          specialization: json['specialization'],
          experience: json['experience'],
          clinicName: json['clinicName'],
          location: json['location'],
          phone: json['phone'],
          email: json['email'],
          distance: json['distance'].toDouble(),
        )).toList();
      }
    } catch (e) {
      // Fallback to mock data if API fails
    }
    
    // Mock data for Mumbai locations
    return _getMockDoctors(location);
  }

  static List<Doctor> _getMockDoctors(String location) {
    final allDoctors = [
      Doctor(id: '1', name: 'Dr. Rajesh Sharma', specialization: 'Veterinary Surgeon', experience: 15, clinicName: 'Pet Care Clinic', location: 'Vashi, Navi Mumbai', phone: '+91 98765 43210', email: 'dr.rajesh@petcare.com', distance: 2.3),
      Doctor(id: '2', name: 'Dr. Priya Desai', specialization: 'Small Animal Specialist', experience: 12, clinicName: 'Animal Wellness Center', location: 'Nerul, Navi Mumbai', phone: '+91 98765 43211', email: 'dr.priya@animalwellness.com', distance: 3.5),
      Doctor(id: '3', name: 'Dr. Amit Patel', specialization: 'Emergency Veterinarian', experience: 10, clinicName: 'Emergency Pet Hospital', location: 'Kharghar, Navi Mumbai', phone: '+91 98765 43212', email: 'dr.amit@emergencypet.com', distance: 5.2),
      Doctor(id: '4', name: 'Dr. Sneha Kulkarni', specialization: 'Exotic Animal Specialist', experience: 8, clinicName: 'Exotic Vet Clinic', location: 'Panvel, Navi Mumbai', phone: '+91 98765 43213', email: 'dr.sneha@exoticvet.com', distance: 7.8),
      Doctor(id: '5', name: 'Dr. Vikram Singh', specialization: 'Veterinary Surgeon', experience: 20, clinicName: 'Advanced Animal Care', location: 'Airoli, Navi Mumbai', phone: '+91 98765 43214', email: 'dr.vikram@advancedcare.com', distance: 4.1),
      Doctor(id: '6', name: 'Dr. Meera Joshi', specialization: 'Pet Dermatologist', experience: 9, clinicName: 'Skin & Coat Clinic', location: 'Belapur, Navi Mumbai', phone: '+91 98765 43215', email: 'dr.meera@skincoat.com', distance: 3.9),
      Doctor(id: '7', name: 'Dr. Arjun Nair', specialization: 'Veterinary Dentist', experience: 7, clinicName: 'Pet Dental Care', location: 'Vashi, Navi Mumbai', phone: '+91 98765 43216', email: 'dr.arjun@petdental.com', distance: 2.7),
      Doctor(id: '8', name: 'Dr. Kavita Reddy', specialization: 'Animal Behaviorist', experience: 11, clinicName: 'Behavior & Training Center', location: 'Nerul, Navi Mumbai', phone: '+91 98765 43217', email: 'dr.kavita@behavior.com', distance: 3.2),
      Doctor(id: '9', name: 'Dr. Suresh Kumar', specialization: 'Veterinary Surgeon', experience: 18, clinicName: 'Mumbai Pet Hospital', location: 'Andheri, Mumbai', phone: '+91 98765 43218', email: 'dr.suresh@mumbaivet.com', distance: 12.5),
      Doctor(id: '10', name: 'Dr. Anjali Mehta', specialization: 'Small Animal Specialist', experience: 14, clinicName: 'Care Plus Vet Clinic', location: 'Bandra, Mumbai', phone: '+91 98765 43219', email: 'dr.anjali@careplus.com', distance: 15.3),
      Doctor(id: '11', name: 'Dr. Ramesh Iyer', specialization: 'Emergency Veterinarian', experience: 16, clinicName: '24/7 Pet Emergency', location: 'Powai, Mumbai', phone: '+91 98765 43220', email: 'dr.ramesh@247pet.com', distance: 10.8),
      Doctor(id: '12', name: 'Dr. Pooja Shah', specialization: 'Pet Surgeon', experience: 13, clinicName: 'Advanced Pet Surgery', location: 'Thane, Mumbai', phone: '+91 98765 43221', email: 'dr.pooja@petsurgery.com', distance: 8.4),
    ];

    return allDoctors.where((doc) => 
      doc.location.toLowerCase().contains(location.toLowerCase()) ||
      location.toLowerCase() == 'all mumbai'
    ).toList()..sort((a, b) => a.distance.compareTo(b.distance));
  }
}
