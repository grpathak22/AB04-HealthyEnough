import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:healthy_enough/api/drugs_api.dart';
import 'package:healthy_enough/artificial_intelligence/analyzer.dart'; // (Placeholder for future use)
import 'package:healthy_enough/screens/doctor/appointment.dart';
import 'package:healthy_enough/screens/doctor/availibility.dart';
import 'package:healthy_enough/screens/profile_screen_patient.dart';
import 'package:healthy_enough/widgets/home_card.dart';

import 'doctor/profile_screen_doctor.dart';

class HomePageDoc extends StatefulWidget {
  const HomePageDoc({super.key});

  @override
  State<HomePageDoc> createState() => _HomePageDocState();
}

class _HomePageDocState extends State<HomePageDoc> {
  // late Map<String, dynamic> drugInfo;
  final DrugApi drpi = DrugApi();

  // @override
  // Future<void> initState() async {
  //   super.initState();
  //   await drpi.fetchDrugSummaryByName();
  // }

  // Widget _drugListBuild() {
  //   return ListView.builder(
  //     scrollDirection: Axis.horizontal,
  //     shrinkWrap: true,
  //     itemCount: 10,
  //     itemBuilder: (context, index) {
  //       return ListTile(
  //         title: Text('Appointments#${index + 1}'),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: const Text(
          'Healthy Enough',
          style: TextStyle(
            fontSize: 22.0,
            fontFamily: "abz",
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProfilePageDoc(),
              ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProfilePageDoc(),
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
                    fontFamily: "charmonman",
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
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
                    color: Colors.teal,
                    text: "Doctor Appointments",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DoctorAvailabilityPage();
                      },
                    );
                  },
                  child: const HomeCard(
                    color: Colors.teal,
                    text: "Set Availability",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Popular Drugs and Medicines",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(drugInfo.toString()),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color.fromARGB(255, 0, 15, 14).withOpacity(0.2),
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
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
