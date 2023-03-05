import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:jay_feeling/HomePage.dart';
=======
>>>>>>> Stashed changes

import 'package:jay_feeling/LoginPage.dart';



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
<<<<<<< Updated upstream
      home: const HomePage(),
=======
      home: const LoginPage()
>>>>>>> Stashed changes
    );
  }
}

