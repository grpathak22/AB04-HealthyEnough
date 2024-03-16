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
  final _formKey = GlobalKey<FormState>(); // Create a GlobalKey for the Form

  String? _name;
  String? _address;
  String? _phoneNumber;
  String? _email;

  return Form(
    key: _formKey, // Associate the Form with the GlobalKey
    child: Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Name',
            hintText: 'Enter your name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name.';
            }
            return null; // No error if validation passes
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
            if (value == null || value.isEmpty) {
              return 'Please enter your address.';
            }
            return null;
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
            if (value == null || value.isEmpty) {
              return 'Please enter your mobile number.';
            }
            // You can add more specific validation for phone number format here
            return null;
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
            if (value == null || value.isEmpty) {
              return 'Please enter your email.';
            }
            // You can add more specific validation for email format here (e.g., using a regular expression)
            return null;
          },
          onSaved: (newValue) => _email = newValue!,
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save(); // Call save() to retrieve form data
              // Process the form data (e.g., print, store in variables, send to server)
              print('Name: $_name');
              print('Address: $_address');
              print('Phone Number: $_phoneNumber');
              print('Email: $_email');
            } else {
              // Show an error message or perform other actions if validation fails
              print('Validation failed!');
            }
          },
          child: const Text('Submit'),
        ),
      ],
    ),
  );
}

  Widget buildPage2() {
  final _formKey = GlobalKey<FormState>(); // Create a GlobalKey for the Form

  String? _qualifications;
  String? _specialization;

  return Form(
    key: _formKey, // Associate the Form with the GlobalKey
    child: Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Qualifications',
            hintText: 'Enter your qualifications',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your qualifications.';
            }
            return null; // No error if validation passes
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
            if (value == null || value.isEmpty) {
              return 'Please enter your specialization.';
            }
            return null;
          },
          onSaved: (newValue) => _specialization = newValue!,
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save(); // Call save() to retrieve form data
              // Process the form data (e.g., print, store in variables, send to server)
              print('Qualifications: $_qualifications');
              print('Specialization: $_specialization');
            } else {
              // Show an error message or perform other actions if validation fails
              print('Validation failed!');
            }
          },
          child: const Text('Submit'),
        ),
      ],
    ),
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
