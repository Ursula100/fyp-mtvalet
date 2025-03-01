import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mt_valet/screens/login.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 64.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Image.asset(
                'assets/images/logo.jpg',
                height: 100,
              ),
              const SizedBox(height: 8),

              const Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // First Name and Last Name in Row
              Row(
                children: [
                  // First Name
                  Expanded(
                    child: Column(
                      children: [
                        /*const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('First Name'),
                        ),*/
                        //const SizedBox(height: 4),
                        TextField(
                          decoration: const InputDecoration(
                            //hintText: 'Enter your First name',
                            border: OutlineInputBorder(),
                            //contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                            label: Text("First Name"),
                            counterText: "",
                          ),
                          maxLength: 25,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 4.0,
                  ),

                  // Last Name
                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            //hintText: 'Your last name',
                            border: OutlineInputBorder(),
                            //contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                            label: Text("Last Name"),
                            counterText: "",
                          ),
                          maxLength: 25,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              
              //Email
              TextField(
                decoration: const InputDecoration(
                  //hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                  //contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  label: Text("Email"),
                  counterText: "",
                ),
                keyboardType: TextInputType.emailAddress,
                maxLength: 25,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
              ),
              const SizedBox(height: 16),

              //Password
              TextField(
                decoration: const InputDecoration(
                  //hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                  //contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  label: Text("Password"),
                  counterText: "",
                ),
                obscureText: true,
                maxLength: 25,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
              ),
              const SizedBox(height: 16),

              // Confirm Password
              TextField(
                decoration: const InputDecoration(
                  //hintText: 'Re-enter your password',
                  border: OutlineInputBorder(),
                  //contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  label: Text("Confirm Password"),
                  counterText: "",
                ),
                obscureText: true,
                maxLength: 25,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
              ),
              const SizedBox(height: 32),

              // Register Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Registration logic
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 5, 76, 229)),
                    foregroundColor: WidgetStatePropertyAll(
                      Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              GestureDetector(
                // Alternative Login Text
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: const Text(
                  'Already have an account? Log in.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color.fromARGB(255, 5, 76, 229)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
