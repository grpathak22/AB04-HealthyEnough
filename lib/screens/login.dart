import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Size mq;
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    // Start animation after a slight delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  void _handleGoogleBtnClick() {
    // Placeholder for Google sign-in logic (Firebase integration here later)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Google Sign-In'),
        content: Text('Google Sign-In logic will be here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
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
              child: Image.asset('assets/png/logo-color.png')), // Updated logo path
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
                    child: Image.asset('assets/google.png'), // Google icon
                  ),
                  label: RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                          text: 'Sign in with Google',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black)),
                    ]), // Theme-matching text style
                  ))),
        ],
      ),
    );
  }
}

void main() {
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
