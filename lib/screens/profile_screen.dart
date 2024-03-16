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
  String name = "John Doe"; // Generic name
  String email = "johndoe6@hehe.com"; // Example email
  String address = "South Street, North Carolina"; // Example address
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
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
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
              // Profile picture section with smooth scaling animation
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                transform: Matrix4.identity()..scale(1.05, 1.05),
                child: CircleAvatar(
                  radius: 70.0,
                  backgroundImage: profileImage,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: _getImage,
                    color: Colors.amber,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // User information section with subtle fade-in animation
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Rahul', // Updated with generic name
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Email:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'rahul6@hehe.com', // Updated with example email
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Address:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'South Street, North Carolina', // Replace with actual address
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Blood Type:'),
                  Text('O+'), // Replace with user's blood type
                ],
              ),
              const SizedBox(height: 10.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Emergency Contact:'),
                  Text('123-456-7890'), // Replace with user's emergency contact
                ],
              ),

              // Save and Logout buttons with subtle button press animation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeInOut,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Handle saving user details
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        disabledForegroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('Save Profile'),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeInOut,
                    child: ElevatedButton(
                      onPressed: _logout,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        disabledForegroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
