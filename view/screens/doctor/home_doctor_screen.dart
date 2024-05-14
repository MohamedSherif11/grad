import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduationnn/config/dimens.dart';
import 'package:graduationnn/config/palette.dart';
import 'package:graduationnn/view/screens/doctor/chat_doctor_screen.dart';
import 'package:graduationnn/view/screens/doctor/patients_screen.dart';
import 'package:graduationnn/view/screens/doctor/view_medical_history_screen.dart';
import 'package:graduationnn/view/widgets/custom_text_style.dart';

import '../../../services/auth.dart';
import '../../../services/database.dart';
import '../patient/doctors_screen.dart';
import '../patient/medical_history_screen.dart';
import '../patient/received_exercise/received_exercise_screen.dart';

class HomeDoctorScreen extends StatefulWidget {
  User? user;
  HomeDoctorScreen({super.key, this.user});

  @override
  State<HomeDoctorScreen> createState() => _HomeDoctorScreenState();
}

class _HomeDoctorScreenState extends State<HomeDoctorScreen> {
  bool? isChecked = false;
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user!;
    super.initState();
  }

  final databaseMethods = DatabaseMethods();

  final fireStore = FirebaseFirestore.instance;
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
              // Container(
              //   height: Dimens.screenHeight(context) * 0.2,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //       color: Palette.colorPrimary100
              //   ),
              //   child: StreamBuilder<QuerySnapshot>(
              //     stream: fireStore.collection(collectionPatients).snapshots(),
              //     builder: (context, snapshot){
              //       return snapshot.hasData
              //           ? doctorData(snapshot.data)
              //           : snapshot.hasError
              //           ? Text('Error')
              //           : Center(child: CircularProgressIndicator());
              //     },
              //   ),
              // ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PatientsScreen(user: widget.user,)));
                        },
                        child: Container(
                          width: 166,
                          height: 160,
                          decoration: BoxDecoration(
                              color: Palette.colorPrimary600,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Center(child: Text('Patient’s', style: txtCon(),)),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMedicalHistoryScreen()));
                        },
                        child: Container(
                          width: 166,
                          height: 160,
                          decoration: BoxDecoration(
                              color: Palette.colorPrimary600,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Center(child: Text('View Medical History',
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

                        },
                        child: Container(
                          width: 166,
                          height: 160,
                          decoration: BoxDecoration(
                              color: Palette.colorPrimary600,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Center(
                            child: Text('Start chat with Patient’s',
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //
      //   },
      //   backgroundColor: Palette.colorPrimary600,
      //   child: Icon(Icons.add, color: Colors.white,),
      // ),
    );
  }

// Widget doctorData(dynamic data){
//   return ListView.builder(
//       itemCount: data.docs.length,
//       itemBuilder: (context, index){
//         return GestureDetector(
//           onTap: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDoctorScreen(user: _currentUser, patient: data.docs[index]['username'].toString(),)));
//           },
//           child: ListTile(
//             title: Text('${data.docs[index]['username'].toString().toUpperCase()}', style: txtTitle(),),
//             subtitle: Text('${data.docs[index]['email']}'),
//           ),
//         );
//       });
// }
}
