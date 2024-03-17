import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthy_enough/widgets/slot_card.dart';

class DoctorDetails extends StatefulWidget {
  // final int id;
  final String name;
  const DoctorDetails({super.key, required this.name});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  final CollectionReference doctorRef =
      FirebaseFirestore.instance.collection("appointments");

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: mq.size.height * 0.4,
            width: mq.size.width,
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.person,
                  size: 100,
                ),
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontFamily: "abz",
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: mq.size.height * 0.5,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Work exp or info fetched of this doctor"),
                  Text("Work exp or info fetched of this doctor"),
                  Text("Work exp or info fetched of this doctor"),
                  Text("Check for availability: "),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Time slots: "),
                        SlotCard(isSelected: false),
                        SlotCard(isSelected: false),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: handleAppointmentRequests,
            style: ElevatedButton.styleFrom(
              shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              backgroundColor: Colors.amber,
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
            ),
            child: const Text(
              "Fix Appointment",
              style: TextStyle(
                fontSize: 24,
                fontFamily: "abz",
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> handleAppointmentRequests() async {
    Map<String, dynamic> apptmt = {
      "patId": 1,
      "slot": "9.00-11.00",
      "status": false,
    };

    await doctorRef.doc("doc1").set(apptmt).whenComplete(() {
      print("appointment set");
    });
  }
}
