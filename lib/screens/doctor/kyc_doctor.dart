import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthy_enough/navbar/dashboardDoc.dart';
import 'package:healthy_enough/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../api/apis.dart';

class DoctorKYC extends StatefulWidget {
  const DoctorKYC({Key? key}) : super(key: key);

  @override
  State<DoctorKYC> createState() => _DoctorKYCState();
}

class _DoctorKYCState extends State<DoctorKYC> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Separate controllers for each text field
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final bloodGrpController = TextEditingController();

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
                  value: currentPage / 2,
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
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Name',
            hintText: 'Enter your name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic
          },
          onSaved: (newValue) => _name = newValue!,
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          controller: addressController,
          decoration: const InputDecoration(
            labelText: 'Address',
            hintText: 'Enter your address',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic
          },
          onSaved: (newValue) => _address = newValue!,
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          controller: ageController,
          decoration: const InputDecoration(
            labelText: 'Mobile',
            hintText: 'Enter your Mobile',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic
          },
          onSaved: (newValue) => _phoneNumber = newValue!,
        ),
      ],
    );
  }

  Widget buildPage2() {
    return Column(
      children: [
        TextFormField(
          controller: heightController,
          decoration: const InputDecoration(
            labelText: 'Qualification',
            hintText: 'Enter your Qualification',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic
          },
          onSaved: (newValue) => _qualifications = newValue!,
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          controller: weightController,
          decoration: const InputDecoration(
            labelText: 'Specialization',
            hintText: 'Enter your Specialization',
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
    // Generate a random user ID
    String userId = generateUserId();

    // Add user to 'users' collection
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection("users");
    await usersRef.doc(userId).set({"type": "doctors"});

    // Add user details to 'patients' collection
    CollectionReference patientsRef =
        FirebaseFirestore.instance.collection("doctors");
    await patientsRef.doc(userId).set({
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
      MaterialPageRoute(builder: (context) => DashboardPageDoc()),
    );
  }

  String generateUserId() {
    if (APIs.auth.currentUser != null) {
      // Get the current user's Google ID (UID)
      String googleId = APIs.auth.currentUser!.uid;
      return googleId;
    } else {
      // If the user is not signed in, return a default value or handle accordingly
      return '';
    }
  }

  void main() {
    runApp(const MaterialApp(
      title: 'Registration Page',
      home: DoctorKYC(),
    ));
  }
}
