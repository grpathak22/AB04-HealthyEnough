import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_enough/screens/login.dart';
import 'package:image_picker/image_picker.dart';
import '../api/apis.dart'; // Import GoogleSignIn

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String name = "Loading"; // Default name
  late String age = 'Loading'; // Default email
  late String address = "Loading"; // Default address
  String bloodType = "Loading"; // Default blood type
  ImageProvider profileImage =
      const AssetImage('assets/images/patIcon.png'); // Default profile image
  @override
  void initState() {
    super.initState();
    // Fetch user data from Firestore
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      // Retrieve the current user's ID
      String userId = APIs.auth.currentUser!.uid;
      // Get the document snapshot from Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('patients')
          .doc(userId)
          .get();
      // Extract data from the snapshot
      setState(() {
        name = snapshot['Name'];
        age = snapshot['Age'];
        address = snapshot['Address'];
        bloodType = snapshot['BloodGroup'];
        // You can add more fields here if needed
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _logout() async {
    await APIs.auth.signOut();
    // Handle logout from other services if needed
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
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
                    onPressed: () {}, // No action on icon press
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
                        name,
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Age:',
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
                        age,
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
                        address,
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Blood Type:',
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
                        bloodType,
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
