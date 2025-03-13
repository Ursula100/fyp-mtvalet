import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';


class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen ({super.key});

  @override
  CustomerHomeScreenState createState() => CustomerHomeScreenState();
}

class CustomerHomeScreenState extends State<CustomerHomeScreen> {
  TextEditingController controller = TextEditingController();

 late String qrData; // To store the current user's UID
 int points = 0;
 final FirebaseAuth auth = FirebaseAuth.instance;
 final FirebaseFirestore firestore = FirebaseFirestore.instance;
 late DocumentReference userDocumentRef;

  @override
  void initState() {
    super.initState();
    points = 0;
    _getUserData();
  }

  // Get the current user's UID
  void _getUserData() {
    User? user = auth.currentUser;

    if (user != null) {
      // Save the UID to qrData for QR code generation
      //qrData = user.uid;
      setState(() {
        qrData = user.uid;
      }); // Refresh the UI to display the QR code

      userDocumentRef = firestore.collection("customers").doc(user.uid);
      _listenForPointsUpdates();
    }
  }

  // Listen for points updates from Firestore
  void _listenForPointsUpdates() {
    userDocumentRef.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        setState(() {
          points = snapshot.get("points") ?? 0;
        });
      }
    });
  }

  // Builds and returns a Lottie animation widget for a specific index
  Widget _buildLottieAnimation(int index) {
    // Calculate the number of completed washes based on points (10 points per wash)
    int washCount = points ~/ 10;  //or (points / 10) as int; 

    String animationFile;
    bool shouldRepeat = false;

    // If the index is less than the number of washes, show a "shiny car" animation
    if (index < washCount) {
      animationFile = "assets/lottie/shiny_car.json";
      shouldRepeat = true;
    } 
    // If the user has completed 4 washes (40 points), display the "free wash" text at index 4
    else if (index == 4 && washCount >= 4) { 
      animationFile = "assets/lottie/free_text.json";
      shouldRepeat = true;
    } 
    // Otherwise, show an "incomplete" animation for unfinished washes
    // When index > wah count e.g 0 washes as index will be 1 (0>1)
    else {
      animationFile = "assets/lottie/incomplete${index + 1}.json";
    }

    return Expanded(
      child: Container(
        width: 60, // Adjust width for even spacing
        height: 60, // Ensure uniform height
        margin: const EdgeInsets.all(5), // Add margin for spacing
        child: Lottie.asset(
          animationFile, 
          repeat: shouldRepeat, // Repeat for completed washes
          animate: shouldRepeat, // Only animate if it's not static
        ), // Load and animate the selected Lottie file
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('MT Valet',),
        backgroundColor: const Color.fromRGBO(17, 99, 239, 1),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //QR code card
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              margin: EdgeInsets.all(14.0),
              decoration: BoxDecoration(color: const Color.fromARGB(255, 25, 101, 231), borderRadius: BorderRadius.all(Radius.circular(16.0))),
              child: Column(
                children: [
                  Text("Scan at payment to Redeem Points", style: TextStyle(color: Colors.white,),),
                  Container(height: 8.0,),
                  QrImageView(data: qrData, size: 150, dataModuleStyle: QrDataModuleStyle(color: Colors.white, dataModuleShape: QrDataModuleShape.circle,), eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.circle, color: Colors.white,),)
                ],
              ),
            ),
            //Points display
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You have ", style: TextStyle(fontSize: 16)),
                  Text(
                    "$points",
                    style: const TextStyle(fontSize: 34, color: Colors.red),
                  ),
                  const Text(" points", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            //Lottie animations 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) => _buildLottieAnimation(index)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}