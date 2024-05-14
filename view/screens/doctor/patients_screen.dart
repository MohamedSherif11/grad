import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduationnn/view/screens/doctor/patient_profile_screen.dart';

import '../../../config/palette.dart';
import '../../widgets/custom_text_style.dart';

class PatientsScreen extends StatefulWidget {
  User? user;
  PatientsScreen({super.key, this.user});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final String collectionPatients = 'patients';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patients', style: TextStyle(
            color: Colors.black
        ),
        ),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot>(
          stream: fireStore.collection(collectionPatients).snapshots(),
          builder: (context, snapshot){
            return snapshot.hasData
                ? patientData(snapshot.data)
                : snapshot.hasError
                ? Text('Error')
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget patientData(dynamic data){
    return ListView.builder(
        itemCount: data.docs.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PatientProfileScreen(user: widget.user,patientName: data.docs[index]['username'].toString(), patientAge: data.docs[index]['age'],)));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Palette.colorPrimary100
              ),
              child: ListTile(
                title: Text('${data.docs[index]['username'].toString().toUpperCase()}', style: txtTitle(),),
                subtitle: Text('${data.docs[index]['age']}'),
              ),
            ),
          );
        });
  }
}
