import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../config/dimens.dart';
import '../../../config/palette.dart';
import '../../../services/database.dart';
import 'chat_patient_screen.dart';

class DoctorProfileScreen extends StatefulWidget {
  User? user;
  String? doctorName;
  String? doctorSpecialization;
  String? doctorAge;
  DoctorProfileScreen({super.key, this.user, this.doctorName, this.doctorSpecialization, this.doctorAge});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;
    DatabaseMethods databaseMethods = DatabaseMethods();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: Dimens.screenWidth(context),
              height: Dimens.screenHeight(context) / 4,
              decoration: BoxDecoration(
                  color: Colors.grey
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 216 , left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${widget.doctorName}'),
                  SizedBox(height: 16,),
                  Text('Age: ${widget.doctorAge}'),
                  SizedBox(height: 16,),
                  Text('Specialization: ${widget.doctorSpecialization}'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPatientScreen(doctor: widget.doctorName, user: widget.user,)));
        },
        backgroundColor: Palette.colorPrimary600,
        child: Icon(Icons.chat, color: Colors.white,),
      ),
    );
  }
}
