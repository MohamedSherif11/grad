import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduationnn/view/screens/choose_doctor_patient_screen.dart';
import 'package:graduationnn/view/screens/patient/received_exercise/ar_screen.dart';
import 'package:permission_handler/permission_handler.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Permission.camera.request();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'rehablitaion app',
      debugShowCheckedModeBanner: false,
      home: ChooseDoctorPatientScreen(),
    );
  }
}

