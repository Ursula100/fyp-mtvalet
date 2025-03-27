import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<User?> signUpWithEmailAndPassword (String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch(e){
      print("Error at signUp: ${e.toString()}");
      rethrow;  // Rethrow the error for the caller to handle
    }
  }

  Future<User?> signInWithEmailAndPassword (String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch(e){
      print("Error at signIN: ${e.toString()}");
      // rethrow; no catches yet in login.dart
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

}