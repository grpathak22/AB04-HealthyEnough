import 'package:flutter/material.dart';
import 'package:healthy_enough/screens/doctor/record.dart';
import 'package:intl/intl.dart';
import 'package:healthy_enough/screens/doctor/availibility.dart';
import 'package:healthy_enough/screens/profile_screen.dart';
import 'package:healthy_enough/screens/doctor/record.dart';

class PatientAppointment {
  final int id;
  final String name;
  final int age;
  final DateTime date;
  final TimeOfDay time;

  PatientAppointment({
    required this.id,
    required this.name,
    required this.age,
    required this.date,
    required this.time,
  });
}

class DoctorAppointmentsPage extends StatefulWidget {
  @override
  _DoctorAppointmentsPageState createState() => _DoctorAppointmentsPageState();
}

class _DoctorAppointmentsPageState extends State<DoctorAppointmentsPage> {
  bool _showSidebar = false;
  bool _showCalendar = false;

  final List<PatientAppointment> _appointments = [
    PatientAppointment(
      id: 1,
      name: 'John Doe',
      age: 35,
      date: DateTime(2024, 03, 18),
      time: const TimeOfDay(hour: 10, minute: 30),
    ),
    // Add more sample appointments here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HealthyEnough - Doctor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => setState(() => _showCalendar = !_showCalendar),
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildAppointmentsList(),
          if (_showCalendar)
            _buildCalendarOverlay(), // Placeholder for future calendar implementation
        ],
      ),
    );
  }

  Widget _buildCalendarOverlay() {
    // Implement a calendar widget to visually select dates
    // You can use a package like table_calendar or build a custom one
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: const Center(
        child: Text(
          'Calendar Overlay (implementation pending)',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  Widget _buildAppointmentsList() {
    return ListView.builder(
      itemCount: _appointments.length,
      itemBuilder: (context, index) {
        final appointment = _appointments[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color.fromARGB(255, 255, 250, 110),
            // Subtle shadow
          ),
          child: Row(
            children: [
              // Patient info and appointment details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue.shade200,
                        child: Text(
                          appointment.name[0].toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        appointment.name,
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Text('Age: ${appointment.age}'),
                      Text(
                        '${DateFormat('MMMM d, yyyy').format(appointment.date)} - ${appointment.time.format(context)}',
                      ),
                    ],
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () => handlePatientInformation(appointment),
                child: const Text('Details'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void handlePatientInformation(PatientAppointment appointment) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MedicalRecordPage(patientId: appointment.id)));
  }
}
