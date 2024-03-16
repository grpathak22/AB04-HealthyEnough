import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthy_enough/navbar/dashboard.dart';
<<<<<<< HEAD
=======
>>>>>>> 83f4e822675451a3a62ef0eb9734ef40471e03ac
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserKyc extends StatefulWidget {
  const UserKyc({Key? key}) : super(key: key);

  @override
  State<UserKyc> createState() => _UserKycState();
}

class _UserKycState extends State<UserKyc> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            decoration: const InputDecoration(
              labelText: 'Weight',
              hintText: 'Enter your weight',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              return null;

              // Add validation logic
            },
            onSaved: (newValue) => _weight),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Blood Group',
            hintText: 'Enter your Blood Group',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic
          },
          onSaved: (newValue) => _height = newValue!,
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
    CollectionReference usersRef = FirebaseFirestore.instance.collection("users");
    await usersRef.doc(userId).set({"type": "user"});

    // Add user details to 'patients' collection
    CollectionReference patientsRef = FirebaseFirestore.instance.collection("patients");
    await patientsRef.doc(userId).set({
      "Name": _name,
      "Age": _age,
      "Weight": _weight,
      "Height": _height,
      "Address": _address,
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

void main() {
  runApp(const MaterialApp(
    title: 'Registration Page',
    home: UserKyc(),
  ));
}
