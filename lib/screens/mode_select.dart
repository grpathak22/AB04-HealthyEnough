import 'package:flutter/material.dart';

class ModeSelection extends StatelessWidget {
  final Function onDoctorSelected;
  final Function onPatientSelected;

  const ModeSelection({
    super.key,
    required this.onDoctorSelected,
    required this.onPatientSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => onDoctorSelected(),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red[200],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_hospital_outlined,
                          size: 50, color: Colors.red),
                      SizedBox(height: 10),
                      Text('Doctor Login'),
                    ],
                  ),
                ),
              ),
            ),
            const VerticalDivider(thickness: 1),
            Expanded(
              child: InkWell(
                onTap: () => onPatientSelected(),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.amber[200],
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.personal_injury_outlined,
                          size: 50, color: Colors.amber),
                      SizedBox(height: 10),
                      Text('Patient Login'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
