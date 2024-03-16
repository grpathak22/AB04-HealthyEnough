import 'package:flutter/material.dart';
import 'package:healthy_enough/artificial_intelligence/connection.dart';

class AnalyzerPage extends StatefulWidget {
  final String extractedText;
  const AnalyzerPage({super.key, required this.extractedText});

  @override
  State<AnalyzerPage> createState() => _AnalyzerPageState();
}

class _AnalyzerPageState extends State<AnalyzerPage> {
  String prompt = '''{
  "WBC": null,
  "RBC": null,
  "Hemoglobin": null,
  "Hematocrit": null,
  "MCV": null,
  "MCH": null,
  "MCHC": null,
  "Platelets": null,
  "ESR": null,
  "Neutrophils": null,
  "Lymphocytes": null,
  "Monocytes": null,
  "Eosinophils": null,
  "Basophils": null,
  "Sodium": null,
  "Potassium": null,
  "Chloride": null,
  "Calcium": null,
  "Glucose": null,
  "Urea": null,
  "Creatinine": null,
  "Total Cholesterol": null,
  "HDL Cholesterol": null,
  "LDL Cholesterol": null,
  "Triglycerides": null,
  "SGPT": null,
  "SGOT": null,
  "ALP": null,
  "Bilirubin (Total)": null,
  "Bilirubin (Direct)": null,
  "CRP": null,
  "D-Dimer": null,
  "TSH": null,
  "Free T4": null,
  "T3": null,
  "Prolactin": null,
  "FSH": null,
  "LH": null,
  "Testosterone (Males)": null,
  "Estradiol (Females)": null,
  "PSA (Males)": null
}
  Extract the above terms from the given data and convert it into a json format file''';
  bool connected = false;
  late final conn;

  @override
  void initState() {
    conn = EnoughAi();
    super.initState();
    prompt = prompt + widget.extractedText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool result = await conn.connectKey();
          setState(() {
            connected = result;
          });
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(connected ? "Successfull" : "Failed"),
              ElevatedButton(
                onPressed: () async {
                  String? response = await conn.promptGen(prompt);
                  setState(() {
                    prompt = response.toString();
                  });
                },
                child: const Text("Submit"),
              ),
              Text(prompt),
            ],
          ),
        ),
      ),
    );
  }
}
