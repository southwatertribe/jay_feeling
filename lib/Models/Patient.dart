import 'package:cloud_firestore/cloud_firestore.dart';

class Patient {
  final String name;
  final String age;
  final String gender;
  Patient({required this.name, required this.age, required this.gender});

  static Patient patientfromJSON(Map<String, dynamic> json) => Patient(name: json['name'], age: json['age'], gender: json['age']);
}
