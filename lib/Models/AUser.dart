import 'package:firebase_auth/firebase_auth.dart';
import 'Patient.dart';


class AUser {
  final String email;
  // final String uid;
  final List<Patient> patients; //Make this empty on creation
  AUser({required this.email, required this.patients});

  static AUser fromJSON(Map<String, dynamic> json) => AUser(email: json['email'], patients: json['patients']);
}

