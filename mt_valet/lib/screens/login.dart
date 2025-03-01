import 'package:flutter/material.dart';
import 'package:mt_valet/screens/registration.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.jpg', 
            height: 100, 
          ),

          SizedBox(height: 8.0),

          Text("Login", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),

          SizedBox(height: 24.0,),

          //Email
          TextField(
              decoration: InputDecoration(
                hintText: "Enter your email address",
                border: OutlineInputBorder(),
                label: Text("Email")
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          SizedBox(height: 16.0,),

          //Password
          TextField(
            decoration: InputDecoration(
              hintText: "Enter your password",
              border: OutlineInputBorder(),
              label: Text("Password")
            ),
            obscureText: true,
          ),

          SizedBox(height: 32.0),

          //Login Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                //login logic
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color(0xFF054CE5)),
                foregroundColor: WidgetStatePropertyAll(
                  Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              child: Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
          ),

          const SizedBox(height: 16),
          
          //Go to Registration screen
          GestureDetector(
            //Signup Text
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
            },
            child: const Text(
              "Don't have an account ? Sign Up. ",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color.fromARGB(255, 33, 114, 243)),
            ),
          ),
        ],
      ),
    ));
  }
}
