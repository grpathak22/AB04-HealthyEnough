import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:healthy_enough/artificial_intelligence/analyzer.dart';
import 'package:healthy_enough/screens/doctor/appointment.dart';
import 'package:healthy_enough/screens/doctor/availibility.dart';
import 'package:healthy_enough/screens/doctor_details.dart';
import 'package:healthy_enough/screens/profile_screen_patient.dart';
import 'package:healthy_enough/widgets/doc_card.dart';
import 'package:healthy_enough/widgets/home_card.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference doctorRef =
      FirebaseFirestore.instance.collection("doctors");

  final _names = [];
  final _id = [];
  final _adrs = [];
  final _email = [];
  final _phone = [];
  final _qual = [];
  final _specs = [];

  Widget _getDoctorNames() {
    return FutureBuilder(
      future: doctorRef.get(),
      builder: (context, snapshots) {
        if (snapshots.hasData) {
          final doclist = [];
          for (int i = 0; i < snapshots.data!.size; i++) {
            _names.add(snapshots.data!.docs[i]['Name']);
            _id.add(snapshots.data!.docs[i]);
            _adrs.add(snapshots.data!.docs[i]['Address']);
            _email.add(snapshots.data!.docs[i]['Email']);
            _phone.add(snapshots.data!.docs[i]['PhoneNumber']);
            _qual.add(snapshots.data!.docs[i]['Qualifications']);
            _specs.add(snapshots.data!.docs[i]['Specialization']);
            doclist.add([
              _names[i],
              _id[i],
              _adrs[i],
              _email[i],
              _phone[i],
              _qual[i],
              _specs[i]
            ]);
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: snapshots.data!.size,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DoctorDetails(
                            docData: doclist[index],
                          )));
                },
                child: DoctorCard(name: _names[index]),
              );
            },
          );
        } else {
          return const Card(
            child: Center(
              child: Text("Loading or No doctors yet..."),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'Healthy Enough',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hello!',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                const SizedBox(width: 10.0), // Add some left padding
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText:
                          "Search for doctors ", // Consider specifying medicine search
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search), // Magnifying glass icon
                        onPressed: () {
                          // Handle search functionality ( Implement your search logic here)
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0), // Add some right padding
              ],
            ),

            const SizedBox(height: 20.0),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DoctorAppointmentsPage(),
                    ));
                  },
                  child: const HomeCard(
                    text: "Doctor Appointments",
                    color: Colors.amber,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _MedicineSearchPopup();
                      },
                    );
                  },
                  child: const HomeCard(
                    text: "Medicine Searcher",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20.0),

            const Text(
              'Top 10 Doctors:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 100,
              child: _getDoctorNames(),
            ),
            const SizedBox(height: 20.0),

            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.amber.withOpacity(0.2), // Light teal background
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.amber),
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
