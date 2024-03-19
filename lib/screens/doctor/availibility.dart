import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorAvailabilityPage extends StatefulWidget {
  @override
  _DoctorAvailabilityPageState createState() => _DoctorAvailabilityPageState();
}

class _DoctorAvailabilityPageState extends State<DoctorAvailabilityPage> {
  final List<bool> _availableDays = List.filled(7, false);
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  void _toggleDayAvailability(int dayIndex) {
    setState(() {
      _availableDays[dayIndex] = !_availableDays[dayIndex];
    });
  }

  void _selectStartTime(BuildContext context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        _startTime = selectedTime;
      });
    }
  }

  void _selectEndTime(BuildContext context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _endTime ?? TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        _endTime = selectedTime;
      });
    }
  }

  void _saveAvailability() async {
    // Get the current user
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;

      // Check if all required data is selected
      if (_availableDays.any((day) => day) &&
          _startTime != null &&
          _endTime != null) {
        final Map<String, dynamic> availabilityData = {};

        // Add selected time slots for each day
        for (int i = 0; i < _availableDays.length; i++) {
          if (_availableDays[i]) {
            final day = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][i];
            availabilityData[day] = {
              'startTime': '${_startTime!.hour}:${_startTime!.minute}',
              'endTime': '${_endTime!.hour}:${_endTime!.minute}',
            };
          }
        }

        // Save availability data to Firestore
        try {
          await FirebaseFirestore.instance
              .collection('availability')
              .doc(userId)
              .set(availabilityData);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Availability saved successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } catch (e) {
          print('Error saving availability: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Failed to save availability. Please try again later.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Please select at least one day and both start and end times.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // User is not signed in
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('User not signed in. Please sign in to save availability.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Availability'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Days:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                7,
                (index) => InkWell(
                  onTap: () => _toggleDayAvailability(index),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: _availableDays[index]
                          ? Colors.green
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                      style: TextStyle(
                        color:
                            _availableDays[index] ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Time Slot:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Start Time:'),
                ElevatedButton(
                  onPressed: () => _selectStartTime(context),
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  child: Text(_startTime?.format(context) ?? 'Select Start'),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('End Time:'),
                ElevatedButton(
                  onPressed: () => _selectEndTime(context),
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  child: Text(_endTime?.format(context) ?? 'Select End'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveAvailability,
              child: const Text('Save Availability'),
            ),
          ],
        ),
      ),
    );
  }
}
