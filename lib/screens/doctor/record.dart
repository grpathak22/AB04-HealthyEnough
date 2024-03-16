import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_enough/helper/medical_record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class MedicalRecordPage extends StatefulWidget {
  final int patientId; // Pass patient ID from previous page

  const MedicalRecordPage({Key? key, required this.patientId}) : super(key: key);

  @override
  State<MedicalRecordPage> createState() => _MedicalRecordPageState();
}


class MedicalRecord {
  // Assuming you have a reference to your Firestore collection
  final CollectionReference medicalRecordsCollection =
      FirebaseFirestore.instance.collection('patient_record');

  // Method to get medical records stream
  Stream<QuerySnapshot> getMedicalRecords() {
    return medicalRecordsCollection.snapshots();
  }
}


class _MedicalRecordPageState extends State<MedicalRecordPage> {
  final MedicalRecord medicalRecord = MedicalRecord();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Medical Records'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: medicalRecord.getMedicalRecords(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> records = snapshot.data!.docs;

            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> recordData = records[index].data() as Map<String, dynamic>;

                // Build a list of Text widgets for each field in the record
                List<Widget> fields = [];
                recordData.forEach((key, value) {
                  fields.add(
                    ListTile(
                      title: Text("$key: $value"),
                    ),
                  );
                });

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        "Record ${index + 1}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...fields, // Spread operator to include the list of Text widgets
                    Divider(), // Add a divider between records
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: Text("No records found"),
            );
          }
        },
      ),
    );
  }
}
