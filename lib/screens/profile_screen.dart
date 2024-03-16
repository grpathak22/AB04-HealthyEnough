import 'dart:io';
import 'package:flutter/material.dart';
import 'package:healthy_enough/screens/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/apis.dart'; // Import GoogleSignIn

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "";
  String email = "";
  String address = "";
  ImageProvider profileImage = const AssetImage(
      'assets/images/profile_placeholder.png'); // Placeholder image

  // Image picker for selecting profile photo
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profileImage = FileImage(File(pickedFile.path));
      });
    }
  }

  Future<void> _logout() async {
    await APIs.auth.signOut();
    await GoogleSignIn().signOut();
    await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Profile picture section
              CircleAvatar(
                radius: 70,
                backgroundImage: profileImage,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: _getImage,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() => name = value),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() => email = value),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() => address = value),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Blood Type:'),
                  Text('O+'), // Replace with user's blood type
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Emergency Contact:'),
                  Text('123-456-7890'), // Replace with user's emergency contact
                ],
              ),

              // Save button
              ElevatedButton(
                onPressed: () {
                  // TODO: Handle saving user details
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  disabledForegroundColor: Colors.white,
                ),
                child: const Text('Save Profile'),
              ),

              // Logout button
              ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  disabledForegroundColor: Colors.white,
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
