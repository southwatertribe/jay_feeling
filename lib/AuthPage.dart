import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jay_feeling/LoginPage.dart';
import 'package:jay_feeling/SignUp.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return isLogin ? LoginPage(clickSignUp: toggle) : SignUp(clickSignUp: toggle);
  }

  void toggle()=> setState(() {
    isLogin = !isLogin;
  });
}
