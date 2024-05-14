import 'package:flutter/material.dart';
import 'package:graduationnn/view/screens/doctor/signin_doctor_screen.dart';
import 'package:graduationnn/view/screens/patient/signin_patient_screen.dart';
import 'package:graduationnn/view/screens/doctor/signup_doctor_screen.dart';
import 'package:graduationnn/view/screens/patient/signup_patient_screen.dart';



class AuthenticateDoctor extends StatefulWidget {
  const AuthenticateDoctor({super.key});

  @override
  State<AuthenticateDoctor> createState() => _AuthenticateDoctorState();
}

class _AuthenticateDoctorState extends State<AuthenticateDoctor> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInDoctorScreen(toggleView);
    } else {
      return SignUpDoctorScreen(toggleView);
    }
  }
}
