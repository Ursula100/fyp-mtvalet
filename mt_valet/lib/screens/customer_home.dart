import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen ({super.key});

  @override
  CustomerHomeScreenState createState() => CustomerHomeScreenState();
}

class CustomerHomeScreenState extends State<CustomerHomeScreen> {
  TextEditingController controller = TextEditingController();

 late String qrData; // To store the current user's UID

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  // Get the current user's UID
  void _getUserData() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Save the UID to qrData for QR code generation
      qrData = user.uid;
      //setState(() {}); // Refresh the UI to display the QR code
    }
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            margin: EdgeInsets.all(14.0),
            decoration: BoxDecoration(color: const Color.fromARGB(255, 25, 101, 231), borderRadius: BorderRadius.all(Radius.circular(16.0))),
            child: Column(
              children: [
                Text("Scan to Redeem Points", style: TextStyle(color: Colors.white,),),
                Container(height: 8.0,),
                QrImageView(data: qrData, size: 150, dataModuleStyle: QrDataModuleStyle(color: Colors.white, dataModuleShape: QrDataModuleShape.circle,), eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.circle, color: Colors.white,),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}