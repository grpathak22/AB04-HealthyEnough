import 'package:flutter/material.dart';
import 'package:healthy_enough/artificial_intelligence/connection.dart';

class AnalyzerPage extends StatefulWidget {
  const AnalyzerPage({super.key});

  @override
  State<AnalyzerPage> createState() => _AnalyzerPageState();
}

class _AnalyzerPageState extends State<AnalyzerPage> {
  String prompt = "what is name guruprasad mean";
  bool connected = false;
  late final conn;

  @override
  void initState() {
    conn = EnoughAi();
    super.initState();
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
    );
  }
}
