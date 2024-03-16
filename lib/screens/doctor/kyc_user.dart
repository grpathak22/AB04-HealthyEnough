import 'package:flutter/material.dart';
import 'package:healthy_enough/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';

class UserKyc extends StatefulWidget {
  const UserKyc({super.key});

  @override
  State<UserKyc> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<UserKyc> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // For validation

  // Page state variables
  int currentPage = 1;
  String _name = "";
  String _age = "";
  String _weight = "";
  String _height = "";
  String _bloodgrp = "";
  String _address = "";
  // Add variable to store hospital ID data (e.g., file path)

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
                // Progress bar (replace with actual progress indicator)
                LinearProgressIndicator(
                  value: currentPage / 3, // Adjust based on number of pages
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
            // Add validation logic (e.g., check if name is not empty)
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
      ],
    );
  }

  Widget buildNextButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (currentPage == 2) {
          // Handle registration logic here (validation, calling backend)
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Registration Page',
    home: UserKyc(),
  ));
}