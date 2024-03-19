import 'package:flutter/material.dart';

class AppointmentCardPatient extends StatefulWidget {
  final String uname;
  final String slot;
  const AppointmentCardPatient(
      {super.key, required this.uname, required this.slot});

  @override
  State<AppointmentCardPatient> createState() => _AppointmentCardPatientState();
}

class _AppointmentCardPatientState extends State<AppointmentCardPatient> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.uname,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: "abz",
            ),
          ),
          Text(widget.slot),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: BeveledRectangleBorder(),
            ),
            child: const Text("Details"),
          )
        ],
      ),
    );
  }
}
