import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mt_valet/firebase_auth.dart';
import 'package:mt_valet/screens/login.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordValid = false;
  bool _isEmailValid = false;
  bool _showPasswordCriteria = false; // Track if user started typing
  bool _showEmailCriteria = false;

  final Map<String, bool> _passwordCriteria = {
    "At least 8 characters": false,
    "At least one uppercase letter": false,
    "At least one lowercase letter": false,
    "At least one number": false,
    "At least one special character (!@#\$%^&*)": false,
  };

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Password Validation Function
  void _validatePassword(String value) {
    setState(() {
      _showPasswordCriteria = value.isNotEmpty; // Show criteria when user types

      _passwordCriteria["At least 8 characters"] = value.length >= 8;
      _passwordCriteria["At least one uppercase letter"] =
          RegExp(r'[A-Z]').hasMatch(value);
      _passwordCriteria["At least one lowercase letter"] =
          RegExp(r'[a-z]').hasMatch(value);
      _passwordCriteria["At least one number"] =
          RegExp(r'[0-9]').hasMatch(value);
      _passwordCriteria["At least one special character (!@#\$%^&*)"] =
          RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);

      _isPasswordValid = _passwordCriteria.values.every((isValid) => isValid);

      // Hide criteria if all conditions are met
      if (_isPasswordValid) {
        _showPasswordCriteria = false;
      }
    });
  }

  // Validate Email Format
  void _validateEmail(String email) {
    email = email.trim();  // Trim the email to remove leading/trailing spaces

    setState(() {
      // Show email criteria only when the user starts typing
      _showEmailCriteria = email.isNotEmpty;
      _isEmailValid = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 64.0),
          child: Form(
            key: _formKey,
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
                          TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              label: Text("First Name"),
                              border: OutlineInputBorder(),
                              counterText: "", // Hide the counter
                            ),
                            maxLength: 25,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'First Name is required';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 4.0),

                    // Last Name
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              label: Text("Last Name"),
                              border: OutlineInputBorder(),
                              counterText: "", // Hide the counter
                            ),
                            maxLength: 25,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Last Name is required';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    label: Text("Email"),
                    border: OutlineInputBorder(),
                    counterText: "", // Hide the counter
                  ),
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 25,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  onChanged: (value) {
                    _validateEmail(value);
                  },
                  validator: (value) {
                    if (_showEmailCriteria){
                      return 'Please enter a valid email address';
                    }
                    else if (!_isEmailValid) {
                      return 'Email is required';
                    } 
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password
                TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      label: Text("Password"),
                      border: OutlineInputBorder(),
                      counterText: "", // Hide the counter
                    ),
                    obscureText: true,
                    maxLength: 25,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    onChanged: _validatePassword
                ),

                // Dynamic Password Strength Feedback
                // Inline conditional widget rendering using the ...[ spread operator.
                // The spread operator ... expands a list of widgets into the surrounding widget tree.
                // Because The build method expects a list of widgets, but an if statement does not return a widget list.
                if(_showPasswordCriteria) ...[
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _passwordCriteria.entries.map((entry) {
                      return Row(
                        children: [
                          Icon(
                            entry.value ? Icons.check_circle : Icons.cancel,
                            color: entry.value ? Colors.green : Colors.red,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            entry.key,
                            style: TextStyle(
                              color: entry.value ? Colors.green : Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],

                const SizedBox(height: 16),

                // Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    label: Text("Confirm Password"),
                    border: OutlineInputBorder(),
                    counterText: "", // Hide the counter
                  ),
                  obscureText: true,
                  maxLength: 25,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Confirm Password is required';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // First validate the form, then check the password validity
                      if (_formKey.currentState!.validate() && _isPasswordValid) {
                        _signup();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(_isPasswordValid
                          ? const Color.fromARGB(255, 5, 76, 229)
                          : const Color.fromARGB(255, 49, 90, 179)),
                      foregroundColor: WidgetStateProperty.all(
                          const Color.fromARGB(255, 255, 255, 255)),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Go to Login screen
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 33, 114, 243),
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: "Login.",
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

  void _signup() async {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Call the sign-up method from FirebaseAuthServices
    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      // Check if the widget is still mounted before navigating
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } else {
      // Registration Failed
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registration Failed! Please try again.")));
      }
    }
  }
}
