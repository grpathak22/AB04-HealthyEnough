import 'package:flutter/material.dart';
import 'package:healthy_enough/artificial_intelligence/connection.dart';

class SymptoScan extends StatefulWidget {
  const SymptoScan({super.key});

  @override
  State<SymptoScan> createState() => _SymptoScanState();
}

class _SymptoScanState extends State<SymptoScan> {
  final controller = TextEditingController();
  String? result = ""; // Improved naming for clarity
  bool isLoading = false; // Track loading state
  FocusNode focusNode = FocusNode(); // Create a FocusNode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Checker'),
      ),
      body: GestureDetector(
        onTap: () => focusNode.unfocus(), // Dismiss keyboard on tap outside
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align content to left
            children: [
              // Title with icon
              Row(
                children: [
                  Icon(Icons.sick, color: Theme.of(context).primaryColor),
                  SizedBox(width: 10),
                  Text(
                    'SymptoScan',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Input field with improved styling
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Enter Symptoms',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                maxLines: 3,
                textInputAction: TextInputAction.done,
                focusNode: focusNode, // Assign the FocusNode
              ),
              SizedBox(height: 20),
              // Row for loading indicator and submit button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Loading indicator while fetching results
                  if (isLoading) CircularProgressIndicator(),
                  // Submit button with better styling
                  ElevatedButton(
                    onPressed: getSymptomResult,
                    child: Text('Analyze Symptoms'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Display result with clear formatting and potential divider
              if (result?.isNotEmpty ?? false)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Potential Analysis:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    Text(
                      result!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              // Error message display
              if (isLoading == false && result!.isEmpty ?? true)
                Text(
                  '',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getSymptomResult() async {
    setState(() {
      isLoading = true; // Show loading indicator
      result = ''; // Clear previous result
    });

    try {
      final model = EnoughAi();
      final prompt = '''These are the symptoms of a patient, analyze these and tell me what can be the potential diseases
         , give me a brief paragraph each of 40 words of diseases,symptoms and their medications and treatment. display in the end with bigger text size "CONSULT DOCTOR" . dont use bold text but increase text size for heading and remove astrix from text :\n${controller.text}''';

      await model.connectKey();
      final resultText = await model.promptGen(prompt);

      setState(() {
        isLoading = false; // Hide loading indicator
        result = resultText;
      });
    } catch (error) {
      // Handle errors (e.g., network issues, model errors)
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }
}
