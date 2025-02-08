import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 64.0, 24.0, 64.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Image.asset(
                'assets/images/logo.jpg',
                height: 80,
              ),
              const SizedBox(height: 8),

              // Registration Prompt
              /* const Text(
                'Register to create an account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ), */
              const Text(
                'Sign Up For an Account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // First Name and Last Name in Row
              Row(
                children: [
                  // First Name
                  Expanded(
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('First Name'),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Your first name',
                            border: OutlineInputBorder(),
                          ),
                          maxLength: 25,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 4.0,),

                  // Last Name
                  Expanded(
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Last Name'),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Your last name',
                            border: OutlineInputBorder(),
                          ),
                          maxLength: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Email
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Email Address'),
              ),
              const SizedBox(height: 4),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                keyboardType: TextInputType.emailAddress,
                maxLength: 25,
              ),
              const SizedBox(height: 8),

              // Password
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Password'),
              ),
              const SizedBox(height: 4),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                obscureText: true,
                maxLength: 25,
              ),
              const SizedBox(height: 8),

              // Confirm Password
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Confirm Password'),
              ),
              const SizedBox(height: 4),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Re-enter your password',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                obscureText: true,
                maxLength: 25,
              ),
              const SizedBox(height: 16),

              // Register Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Registration logic
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF054CE5)),
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
              const SizedBox(height: 8),

              // Alternative Login Text
              const Text(
                'Already have an account? Log in.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color.fromARGB(255, 33, 114, 243)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
