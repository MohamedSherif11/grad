import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduationnn/config/dimens.dart';
import 'package:graduationnn/config/palette.dart';
import 'package:graduationnn/view/screens/patient/chat_patient_screen.dart';
import 'package:graduationnn/view/screens/patient/medical_history_screen.dart';
import 'package:graduationnn/view/screens/patient/received_exercise/received_exercise_screen.dart';
import 'package:graduationnn/view/widgets/custom_text_style.dart';

import '../../../services/auth.dart';
import '../../../services/database.dart';
import 'doctors_screen.dart';

class HomePatientScreen extends StatefulWidget {
  User? user;
  HomePatientScreen({super.key, this.user});

  @override
  State<HomePatientScreen> createState() => _HomePatientScreenState();
}

class _HomePatientScreenState extends State<HomePatientScreen> {
  bool? isChecked = false;
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user!;
    super.initState();
  }

  final databaseMethods = DatabaseMethods();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final String collectionPatients = 'patients';
  final String collectionDoctors = 'doctors';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('${_currentUser.displayName}'),
      // ),
      body: SafeArea(
        child: Container(
          width: Dimens.screenWidth(context),
          padding: EdgeInsets.only(top: 24,left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome ${_currentUser.displayName!.toUpperCase()}', style: title(),),
              SizedBox(height: 4,),
              Text('Connect to special doctors around you', style: txtDes(),),
              SizedBox(height: 32,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Text('Doctors', style: txtCat(),),
              //     Text('View All', style: txtView(),),
              //   ],
              // ),
              // SizedBox(height: 10,),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorsScreen(user: widget.user,)));
                        },
                        child: Container(
                          width: 166,
                          height: 160,
                          decoration: BoxDecoration(
                              color: Palette.colorPrimary600,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Center(child: Text('Doctor’s', style: txtCon(),)),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ReceivedExerciseScreen()));
                        },
                        child: Container(
                          width: 166,
                          height: 160,
                          decoration: BoxDecoration(
                              color: Palette.colorPrimary600,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Center(child: Text('Received Exercise',
                            textAlign: TextAlign.center,
                            style: txtCon(),)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MedicalHistoryScreen()));
                        },
                        child: Container(
                          width: 166,
                          height: 160,
                          decoration: BoxDecoration(
                              color: Palette.colorPrimary600,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Center(child: Text('Medical history', style: txtCon(),)),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          width: 166,
                          height: 160,
                          decoration: BoxDecoration(
                              color: Palette.colorPrimary600,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Center(
                            child: Text('Start chat with doctors',
                              textAlign: TextAlign.center,
                              style: txtCon(),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
