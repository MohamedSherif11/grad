import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduationnn/view/screens/patient/home_patient_screen.dart';

import '../../../config/dimens.dart';
import '../../../config/palette.dart';
import '../../../services/auth.dart';
import '../../../services/validator.dart';
import '../../widgets/custom_button_signin.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_text_style.dart';

class SignInPatientScreen extends StatefulWidget {
  final Function toggle;
  const SignInPatientScreen(this.toggle, {super.key});

  @override
  State<SignInPatientScreen> createState() => _SignInPatientScreenState();
}

class _SignInPatientScreenState extends State<SignInPatientScreen> {
  bool isChecked = false;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _key,
          child: SizedBox(
            height: Dimens.screenHeight(context),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: Dimens.screenWidth(context),
                    padding: EdgeInsets.only(left: 24, top: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SIGN IN PATIENT',
                          style: title(),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Sign in if you already have an account',
                          style: txtDes(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                    width: double.infinity,
                    height: Dimens.screenHeight(context),
                    decoration: BoxDecoration(
                        color: Palette.colorPrimary600,
                        borderRadius:
                        BorderRadius.only(topRight: Radius.circular(30))),
                    child: Column(
                      children: [
                        CustomTextFormField(
                            obscureText: false,
                            validator: (value) =>
                                Validator.validateEmail(email: value!),
                            controller: emailController,
                            label: 'Email'),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            obscureText: true,
                            input: TextInputType.visiblePassword,
                            validator: (value) =>
                                Validator.validatePassword(password: value!),
                            controller: passwordController,
                            label: 'Password'),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                    value: isChecked,
                                    fillColor:
                                    MaterialStateProperty.all(Colors.white),
                                    checkColor: Palette.colorPrimary600,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    onChanged: (val) {
                                      setState(() {
                                        isChecked = !isChecked;
                                      });
                                    }),
                                Text(
                                  'Remember Me',
                                  style: txtSign(),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Forget Password?',
                                  style: txtSign(),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButtonSignIn(
                            txt: 'Login',
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
                                User? user =
                                await Auth.signInUsingEmailPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context,
                                );
                                if (user != null) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomePatientScreen(user: user)),
                                  );
                                }
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Have an account? ",
                              style: txtHave(),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.toggle();
                              },
                              child: Text(
                                'Sign Up',
                                style: txtSign(),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
