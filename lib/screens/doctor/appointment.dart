import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class PatientAppointment {
  final String name;
  final int age;
  final DateTime date;
  final TimeOfDay time;

  PatientAppointment({
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
      name: 'John Doe',
      age: 35,
      date: DateTime(2024, 03, 18),
      time: TimeOfDay(hour: 10, minute: 30),
    ),
    // Add more sample appointments here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HealthyEnough - Doctor'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => setState(() => _showSidebar = !_showSidebar),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => setState(() => _showCalendar = !_showCalendar),
          ),
        ],
      ),
      drawer: _buildSidebar(),
      body: Stack(
        children: [
          _buildAppointmentsList(),
          if (_showSidebar) _buildSidebarOverlay(),
          if (_showCalendar) _buildCalendarOverlay(), // Placeholder for future calendar implementation
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              'HealthyEnough Doctor',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text('Appointments'),
            leading: Icon(Icons.calendar_today),
            onTap: () => Navigator.pop(context), // Close sidebar on tap
          ),
          ListTile(
            title: Text('Availability'),
            leading: Icon(Icons.access_time),
            onTap: () => Navigator.pop(context), // Close sidebar on tap
          ),
          ListTile(
            title: Text('User Profile'),
            leading: Icon(Icons.person),
            onTap: () => Navigator.pop(context), // Close sidebar on tap
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarOverlay() {
    return GestureDetector(
      onTap: () => setState(() => _showSidebar = false),
      child: Container(
        color: Colors.black.withOpacity(0.3),
      ),
    );
  }

  Widget _buildCalendarOverlay() {
    // Implement a calendar widget to visually select dates
    // You can use a package like table_calendar or build a custom one
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: Center(
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
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 2.0)], // Subtle shadow
          ),
          child: Row(
            children: [
              // Patient info and appointment details
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue.shade200, // Placeholder avatar (replace with image provider if desired)
                        child: Text(
                          appointment.name[0].toUpperCase(), // Initials in avatar
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        appointment.name,
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Text('Age: ${appointment.age}'),
                      Text(
                        '${DateFormat('MMMM d, yyyy').format(appointment.date)} - ${appointment.time.format(context)}',
                      ),
                    ],
                  ),
                ),
              ),
              // Approval/rejection buttons
              Column(
                mainAxisSize: MainAxisSize.min, // Align buttons vertically
                children: [
                  ElevatedButton(
                    onPressed: () => handleApproveAppointment(appointment),
                    child: Text('Approve'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () => handleRejectAppointment(appointment),
                    child: Text('Reject'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor : Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void handleApproveAppointment(PatientAppointment appointment) {
    // Implement logic to approve appointment (e.g., update database, notify patient)
    print('Appointment approved for ${appointment.name}');

    // Optionally, update UI to reflect approval (e.g., change button or display message)
  }

  void handleRejectAppointment(PatientAppointment appointment) {
    // Implement logic to reject appointment (e.g., update database, notify patient)
    print('Appointment rejected for ${appointment.name}');

    // Optionally, update UI to reflect rejection (e.g., change button or display message)
  }
}
