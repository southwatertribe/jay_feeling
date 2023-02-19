import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jay_feeling/AddMember.dart';
import 'Models/Patient.dart';
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  List<Patient> patientList = [];
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    void addPatientData(Patient patient) {
      setState(() {
        patientList.add(patient);
      });
    }
    void showAddMember() {
      showDialog(context: context, builder: (_) {
        return AlertDialog(
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(10)
         ),
          content: AddMember(addPatientData),
        );
      });
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showAddMember,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
          title: Text("Welcome Back")
      ),
      body: Container(
        height: 400,
        child: ListView.builder(
            itemBuilder: (context, index){
              return Card(
              );
            }
        )
      )
    );
  }
}
