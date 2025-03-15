import 'package:flutter/material.dart';
import 'package:mt_valet/screens/admin/admin_home.dart';
import 'package:mt_valet/services/firebase_auth.dart';
import 'package:mt_valet/services/firestore_user.dart';
import 'package:mt_valet/screens/customer/customer_home.dart';
import 'package:mt_valet/screens/auth/registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final FirestoreUserService _user = FirestoreUserService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  String? _errorMessage; // Variable to hold the login error message

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

                const SizedBox(height: 16.0),

                // Error Message if any
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
        
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
    final user = await _auth.signInWithEmailAndPassword(email, password);
    

    if(user != null){

      final userEmail = user.email;

      await loginPerType(userEmail as String);
    }
    else {
      // Login failed
      if(mounted){
        setState(() {
            _errorMessage = "Incorrect email or password.";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Failed!"))
        );
      }
    }
  }

  Future<void> loginPerType(String email) async {
    try {
      final isCustomer = await _user.isCustomer(email);

      if (isCustomer) { // User is a customer
        if (mounted) {
          // Navigate to admin Screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CustomerHomeScreen()),
          );
        }
      } else {
        if (mounted) {
          // Navigate to customer Screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminHomeScreen()),
          );
        }
      }
    } catch (e) {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Failed!"))
        );
      }
    }
  }
}
