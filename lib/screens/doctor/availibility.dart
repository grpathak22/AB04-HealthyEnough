import 'package:flutter/material.dart';

class DoctorAvailabilityPage extends StatefulWidget {
  @override
  _DoctorAvailabilityPageState createState() => _DoctorAvailabilityPageState();
}

class _DoctorAvailabilityPageState extends State<DoctorAvailabilityPage> {
  final List<bool> _availableDays =
      List.filled(7, false); // Initially all days unavailable
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
    if (_availableDays.any((day) => day) &&
        _startTime != null &&
        _endTime != null) {
      // TODO: Show success message or perform actual data saving
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Availability saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // TODO: Replace with your actual data saving logic (e.g., API call, database write)
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Please select at least one day and both start and end times.'),
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Days:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Mon'),
                Checkbox(
                  value: _availableDays[0],
                  onChanged: (value) => _toggleDayAvailability(0),
                ),
                const Text('Tue'),
                Checkbox(
                  value: _availableDays[1],
                  onChanged: (value) => _toggleDayAvailability(1),
                ),
                const Text('Wed'),
                Checkbox(
                  value: _availableDays[2],
                  onChanged: (value) => _toggleDayAvailability(2),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Thu'),
                Checkbox(
                  value: _availableDays[3],
                  onChanged: (value) => _toggleDayAvailability(3),
                ),
                const Text('Fri'),
                Checkbox(
                  value: _availableDays[4],
                  onChanged: (value) => _toggleDayAvailability(4),
                ),
                const Text('Sat'),
                Checkbox(
                  value: _availableDays[5],
                  onChanged: (value) => _toggleDayAvailability(5),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Sun'),
                Checkbox(
                  value: _availableDays[6],
                  onChanged: (value) => _toggleDayAvailability(6),
                ),
              ],
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
