import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:healthy_enough/screens/medicineTracker.dart';
import 'package:healthy_enough/screens/home_screendoc.dart';
import 'package:healthy_enough/screens/record_scanner.dart';
import 'package:healthy_enough/screens/medicine_search.dart';

class DashboardPageDoc extends StatefulWidget {
  const DashboardPageDoc({super.key});

  @override
  State<DashboardPageDoc> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPageDoc> {
  int _page = 0;
  final pages = [
    const HomePageDoc(),
    MedSearch(),
    const RecordScanner(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.teal,
          color: Colors.teal,
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
