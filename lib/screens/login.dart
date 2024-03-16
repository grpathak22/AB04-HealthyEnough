import 'package:flutter/material.dart';
import 'package:healthy_enough/navbar/dashboard.dart';
import 'package:healthy_enough/screens/record_scanner.dart';

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

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                  //_handleGoogleBtnClick();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => DashboardPage())));
                },
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  elevation: 8,
                ),
                icon: Transform.scale(
                  scale: 0.6, // Adjust the scale factor to change the icon size
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
