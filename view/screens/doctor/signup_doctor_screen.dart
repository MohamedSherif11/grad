import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduationnn/view/screens/doctor/home_doctor_screen.dart';
import 'package:graduationnn/view/widgets/custom_button_signup.dart';

import '../../../config/dimens.dart';
import '../../../helper/helperfunctions.dart';
import '../../../services/auth.dart';
import '../../../services/database.dart';
import '../../widgets/custom_text_form_field_signup.dart';
import '../../widgets/custom_text_style.dart';
import '../patient/home_patient_screen.dart';

class SignUpDoctorScreen extends StatefulWidget {
  final Function toggle;
  const SignUpDoctorScreen(this.toggle, {super.key});

  @override
  State<SignUpDoctorScreen> createState() => _SignUpDoctorScreenState();
}

class _SignUpDoctorScreenState extends State<SignUpDoctorScreen> {

  bool isLoading = false;
  DatabaseMethods databaseMethods = DatabaseMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 60, right: 24, left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Dimens.screenWidth(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SIGN UP DOCTOR',
                          style: title(),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Please file this information to complete Registration',
                          style: txtDes(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24,),
                  Text('Username', style: txtTitle(),),
                  SizedBox(height: 6,),
                  CustomTextFormFieldSignUp(
                    obscureText: false,
                    hint: 'Enter your username', controller: usernameController,
                  ),
                  SizedBox(height: 10,),
                  Text('Email', style: txtTitle(),),
                  SizedBox(height: 6,),
                  CustomTextFormFieldSignUp(
                    obscureText: false,
                    hint: 'Enter your email', controller: emailController,
                  ),
                  SizedBox(height: 10,),
                  Text('Age', style: txtTitle(),),
                  SizedBox(height: 6,),
                  CustomTextFormFieldSignUp(
                    obscureText: false,
                    hint: 'Enter your age', controller: ageController,
                  ),
                  SizedBox(height: 10,),
                  Text('Specialization', style: txtTitle(),),
                  SizedBox(height: 6,),
                  CustomTextFormFieldSignUp(
                    obscureText: false,
                    hint: 'Enter your specialization', controller: specializationController,
                  ),
                  SizedBox(height: 10,),
                  Text('Phone Number', style: txtTitle(),),
                  SizedBox(height: 6,),
                  CustomTextFormFieldSignUp(
                    obscureText: false,
                    hint: 'Enter your phone number', controller: phoneController,
                  ),
                  SizedBox(height: 10,),
                  Text('Password', style: txtTitle(),),
                  SizedBox(height: 6,),
                  CustomTextFormFieldSignUp(
                    obscureText: true,
                    hint: 'Password', controller: passwordController,
                  ),
                  SizedBox(height: 20,),
                  CustomButtonSignUp(txt: 'Sign Up', onPressed: () async {
                    if (_key.currentState!.validate()) {

                      User? user = await Auth.registerUsingEmailPassword(
                        name: usernameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      Map<String, dynamic>  newDoctor = {
                        'username': usernameController.text,
                        'email': emailController.text,
                        'age': ageController.text,
                        'specialization' : specializationController.text,
                        'phone': phoneController.text,
                      };

                      HelperFunctions.saveUserEmailSharedPreference(emailController.text);
                      HelperFunctions.saveUserNameSharedPreference(usernameController.text);

                      setState(() {
                        isLoading = true;
                      });

                      if(user != null){
                        databaseMethods.doctors(user.uid, newDoctor);
                        HelperFunctions.saveUserLoggedInSharedPreference(true);
                        Navigator.of(context)
                            .pushReplacement(
                          MaterialPageRoute(builder: (context) => HomeDoctorScreen(user: user)),
                        );
                      }
                    }
                  }),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: txtHaveB(),
                      ),
                      GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Text(
                          'Sign In',
                          style: txtSignB(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
