import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:healthy_enough/artificial_intelligence/analyzer.dart'; // (Placeholder for future use)
import 'package:healthy_enough/screens/doctor/appointment.dart';
import 'package:healthy_enough/screens/doctor/availibility.dart';
import 'package:healthy_enough/screens/profile_screen.dart';
import 'package:healthy_enough/widgets/home_card.dart';

class HomePageDoc extends StatelessWidget {
  const HomePageDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 250, 110),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Healthy Enough',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 5, 3, 3),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hello, Doc!',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                ),
                // Removed the entire GestureDetector wrapper
              ],
            ),
            const SizedBox(height: 20.0),

            // Search field with magnifying glass icon

            const SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DoctorAppointmentsPage(),
                    ));
                  },
                  child: const HomeCard(
                    text: "Doctor Appointments", // More descriptive text
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DoctorAvailabilityPage(); // Build the MedicineSearchPopup widget
                      },
                    );
                  },
                  child: const HomeCard(
                    text: "Set Availability", // Renamed section
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20.0), // Add spacing for doctor list

            const Text(
              'Pending Appointments',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Ensure the ListView doesn't have height constraints
            SizedBox(
              height: 200.0, // Adjust height as needed
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10, // Assuming 10 doctors
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Appointments#${index + 1}'), // Doctor names
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0), // Add spacing for Factoid block

            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color.fromARGB(255, 0, 15, 14)
                    .withOpacity(0.2), // Light teal background
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.teal),
                  SizedBox(width: 10.0),
                  Flexible(
                    child: Text(
                      'Did you know that the human body contains enough iron to make a nail? On average, an adult human body contains about 4 grams of iron, most of which is found in red blood cells.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
                height: 20.0), // Add spacing for bottom navigation bar
          ],
        ),
      ),
    );
  }
}

// Widget for Medicine Search Popup
class _MedicineSearchPopup extends StatefulWidget {
  @override
  State<_MedicineSearchPopup> createState() => _MedicineSearchPopupState();
}

class _MedicineSearchPopupState extends State<_MedicineSearchPopup> {
  String _searchText = ""; // Stores the entered medicine name
  List<String> _searchResults =
      []; // List to store search results (placeholder)

  // Replace this with a function to fetch medicine information from an API
  // This is a placeholder for now
  void _searchMedicine(String medicineName) {
    // Simulate a search by adding the medicine name to the results list
    setState(() {
      _searchResults.add(medicineName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(
            top: 10.0,
            left: 16.0,
            right: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom +
                16.0), // Adjust for keyboard
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Makes the popup adapt to content
            children: <Widget>[
              const Text(
                "Search Medicine",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                onChanged: (value) => setState(() {
                  _searchText = value;
                  _searchResults
                      .clear(); // Clear previous results on new search
                }),
                decoration: InputDecoration(
                  hintText: "Enter medicine name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),

              // Search button
              TextButton(
                onPressed: () =>
                    _searchMedicine(_searchText), // Call search function
                child: const Text("Search"),
              ),

              const SizedBox(height: 10.0),

              // Display search results (placeholder for now)
              _searchResults.isEmpty
                  ? const Text("No results yet.")
                  : ListView.builder(
                      shrinkWrap: true, // Makes the list fit its content
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        return Text(_searchResults[index]);
                      },
                    ),

              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the popup
                },
                child: Text("Close"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}