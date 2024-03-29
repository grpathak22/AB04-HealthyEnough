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
import '../navbar/dashboardDoc.dart';

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
  _handleGoogleBtnClick() async {
    Dialogs.showProgressBar(context);

    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

    try {
      await googleSignIn.disconnect();
    } catch (e) {
      print('Error revoking access token: $e');
    }
    _signInWithGoogle().then((user) {
      Navigator.pop(context);
      if (user != null) {
        // Check if the user exists in Firestore and retrieve their type
        APIs.userExists().then((exists) {
          if (exists) {
            // User exists, retrieve their type and redirect accordingly
            APIs.firestore
                .collection('users')
                .doc(APIs.user.uid)
                .get()
                .then((doc) {
              if (doc.exists) {
                String userType = doc['type'];
                if (userType == 'doctor') {
                  // Redirect to doctor's page
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => DashboardPageDoc(),
                  ));
                } else if (userType == 'patient') {
                  // Redirect to patient's page
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        DashboardPage(), // or whichever page is appropriate for patients
                  ));
                }
              }
            }).catchError((error) {
              print('Error retrieving user data: $error');
              // Handle error
            });
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ModeSelection(
                onDoctorSelected: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DoctorKYC()));
                },
                onPatientSelected: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const UserKyc()));
                },
              ),
            ));
          }
        });
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');

      // Force Google sign-in flow to always show account selection UI
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: ['email']).signIn();

      if (googleUser == null) {
        // User canceled sign-in, return null
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential != null) {
        Dialogs.showSuccess(context, 'Login Successful!');
        final sharedPrefs = await SharedPreferences.getInstance();
        await sharedPrefs.setString('UserId', userCredential.user!.uid);
      }
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
      body: Stack(
        children: [
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
                  onPressed: _handleGoogleBtnClick,
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
        ],
      ),
    );
  }
}
