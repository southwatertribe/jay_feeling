

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:jay_feeling/AddMember.dart';
import 'Models/Patient.dart';
import 'Models/AUser.dart';
import 'package:jay_feeling/RecordPage.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {


  List<Patient> patientList = [];

  @override
  Widget build(BuildContext context) {
    final userInfo = FirebaseAuth.instance.currentUser!;
    void addPatientData(Patient patient) {
      setState(() {

        //Get data from database
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

          body: Column(
            children: [
              Container(
                  height: 400,
                  // child: StreamBuilder(
                  //   stream: readPatientStream(),
                  //   builder: (context, snapshot){
                  //
                  //     if(snapshot.hasData){
                  //       final patients = snapshot.data!;
                  //       return ListView(
                  //           children: patients.map(buildPatientObject).toList()
                  //       );
                  //     } else {
                  //       return Text("Errors");
                  //     }
                  //
                  //   },
                  // ),
                  child: FutureBuilder(
                    future: readPatients(),
                    builder: (context, snapshot) {
                      final List<dynamic> patientList = snapshot.data;
                      print('PATIENTS UP HEYA${patientList}');
                        return ListView.builder(
                          itemCount: patientList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return generatePatientWidget(context, patientList[index]);
                          },
                        );
                    },
                  )
              ),
              const ElevatedButton(onPressed: signOut, child: Text("Sign Out"))
            ],
          )
      );
  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}
// //Builds a patient tile
// Widget buildAPatient(apatient) => ListTile(
//
//   leading: CircleAvatar(child: Text('${apatient['name']}')),
//
//
// );

//
// Widget buildPatientObject(Patient apatient) => ListTile(
//
//   leading: CircleAvatar(child: Text('${apatient.name}')),
//
//
// );

//
// Future readAUser() async {
//   final userInfo = FirebaseAuth.instance.currentUser!;
//   print("********* USER INFO IS ${userInfo.uid} *********");
//   final docUser = FirebaseFirestore.instance.collection('users').doc(userInfo.uid);
//   final snapshot = await docUser.get();
//   print(snapshot.data()!['patients'].runtimeType);
//   // if (snapshot.exists) {
//   //   print(AUser.fromJSON(snapshot.data()!));
//   //
//   //
//   // }
//   return snapshot.data()!['patients'];
// }

Future readPatients() async {
  final userInfo = FirebaseAuth.instance.currentUser!;
  print("********* USER INFO IS ${userInfo.uid} *********");
  final docUser = FirebaseFirestore.instance.collection('users').doc(userInfo.uid);
  final snapshot = await docUser.get();
  final patients = snapshot.data()!['patients'];
  print('${patients}');
  return patients;

}

// Stream<List<Patient>> readPatientStream()=> FirebaseFirestore.instance
//     .collection('users')
//     .doc(FirebaseAuth.instance.currentUser!.uid)
//     .snapshots()
//     .map((snapshot) => snapshot.data()!['patients'].map((patient)=>Patient.patientfromJSON(patient)));

Widget generatePatientWidget(context, dynamic item) {
  return ListTile(
    leading: Text('${item["name"]}'),
      onTap: () {
      print("tapped");
        Navigator.push(
            context, MaterialPageRoute(builder: (context)=> RecordPage())
        );
      }
  );
}

