import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUserService {
  Future<void> saveUserToFirestore(
      String userId, String firstName, String lastName, String email) async {
    try {
      await FirebaseFirestore.instance.collection("customers").doc(userId).set({
        "customerId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "points": 0, // Initial loyalty points
        "created": DateTime.now(),
      });
    } catch (e) {
      throw Exception("Error saving user to Firestore: ${e.toString()}");
    }
  }
}