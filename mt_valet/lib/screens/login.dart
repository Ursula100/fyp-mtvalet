import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mt_valet/firebase_auth.dart';
import 'package:mt_valet/generate_qr_code_page.dart';
import 'package:mt_valet/screens/registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final FirebaseAuthServices _auth = FirebaseAuthServices();
  
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 64.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.jpg', 
                  height: 100, 
                ),
        
                const SizedBox(height: 8.0),
        
                const Text("Login", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        
                const SizedBox(height: 24.0),
        
                // Email
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Enter your email address",
                    border: OutlineInputBorder(),
                    label: Text("Email")
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
        
                // Password
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Enter your password",
                    border: OutlineInputBorder(),
                    label: Text("Password")
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
        
                const SizedBox(height: 32.0),
        
                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Login logic here
                        _login();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(const Color(0xFF054CE5)),
                      foregroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                ),
        
                const SizedBox(height: 32),
        
                // Go to Registration screen
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationScreen()));
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 33, 114, 243),
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: "Sign Up.",
                          style: TextStyle(
                            color: Color.fromARGB(255, 33, 114, 243),
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Call the sign-up method from FirebaseAuthServices
    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if(user!=null){
      // Check if the widget is still mounted before navigating
      if(mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GenerateQRCodePage()));
      }
    }
    else {
      // Registration Failed
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Failed! Check your details."))
        );
      }
    }
  }
}
