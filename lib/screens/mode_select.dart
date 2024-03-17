import 'package:flutter/material.dart';
import 'package:healthy_enough/screens/doctor/kyc_doctor.dart';
import 'package:healthy_enough/screens/doctor/kyc_user.dart';

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
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  onDoctorSelected();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_hospital_outlined,
                          size: 50, color: Colors.white),
                      SizedBox(height: 10),
                      Text('Doctor Login',
                          style: TextStyle(
                            fontFamily: 'abz',
                            fontSize: 22,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            const VerticalDivider(
              thickness: 10,
              color: Colors.black,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  onPatientSelected();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.personal_injury_outlined,
                          size: 50, color: Colors.white),
                      SizedBox(height: 10),
                      Text(
                        'Patient Login',
                        style: TextStyle(
                          fontFamily: 'abz',
                          fontSize: 20,
                        ),
                      ),
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
