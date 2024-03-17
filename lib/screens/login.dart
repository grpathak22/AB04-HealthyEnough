import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healthy_enough/navbar/dashboard.dart';
import 'package:healthy_enough/screens/doctor/kyc_doctor.dart';
import 'package:healthy_enough/screens/doctor/kyc_user.dart';
import 'package:healthy_enough/screens/home_screen.dart';
import 'package:healthy_enough/screens/mode_select.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/apis.dart';
import '../helper/dialogs.dart';

late Size mq;
bool _isAnimate = false;
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  _handleGoogleBtnClick() {
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) {
      // ignore: unnecessary_null_comparison
      Navigator.pop(context);
      if (user != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => ModeSelection(
                  onDoctorSelected: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => DashboardPage()));
                  },
                  onPatientSelected: () {},
                ))));
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      await InternetAddress.lookup('google.com');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      final userCredential = await APIs.auth.signInWithCredential(credential);

      if (userCredential != null) {
        Dialogs.showSuccess(context, 'Login Successful!');
        final sharedPrefs = await SharedPreferences.getInstance();
        await sharedPrefs.setString('UserId', userCredential.user!.uid);
      }
      // ignore: dead_code
      return userCredential;
    } catch (e) {
      Dialogs.showSnackBar(context, 'Something went Wrong (Check Internet)');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 250, 110),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 250, 110),
        automaticallyImplyLeading: false,
      ),
      body: Stack(children: [
        AnimatedPositioned(
            top: mq.height * .15,
            right: _isAnimate ? mq.width * 0.18 : mq.width * .2,
            width: mq.width * 0.6,
            duration: const Duration(milliseconds: 600),
            child: Image.asset('assets/images/logo-no-background.png')),
        Positioned(
            bottom: mq.height * 0.15,
            left: mq.width * 0.05,
            width: mq.width * 0.9,
            height: mq.height * 0.07,
            child: ElevatedButton.icon(
                onPressed: () {
                  // _handleGoogleBtnClick();
                  //use following code to bypass security
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ModeSelection(onDoctorSelected: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const DoctorKYC()));
                          }, onPatientSelected: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const UserKyc()));
                          })));
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    width: 2,
                  ),
                  shape: StadiumBorder(),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                icon: Transform.scale(
                  scale: 0.5,
                  child: Image.asset('assets/images/google.png'),
                ),
                label: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text: 'Sign in with Google',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'abz',
                            color: Colors.black)),
                  ]),
                ))),
      ]),
    );
  }
}
