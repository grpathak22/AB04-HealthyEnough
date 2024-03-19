import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_enough/api/apis.dart';
import 'package:healthy_enough/screens/doctor/record.dart';
import 'package:healthy_enough/widgets/appoinment_patient.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientAppointment {
  final int id;
  final String slot;
  final bool status;

  PatientAppointment({
    required this.id,
    required this.slot,
    required this.status,
  });

  // static Future<Stream<QuerySnapshot<Object?>>> getAppointmentsForUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final userID = 1;
  //   // Ensure userID is not null
  //   if (userID != null) {
  //     return FirebaseFirestore.instance
  //         .collection('appointments')
  //         .where('docid', isEqualTo: userID)
  //         .snapshots();
  //   } else {
  //     throw Exception('User ID not found in SharedPreferences');
  //   }
  // }

  static PatientAppointment fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return PatientAppointment(
      id: data['id'] as int,
      slot: data['slot'] as String,
      status: data['age'] as bool,
    );
  }
}

class PatientAppointmentsPage extends StatefulWidget {
  @override
  _PatientAppointmentsPageState createState() =>
      _PatientAppointmentsPageState();
}

class _PatientAppointmentsPageState extends State<PatientAppointmentsPage> {
  bool _showSidebar = false;
  bool _showCalendar = false;
  CollectionReference aptData =
      FirebaseFirestore.instance.collection("appointments");

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
          _buildListOfAppointments(),
        ],
      ),
    );
  }

  Widget _buildListOfAppointments() {
    String userId = APIs.auth.currentUser!.uid;
    return FutureBuilder(
      future: aptData.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.size,
            itemBuilder: (context, i) {
              if (snapshot.data!.docs[i]['patId'] == userId) {
                return AppointmentCardPatient(
                  uname: snapshot.data!.docs[i]['docName'].toString(),
                  slot: snapshot.data!.docs[i]['slot'].toString(),
                );
              }
              return Text("");
            },
          );
        }

        // if (snapshot.connectionState == ConnectionState.done) {
        //   Map<String, dynamic> data =
        //       snapshot.data!.data() as Map<String, dynamic>;
        //   return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        // }

        return Text("loading");
      },
    );
  }
}

Widget _buildAppointmentsList(appointments) {
  return ListView.builder(
    itemCount: appointments.length,
    itemBuilder: (context, index) {
      final appointment = appointments[index];
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.teal,
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
          ],
        ),
      );
    },
  );
}

  // void handlePatientInformation(PatientAppointment appointment) {
  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => MedicalRecordPage(patientId: appointment.id)));
  // }

