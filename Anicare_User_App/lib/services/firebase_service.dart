import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Auth
  Stream<User?> get user => _auth.authStateChanges();

  // Firestore example
  Future<void> addPet(Map<String, dynamic> petData) {
    return _db.collection('pets').add(petData);
  }

  Stream<QuerySnapshot> getPets(String userId) {
    return _db.collection('pets').where('userId', isEqualTo: userId).snapshots();
  }
}
