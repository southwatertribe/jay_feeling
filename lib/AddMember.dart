import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Models/Patient.dart';
class AddMember extends StatefulWidget {
  final Function(Patient) addPatient;

  AddMember(this.addPatient);
  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  @override
  Widget build(BuildContext context) {
    final userInfo = FirebaseAuth.instance.currentUser!; //Get current user to maker in firebase realtime database
    final docUser = FirebaseFirestore.instance.collection('users').doc(userInfo.uid);
    Widget builtTextField(String hint, TextEditingController controller){
      return Container(
        child: TextField(
          decoration: InputDecoration(
            labelText: hint
          ),
          controller: controller,
        )
      );
    }


    var nameController = TextEditingController();
    var ageController = TextEditingController();
    var genderController = TextEditingController();

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text ("Add Patient"),
            builtTextField("Name", nameController),
            builtTextField("Age", ageController),
            builtTextField("Gender", genderController),
            ElevatedButton(onPressed: () {
              final patientJSON = {
                'name': nameController.text,
                'age': ageController.text,
                'gender': genderController.text
              };
              // final patient = Patient(nameController.text, ageController.text, genderController.text); //Creates a patient object
              // widget.addPatient(patient);
              docUser.update({'patients': FieldValue.arrayUnion([patientJSON])});
              Navigator.of(context).pop();
            },
                child: Text("Add Patient"))
          ]
        ),
      ),
    );
  }
}
