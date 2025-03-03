import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRCodePage extends StatefulWidget {
  const GenerateQRCodePage ({super.key});

  @override
  GenerateQRCodePageState createState() => GenerateQRCodePageState();
}

class GenerateQRCodePageState extends State<GenerateQRCodePage> {
  TextEditingController controller = TextEditingController();

  String qrData = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('MT Valet', textAlign: TextAlign.start,),
        backgroundColor: const Color.fromRGBO(17, 99, 239, 1),
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Enter your text'),
            ),
          ),
          Container(height: 16.0,),
          qrData.isNotEmpty 
            ? Container(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              margin: EdgeInsets.fromLTRB(20.0, 0, 36.0, 20.0),
              decoration: BoxDecoration(color: const Color.fromARGB(255, 25, 101, 231), borderRadius: BorderRadius.all(Radius.circular(16.0))),
              child: Column(
                children: [
                  Text("Here is the generated QR code", style: TextStyle(color: Colors.white,),),
                  Container(height: 8.0,),
                  QrImageView(data: qrData, size: 150, dataModuleStyle: QrDataModuleStyle(color: Colors.white, dataModuleShape: QrDataModuleShape.circle,), eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.circle, color: Colors.white,),)
                ],
              ),
            )
            : Container(height: 0,),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  qrData = controller.text;
                });
              },
              child: const Text('GENERATE QR CODE'),
          ),
        ],
      ),
    );
  }
}