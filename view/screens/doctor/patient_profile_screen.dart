import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduationnn/view/screens/doctor/chat_doctor_screen.dart';

import '../../../config/dimens.dart';
import '../../../config/palette.dart';

class PatientProfileScreen extends StatefulWidget {
  User? user;
  String? patientName;
  String? patientAge;
  PatientProfileScreen({super.key, this.user, this.patientAge, this.patientName});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
                  Text('Name: ${widget.patientName}'),
                  SizedBox(height: 16,),
                  Text('Age: ${widget.patientAge}'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDoctorScreen(patient: widget.patientName, user: widget.user,)));
        },
        backgroundColor: Palette.colorPrimary600,
        child: Icon(Icons.chat, color: Colors.white,),
      ),
    );
  }
}
