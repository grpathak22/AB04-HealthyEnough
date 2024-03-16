import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:healthy_enough/helper/medical_record.dart';

class MedicalRecordPage extends StatefulWidget {
  final int patientId; // Pass patient ID from previous page

  const MedicalRecordPage({Key? key, required this.patientId})
      : super(key: key);

  @override
  State<MedicalRecordPage> createState() => _MedicalRecordPageState();
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
              List recordData = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: recordData.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = recordData[index];

                    Map<String, dynamic> data =
                        doc.data() as Map<String, dynamic>;
                    int fe = data['D3'];

                    return ListTile(
                      title: Text("Ferretin: {$fe}"),
                    );
                  });
            } else {
              return const Text("Nothing found");
            }
          },
        ));
  }
}
