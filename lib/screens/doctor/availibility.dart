import 'package:flutter/material.dart';

class DoctorAvailabilityPage extends StatefulWidget {
  @override
  _DoctorAvailabilityPageState createState() => _DoctorAvailabilityPageState();
}

class _DoctorAvailabilityPageState extends State<DoctorAvailabilityPage> {
  final List<bool> _availableDays = List.filled(7, false); // Initially all days unavailable
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
    // Implement your logic to save availability (e.g., database, API)
    if (_availableDays.any((day) => day) && _startTime != null && _endTime != null) {
      // Show success message or perform actual data saving
      print('Availability saved successfully!');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Availability saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Replace with your actual data saving logic (e.g., API call, database write)
      // You might need additional information like doctor ID, etc. for data storage
    } else {
      // Show error message if required fields are missing
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select at least one day and both start and end times.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Availability'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Days:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mon'),
                Checkbox(
                  value: _availableDays[0],
                  onChanged: (value) => _toggleDayAvailability(0),
                ),
                Text('Tue'),
                Checkbox(
                  value: _availableDays[1],
                  onChanged: (value) => _toggleDayAvailability(1),
                ),
                Text('Wed'),
                Checkbox(
                  value: _availableDays[2],
                  onChanged: (value) => _toggleDayAvailability(2),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Thu'),
                Checkbox(
                  value: _availableDays[3],
                  onChanged: (value) => _toggleDayAvailability(3),
                ),
                Text('Fri'),
                Checkbox(
                  value: _availableDays[4],
                  onChanged: (value) => _toggleDayAvailability(4),
                ),
                Text('Sat'),
                Checkbox(
                  value: _availableDays[5],
                  onChanged: (value) => _toggleDayAvailability(5),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sun'),
                Checkbox(
                  value: _availableDays[6],
                  onChanged: (value) => _toggleDayAvailability(6),
                ),
              ],
            ),
            SizedBox(height: 16.0),
 Text(
              'Time Slot:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start Time:'),
                ElevatedButton(
                  onPressed: () => _selectStartTime(context),
                  child: Text(_startTime?.format(context) ?? 'Select Start'),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('End Time:'),
                ElevatedButton(
                  onPressed: () => _selectEndTime(context),
                  child: Text(_endTime?.format(context) ?? 'Select End'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveAvailability,
              child: Text('Save Availability'),
            ),
          ],
        ),
      ),
    );
  }
}