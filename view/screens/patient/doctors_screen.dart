import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../config/dimens.dart';
import '../../../config/palette.dart';
import '../../widgets/custom_text_style.dart';
import 'doctor_profile_screen.dart';

class DoctorsScreen extends StatefulWidget {
  User? user;
  DoctorsScreen({super.key, this.user});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final String collectionDoctors = 'doctors';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctors', style: TextStyle(
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
          stream: fireStore.collection(collectionDoctors).snapshots(),
          builder: (context, snapshot){
            return snapshot.hasData
                ? doctorData(snapshot.data)
                : snapshot.hasError
                ? Text('Error')
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget doctorData(dynamic data){
    return ListView.builder(
        itemCount: data.docs.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorProfileScreen(user: widget.user,doctorName: data.docs[index]['username'].toString(), doctorSpecialization: data.docs[index]['specialization'], doctorAge: data.docs[index]['age'],)));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Palette.colorPrimary100
              ),
              child: ListTile(
                title: Text('${data.docs[index]['username'].toString().toUpperCase()}', style: txtTitle(),),
                subtitle: Text('${data.docs[index]['specialization']}'),
              ),
            ),
          );
        });
  }
}
