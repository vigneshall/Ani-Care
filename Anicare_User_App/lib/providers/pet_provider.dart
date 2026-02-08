import 'package:flutter/material.dart';
import '../models/app_models.dart';

class PetProvider with ChangeNotifier {
  final List<Pet> _pets = [];
  List<Pet> get pets => _pets;

  void addPet(Pet pet) {
    _pets.add(pet);
    notifyListeners();
  }

  void removePet(String id) {
    _pets.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void deletePet(String id) {
    _pets.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
