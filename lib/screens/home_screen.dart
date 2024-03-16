import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthy_enough/artificial_intelligence/analyzer.dart';
import 'package:healthy_enough/screens/doctor/appointment.dart';
import 'package:healthy_enough/screens/doctor/availibility.dart';
import 'package:healthy_enough/screens/profile_screen.dart';
import 'package:healthy_enough/widgets/home_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Hello Name",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/person.png'),
                  ),
                ),
              ],
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              hintText: "Search for doctors",
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DoctorAppointmentsPage()));
                  },
                  child: const HomeCard(
                    text: "Doctor",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => DoctorAvailabilityPage()));
                  },
                  child: const HomeCard(
                    text: "Popular",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AnalyzerPage()));
                  },
                  child: const HomeCard(
                    text: "Popular",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
