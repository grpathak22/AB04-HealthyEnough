import 'package:flutter/material.dart';
import 'package://path/to/your/medical_record_model.dart'; // Import your model
import 'dart:convert'; // For JSON parsing

class ViewMedicalRecords extends StatefulWidget {
  final String patientId; // Pass patient ID from previous page

  const ViewMedicalRecords({Key? key, required this.patientId}) : super(key: key);

  @override
  State<ViewMedicalRecords> createState() => _ViewMedicalRecordsState();
}

class _ViewMedicalRecordsState extends State<ViewMedicalRecords> {
  Future<MedicalRecord>? _medicalRecords; // Stores fetched records

  @override
  void initState() {
    super.initState();
    _fetchMedicalRecords(widget.patientId); // Fetch records on init
  }

  Future<MedicalRecord> _fetchMedicalRecords(String patientId) async {
    // Implement logic to fetch JSON data using patient ID (e.g., API call)
    // Replace with your actual data fetching implementation (consider error handling)
    final response = await // ... Your API call logic ...;
    if (response.statusCode == 200) { // Check for successful response
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return MedicalRecord.fromJson(jsonResponse); // Parse JSON to MedicalRecord
    } else {
      throw Exception('Failed to fetch records: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Medical Records'),
      ),
      body: FutureBuilder<MedicalRecord>(
        future: _medicalRecords,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final records = snapshot.data!.records;
            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                // Display each record using a widget (e.g., ListTile)
                return ListTile(
                  title: Text(records[index].title),
                  subtitle: Text(records[index].description),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Display a loading indicator while fetching
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
