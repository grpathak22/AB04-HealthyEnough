import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthy_enough/navbar/dashboard.dart';
import 'package:healthy_enough/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorKYC extends StatefulWidget {
  const DoctorKYC({Key? key}) : super(key: key);

  @override
  State<DoctorKYC> createState() => _DoctorKYCState();
}

class _DoctorKYCState extends State<DoctorKYC> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int currentPage = 1;
  String _name = "";
  String _address = "";
  String _phoneNumber = "";
  String _email = "";
  String _qualifications = "";
  String _specialization = "";
  String _hospitalIDPath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LinearProgressIndicator(
                  value: currentPage / 3,
                ),
                const SizedBox(height: 20.0),
                buildPageContent(currentPage),
                const SizedBox(height: 20.0),
                buildNextButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPageContent(int page) {
    switch (page) {
      case 1:
        return buildPage1();
      case 2:
        return buildPage2();
      case 3:
        return buildPage3();
      default:
        return const Text('Error: Invalid page');
    }
  }

  Widget buildPage1() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Name',
            hintText: 'Enter your name',
            border: OutlineInputBorder(),
          ),
          onSaved: (newValue) => _name = newValue!,
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Address',
            hintText: 'Enter your address',
            border: OutlineInputBorder(),
          ),
          onSaved: (newValue) => _address = newValue!,
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Mobile Number',
            hintText: 'Enter your mobile number',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic
          },
          onSaved: (newValue) => _phoneNumber = newValue!,
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Email ID',
            hintText: 'Enter your email',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic (e.g., check for valid email format)
          },
          onSaved: (newValue) => _email = newValue!,
        ),
      ],
    );
  }

  Widget buildPage2() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Qualifications',
            hintText: 'Enter your qualifications',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic
          },
          onSaved: (newValue) => _qualifications = newValue!,
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Specialization',
            hintText: 'Enter your specialization',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic
          },
          onSaved: (newValue) => _specialization = newValue!,
        ),
      ],
    );
  }

  Widget buildPage3() {
    return Row(
      children: [
        const Text(
          'Upload Hospital ID:',
          style: TextStyle(fontSize: 16.0),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () async {
            setState(() async {
              final image =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image != null) {
                _hospitalIDPath = image.path;
              }
            });
          },
          child: const Text('Upload'),
        ),
      ],
    );
  }

  Widget buildNextButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (currentPage == 3) {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            _register(context);
          }
        } else if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          setState(() {
            currentPage++;
          });
        }
      },
      child: currentPage == 3 ? const Text('Register') : const Text('Next'),
    );
  }

  void _register(BuildContext context) async {
    String userId = generateUserId();

    CollectionReference usersRef =
        FirebaseFirestore.instance.collection("users");
    await usersRef.doc(userId).set({"type": "doctor"});

    CollectionReference doctorsRef =
        FirebaseFirestore.instance.collection("doctors");
    await doctorsRef.doc(userId).set({
      "Name": _name,
      "Address": _address,
      "PhoneNumber": _phoneNumber,
      "Email": _email,
      "Qualifications": _qualifications,
      "Specialization": _specialization,
      "HospitalIDPath": _hospitalIDPath,
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()),
    );
  }

  String generateUserId() {
    final String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    Random rnd = Random();
    String result = '';
    for (var i = 0; i < 6; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    title: 'Registration Page',
    home: DoctorKYC(),
  ));
}
