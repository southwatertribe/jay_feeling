import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:jay_feeling/AddMember.dart';
import 'Models/Patient.dart';
=======

import 'api/SoundRecorder.dart';

>>>>>>> Stashed changes
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
<<<<<<< Updated upstream

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
=======
  final recorder = SoundRecorder();


  @override
  void initState() {
    super.initState();
    recorder.init();
  }

  @override
  void dispose() {
    recorder.dispose();
     super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final isRecording = true;
    final icon = isRecording ? Icons.stop :Icons.mic;
    final text = isRecording ? 'STOP' : 'START';
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.black;

>>>>>>> Stashed changes
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showAddMember,
        child: Icon(Icons.add),
      ),
<<<<<<< Updated upstream
      appBar: AppBar(
          title: Text("Welcome Back")
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            child: ListView.builder(
                itemBuilder: (context, index){
                  return Card(
                  );
                }
            )
          ),
          ElevatedButton(onPressed: signOut, child: Text("Sign Out"))
        ],
      )
=======
      body: Column(
        children: [
          Expanded(
              flex: 10,
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  "Hello, ${user.uid}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              )
          ),
          ElevatedButton.icon(
              onPressed: () async {
                final isRecording = await recorder.toggleRecord();
                setState(() {

                });
              },
              icon: Icon(icon),
              label: Text(
                text
              ),
          ),
          ElevatedButton(
            onPressed: _signOut, child: const Text('Sign Out'),
          ),
        ],
      ),
>>>>>>> Stashed changes
    );
  }
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();

  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();

}