import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore library

class DoctorService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadDoctorInfo({
    required String userId,
    required String name,
    required String address,
    required String phoneNumber,
    required String email,
    required String qualifications,
    required String specialization,
    required String hospitalIDPath,
  }) async {
    try {
      // Add doctor information to Firestore
      await _firestore.collection('doctors').doc(userId).set({
        'name': name,
        'address': address,
        'phoneNumber': phoneNumber,
        'email': email,
        'qualifications': qualifications,
        'specialization': specialization,
        // Remove hospital ID URL field
      });

      // Optionally, update the 'type' field in the 'users' collection to 'doctor'
      await _firestore.collection('users').doc(userId).update({
        'type': 'doctor',
      });
    } catch (error) {
      // Handle any errors here
      print('Error uploading doctor info: $error');
    }
  }
}
