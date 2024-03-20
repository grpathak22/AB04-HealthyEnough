import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:healthy_enough/screens/medicineTracker.dart';
import 'package:healthy_enough/screens/home_screen.dart';
import 'package:healthy_enough/screens/record_scanner.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _page = 0;
  final pages = [
    HomePage(),
    MedicineTrackerPage(),
    const RecordScanner(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.amber,
          color: Colors.amber,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          items: const <Widget>[
            Icon(Icons.home, size: 26, color: Colors.white),
            Icon(Icons.calendar_month, size: 26, color: Colors.white),
            Icon(Icons.image, size: 26, color: Colors.white),
          ]),
      body: pages[_page],
    );
  }
}
