import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();

    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:  [
          const Expanded(
            flex: 40,
            child: Image(
                fit: BoxFit.cover,
                image: NetworkImage("https://www.sonashomehealth.com/wp-content/uploads/2018/03/Elderly-Care-Tips-for-Caregivers.jpg")),
          ),
          Expanded(
              flex: 10,
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: const Text(
                  "Please login here",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              )
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children:  [
                TextField(
                  controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    )
                ),
                TextField(
                  controller: passController,
                      obscureText: true,
                      decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password'
                    )
                ),
              ],
            )
          ),
          const Text("Forgot password?"),
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children:  [
                ElevatedButton(
                  onPressed: signIn,
                  child: Text("Login"),
                ),
                   Text("Or Sign Up?")
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(), password: passController.text.trim());
  }
}


