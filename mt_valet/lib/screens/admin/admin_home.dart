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
  final TextEditingController statusMessageController = TextEditingController();

  bool isScanning = true; // Controls scanner state

  Future<void> getCustomerDetailsAndUpdatePoints(String userId) async {
    try {
      DocumentSnapshot userDoc = await firestore.collection("customers").doc(userId).get();

      if (!userDoc.exists) {
        setState(() {
          statusMessageController.text = "Error: Customer not found";
        });
        return;
        
      }

      String firstName = userDoc.get("firstName") ?? "";
      String lastName = userDoc.get("lastName") ?? "";
      int currentPoints = userDoc.get("points") ?? 0;

      int newPoints = (currentPoints < 40) ? currentPoints + 10 : 0;

      await firestore.collection("customers").doc(userId).update({"points": newPoints});

      setState(() {
        nameController.text = "$firstName $lastName";
        oldPointsController.text = currentPoints.toString();
        updatedPointsController.text = newPoints.toString();
        statusMessageController.text = "Points updated to $newPoints";
        isScanning = false; // Pause scanner
      });
    } catch (e) {
      setState(() {
        statusMessageController.text = "Error updating points: $e";
        isScanning = true;
      });
    }
  }

  void clearCustomerDetails() {
    setState(() {
      nameController.clear();
      oldPointsController.clear();
      updatedPointsController.clear();
      statusMessageController.clear();
      isScanning = true; // Resume scanning
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MT Valet"),
        backgroundColor: const Color.fromRGBO(17, 99, 239, 1),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            QRScannerWidget(
              isScanning: isScanning,
              onScanned: getCustomerDetailsAndUpdatePoints,
            ),
            const SizedBox(height: 16),
            UserInfoWidget(
              nameController: nameController,
              oldPointsController: oldPointsController,
              updatedPointsController: updatedPointsController,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: statusMessageController,
              readOnly: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: statusMessageController.text.contains("Error") ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
            ElevatedButton(
              onPressed: clearCustomerDetails,
              child: const Text("Clear"),
            ),
          ],
        ),
      ),
    );
  }
}