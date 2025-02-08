import 'package:flutter/material.dart';
import 'package:mt_valet/generate_qr_code_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mt_valet/screens/login.dart';
import 'firebase_options.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 5, 132, 236)),
      home: const LoginScreen(),
    );
  }
}