import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthy_enough/navbar/dashboard.dart';
import 'package:healthy_enough/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../api/apis.dart';

class UserKyc extends StatefulWidget {
  const UserKyc({Key? key}) : super(key: key);

  @override
  State<UserKyc> createState() => _UserKycState();
}

class _UserKycState extends State<UserKyc> {
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
  String _age = "";
  String _weight = "";
  String _height = "";
  String _bloodgrp = "";
  String _address = "";

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
            labelText: 'Age',
            hintText: 'Enter your Age',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic
          },
          onSaved: (newValue) => _age = newValue!,
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
            labelText: 'Height',
            hintText: 'Enter your Height',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic
          },
          onSaved: (newValue) => _height = newValue!,
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          controller: weightController,
          decoration: const InputDecoration(
            labelText: 'Weight',
            hintText: 'Enter your weight',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic
          },
          onSaved: (newValue) => _weight = newValue!,
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          controller: bloodGrpController,
          decoration: const InputDecoration(
            labelText: 'Blood Group',
            hintText: 'Enter your Blood Group',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic
          },
          onSaved: (newValue) => _bloodgrp = newValue!,
        ),
      ],
    );
  }

  Widget buildNextButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (currentPage == 2) {
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
      child: currentPage == 2 ? const Text('Register') : const Text('Next'),
    );
  }

  void _register(BuildContext context) async {
    // Generate a random user ID
    String userId = generateUserId();

    // Add user to 'users' collection
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection("users");
    await usersRef.doc(userId).set({"type": "patient"});

    // Add user details to 'patients' collection
    CollectionReference patientsRef =
        FirebaseFirestore.instance.collection("patients");
    await patientsRef.doc(userId).set({
      "Name": _name,
      "Age": _age,
      "Weight": _weight,
      "Height": _height,
      "Address": _address,
      "BloodGroup": _bloodgrp,
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()),
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
      home: UserKyc(),
    ));
  }
}
