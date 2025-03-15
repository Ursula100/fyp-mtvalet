import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mt_valet/widgets/admin_home/qr_scanner.dart';
import 'package:mt_valet/widgets/admin_home/user_info_widget.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController oldPointsController = TextEditingController();
  final TextEditingController updatedPointsController = TextEditingController();
  
  bool isScanning = true; // Controls scanning

  void getCustomerDetailsAndUpdatePoints(String userId) async {
    try {
      DocumentSnapshot userDoc = await firestore.collection("customers").doc(userId).get();

      if (userDoc.exists) {
        String firstName = userDoc.get("firstName") ?? "";
        String lastName = userDoc.get("lastName") ?? "";
        int currentPoints = userDoc.get("points") ?? 0;

        String fullName = "$firstName $lastName";
        int newPoints = (currentPoints < 40) ? currentPoints + 10 : 0;

        setState(() {
          nameController.text = fullName;
          oldPointsController.text = currentPoints.toString();
          updatedPointsController.text = newPoints.toString();
          isScanning = false; // Pause scanning but keep scanner visible
        });

        // Update Firestore
        await firestore.collection("customers").doc(userId).update({"points": newPoints});
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Points updated to $newPoints")),
          );
        }
      } else {
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Customer not found")),
          );
        }
        restartScanner();
      }
    } catch (e) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching customer data")),
        );
      }
      restartScanner();
    }
  }

  void restartScanner() {
    setState(() {
      isScanning = true;
    });
  }

  void clearCustomerDetails() {
    setState(() {
      nameController.clear();
      oldPointsController.clear();
      updatedPointsController.clear();
      isScanning = true;
    });
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
        children: [
          QRScannerWidget(
            isScanning: isScanning, // Pass scanning status to the widget
            onScanned: getCustomerDetailsAndUpdatePoints,
          ),
          
          UserInfoWidget(
            nameController: nameController,
            oldPointsController: oldPointsController,
            updatedPointsController: updatedPointsController,
            onClear: clearCustomerDetails,
          ),
        ],
      ),
    );
  }
}
