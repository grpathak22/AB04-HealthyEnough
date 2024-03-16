import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for date formatting

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _selectedDate;
  List<TimeOfDay> _availableTimeSlots = [];

  @override
  void initState() {
    super.initState();
    // Simulate loading available time slots (replace with actual logic)
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _availableTimeSlots = [
          TimeOfDay(hour: 9, minute: 0),
          TimeOfDay(hour: 10, minute: 30),
          TimeOfDay(hour: 14, minute: 0),
        ];
      });
    });
  }

  FutureOr<void> _handleDateSelection(DateTime? selectedDate) async {
    setState(() {
      _selectedDate = selectedDate;
      // Clear previous time slots and simulate loading new ones based on date (replace with actual logic)
      _availableTimeSlots.clear();
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _availableTimeSlots = [
            TimeOfDay(hour: 9, minute: 0),
            TimeOfDay(hour: 10, minute: 30),
            TimeOfDay(hour: 14, minute: 0),
          ];
        });
      });
    });
  }

  void _handleTimeSlotSelection(TimeOfDay selectedTime) {
    // Implement logic to confirm appointment or navigate to next step
    print('Appointment booked for: ${DateFormat('yMd').format(_selectedDate!)} at ${selectedTime.format(context)}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 30)),
                lastDate: DateTime.now().add(Duration(days: 30)),
              ).then((selectedDate) => Future.sync(() => _handleDateSelection(selectedDate))),
              child: Text(
                _selectedDate != null ? DateFormat('MMMM dd, yyyy').format(_selectedDate!) : 'Choose Date',
              ),
            ),
            SizedBox(height: 20),
            // Add a conditional check to display available time slots only if a date is selected
            if (_selectedDate != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Time Slots',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: _availableTimeSlots.map((timeSlot) => _buildTimeSlotChip(timeSlot)).toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlotChip(TimeOfDay timeSlot) {
    return ChoiceChip(
      label: Text(timeSlot.format(context)),
      selected: _selectedDate != null && _availableTimeSlots.contains(timeSlot),
      onSelected: (isSelected) {
        if (isSelected) {
          _handleTimeSlotSelection(timeSlot);
        }
      },
    );
  }
}
