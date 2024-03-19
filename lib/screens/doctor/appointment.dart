import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_enough/api/apis.dart';
import 'package:healthy_enough/screens/doctor/record.dart';
import 'package:healthy_enough/widgets/appoinment_patient.dart';
import 'package:healthy_enough/widgets/appointment_doctor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorAppointmentsPage extends StatefulWidget {
  @override
  _DoctorAppointmentsPageState createState() => _DoctorAppointmentsPageState();
}

class _DoctorAppointmentsPageState extends State<DoctorAppointmentsPage> {
  bool _showSidebar = false;
  bool _showCalendar = false;
  final String userId = APIs.auth.currentUser!.uid;
  late String docMail = "";
  late DocumentSnapshot<Map<String, dynamic>> patDetails;
  CollectionReference aptData =
      FirebaseFirestore.instance.collection("appointments");

  @override
  void initState() {
    super.initState();
    fetchPatientDetails("1");
    fetchDoctorMail();
  }

  Future<void> fetchDoctorMail() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> docsnapshot =
          await FirebaseFirestore.instance
              .collection('doctors')
              .doc(userId)
              .get();
      setState(() {
        docMail = docsnapshot['Email'];
      });
    } catch (e) {
      print('Error fetching doctor profile: $e');
    }
  }

  Future<void> fetchPatientDetails(String patId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> patsnapshot =
          await FirebaseFirestore.instance
              .collection('patients')
              .doc(patId)
              .get();
      setState(() {
        patDetails = patsnapshot;
      });
    } catch (e) {
      print('Error fetching doctor profile: $e');
    }
  }

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
    return FutureBuilder(
      future: aptData.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.size,
            itemBuilder: (context, i) {
              if (snapshot.data!.docs[i]['docMail'] == docMail) {
                fetchPatientDetails(snapshot.data!.docs[i]['patId']);
                if (patDetails.data() != null) {
                  return AppointmentCardDoctor(
                    patid: snapshot.data!.docs[i]['patId'],
                    uname: patDetails['Name'],
                    age: patDetails['Age'],
                    height: patDetails['Height'],
                    weight: patDetails['Weight'],
                    blood: patDetails['BloodGroup'],
                    slot: snapshot.data!.docs[i]['slot'].toString(),
                  );
                }
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
  // void handlePatientInformation(PatientAppointment appointment) {
  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => MedicalRecordPage(patientId: appointment.id)));
  // }

