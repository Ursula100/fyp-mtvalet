import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUserService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


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
      print("Error saving user on registration: ${e.toString()}");
      rethrow;
    }
  }

  // Returns true or false
  // if return true, user is a customer 
  // if return false, user is not a customer
  Future<bool> isCustomer(String email) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection("priv")
          .where("email", isEqualTo: email)
          .get(); // Returns the count of documents
      return querySnapshot.docs.isEmpty;
    } catch (e) {
      print("Error checking user role: ${e.toString()}");
      rethrow;
    }
  }

  Future<QuerySnapshot> getUserByEmail(String email) async {
    try {
      return await _firestore
          .collection("customers")
          .where("email", isEqualTo: email)
          .get();
    } catch (e) {
      print("Error fetching user using email: ${e.toString()}");
      rethrow; // Rethrow the error for the caller to handle
    }
  }

  Future<QuerySnapshot> getUserById(String id) async {
    try {
      return await _firestore
          .collection("customers")
          .where("customerId", isEqualTo: id)
          .get();
    } catch (e) {
      print("Error fetching user using id: ${e.toString()}");
      rethrow; // Rethrow the error for the caller to handle
    }
  }

}