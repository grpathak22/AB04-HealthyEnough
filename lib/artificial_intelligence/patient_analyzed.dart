import 'package:flutter/material.dart';

class PatientAnalysis extends StatelessWidget {
  final analyzedData;
  const PatientAnalysis({super.key, required this.analyzedData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          analyzedData,
          style: const TextStyle(
            fontFamily: "abz",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.teal,
          ),
        ),
      ),
    );
  }
}
