import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
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
              children: const [
                TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    )
                ),
                TextField(
                      obscureText: true,
                      decoration: InputDecoration(
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
              children: const [
                ElevatedButton(
                  onPressed: signin,
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
}

void signin() {
  debugPrint("User sign in");
}
