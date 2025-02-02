import 'package:flutter/material.dart';
import 'package:mt_valet/generate_qr_code_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 5, 132, 236)),
      home: const GenerateQRCodePage(),
    );
  }
}