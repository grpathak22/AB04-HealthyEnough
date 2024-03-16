import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_enough/navbar/dashboard.dart';
import 'package:healthy_enough/screens/home_screen.dart';
import 'package:healthy_enough/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
    _controller.forward();
    Timer(Duration(seconds: 5), () {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => DashboardPage()));
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            "assets/images/abhijeet-cid-meme.gif",
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
