import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healthy_enough/navbar/dashboard.dart';
import 'package:healthy_enough/screens/home_screen.dart';
import 'package:healthy_enough/screens/mode_select.dart';

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

Future<UserCredential> _signInWithGoogle() async {
  // Trigger the authentication flow
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
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  _handleGoogleBtnClick() {
    _signInWithGoogle().then((user) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => ModeSelection(
                onDoctorSelected: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => DashboardPage()));
                },
                onPatientSelected: () {},
              ))));
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcome to HealthyEnough',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'abz',
              fontWeight: FontWeight.w900,
              color: Color.fromARGB(255, 0, 0, 0),
            )),
      ),
      body: Stack(children: [
        AnimatedPositioned(
            top: mq.height * .15,
            right: _isAnimate ? mq.width * 0.18 : mq.width * .2,
            width: mq.width * 0.6,
            duration: const Duration(milliseconds: 600),
            child: Image.asset('assets/images/logo-color.png')),
        Positioned(
            bottom: mq.height * 0.15,
            left: mq.width * 0.05,
            width: mq.width * 0.9,
            height: mq.height * 0.07,
            child: ElevatedButton.icon(
                onPressed: () {
                  // _handleGoogleBtnClick();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DashboardPage(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  elevation: 8,
                ),
                icon: Transform.scale(
                  scale: 0.6,
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
