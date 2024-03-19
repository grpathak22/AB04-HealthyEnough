import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_enough/screens/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../api/apis.dart';
// Import GoogleSignIn

class ProfilePageDoc extends StatefulWidget {
  const ProfilePageDoc({Key? key}) : super(key: key);

  @override
  State<ProfilePageDoc> createState() => _ProfilePageDocState();
}

class _ProfilePageDocState extends State<ProfilePageDoc> {
  late String name = "loading";
  late String? email = "loading";
  late String phoneNumber = "loading";
  late String qualifications = "loading";
  late String specialization = "loading";
  ImageProvider profileImage =
      const AssetImage('assets/images/docIcon.png'); // Placeholder image

  @override
  void initState() {
    super.initState();
    // Fetch doctor's profile data from Firestore
    fetchDoctorProfile();
  }

  Future<void> _logout() async {
    await APIs.auth.signOut();
    await GoogleSignIn().signOut();
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future<void> fetchDoctorProfile() async {
    try {
      // Retrieve the current user's ID
      String userId = APIs.auth.currentUser!.uid;
      // Get the document snapshot from Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('doctors')
          .doc(userId)
          .get();
      // Extract data from the snapshot
      setState(() {
        name = snapshot['Name'];
        email = APIs.auth.currentUser?.email;
        phoneNumber = snapshot['PhoneNumber'];
        qualifications = snapshot['Qualifications'];
        specialization = snapshot['Specialization'];
        // You can add more fields here if needed
      });
    } catch (e) {
      print('Error fetching doctor profile: $e');
    }
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
                        name,
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
                        email!,
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Phone Number:',
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
                        phoneNumber.toString(),
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Qualifications:',
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
                        qualifications,
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Specialization:',
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
                        specialization,
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

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
