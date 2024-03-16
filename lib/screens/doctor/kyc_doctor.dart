import 'package:flutter/material.dart';
import 'package:healthy_enough/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // For validation

  // Page state variables
  int currentPage = 1;
  String _name = "";
  String _address = "";
  String _phoneNumber = "";
  String _email = "";
  String _qualifications = "";
  String _specialization = "";
  String _hospitalIDPath = "";
  // Add variable to store hospital ID data (e.g., file path)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Progress bar (replace with actual progress indicator)
                LinearProgressIndicator(
                  value: currentPage / 3, // Adjust based on number of pages
                ),
                const SizedBox(height: 20.0),
                buildPageContent(currentPage),
                const SizedBox(height: 20.0),
                buildNextButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPageContent(int page) {
    switch (page) {
      case 1:
        return buildPage1();
      case 2:
        return buildPage2();
      case 3:
        return buildPage3();
      default:
        return const Text('Error: Invalid page');
    }
  }

  Widget buildPage1() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Name',
            hintText: 'Enter your name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic (e.g., check if name is not empty)
          },
          onSaved: (newValue) => _name = newValue!,
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Address',
            hintText: 'Enter your address',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic
          },
          onSaved: (newValue) => _address = newValue!,
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Mobile Number',
            hintText: 'Enter your mobile number',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic
          },
          onSaved: (newValue) => _phoneNumber = newValue!,
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Email ID',
            hintText: 'Enter your email',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic (e.g., check for valid email format)
          },
          onSaved: (newValue) => _email = newValue!,
        ),
      ],
    );
  }

  Widget buildPage2() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Qualifications',
            hintText: 'Enter your qualifications',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            // Add validation logic
          },
          onSaved: (newValue) => _qualifications = newValue!,
        ),
        const SizedBox(height: 20.0),
        TextFormField(
            decoration: const InputDecoration(
              labelText: 'Specialization',
              hintText: 'Enter your specialization',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              return null;

              // Add validation logic
            },
            onSaved: (newValue) => _specialization),
      ],
    );
  }

  Widget buildPage3() {
    return Row(
      children: [
        const Text(
          'Upload Hospital ID:',
          style: TextStyle(fontSize: 16.0),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () async {
            // **Ensure proper indentation for setState**
            setState(() async {
              // Implement hospital ID upload logic here (e.g., image picker)
              final image =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image != null) {
                _hospitalIDPath = image.path;
              }
            });
          },
          child: const Text('Upload'),
        ),
      ],
    );
  }

  Widget buildNextButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (currentPage == 3) {
          // Handle registration logic here (validation, calling backend)
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            _register(context);
          }
        } else if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          setState(() {
            currentPage++;
          });
        }
      },
      child: currentPage == 3 ? const Text('Register') : const Text('Next'),
    );
  }

  void _register(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Registration Page',
    home: RegistrationPage(),
  ));
}
