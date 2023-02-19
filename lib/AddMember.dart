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

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text ("Add Patient"),
            builtTextField("Name", nameController),
            builtTextField("Age", ageController),
            ElevatedButton(onPressed: () {
              final patient = Patient(nameController.text, ageController.text);
              widget.addPatient(patient);
              Navigator.of(context).pop();
            },
                child: Text("Add Patient"))
          ]
        ),
      ),
    );
  }
}
