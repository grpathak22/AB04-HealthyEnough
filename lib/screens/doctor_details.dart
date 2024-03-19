import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_enough/widgets/slot_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDetails extends StatefulWidget {
  final docData;
  const DoctorDetails({Key? key, required this.docData}) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  final CollectionReference doctorRef =
      FirebaseFirestore.instance.collection("appointments");

  List<String> _availableSlots = [];

  @override
  void initState() {
    super.initState();
    // Fetch available slots from the availability collection
    _fetchAvailableSlots();
  }

  Future<void> _fetchAvailableSlots() async {
    try {
      final availabilitySnapshot = await FirebaseFirestore.instance
          .collection('availability')
          .doc(widget.docData['doctorId'])
          .get();

      if (availabilitySnapshot.exists) {
        final data = availabilitySnapshot.data() as Map<String, dynamic>;
        final Map<String, dynamic>? availableTimes = data['availableTimes'];

        if (availableTimes != null) {
          final List<String> slots = [];
          availableTimes.forEach((key, value) {
            if (value != null) {
              slots.add('$key: ${value['startTime']} - ${value['endTime']}');
            }
          });

          setState(() {
            _availableSlots = slots;
          });
        } else {
          print('Available times data is null');
        }
      } else {
        print('Availability data does not exist');
      }
    } catch (error) {
      print("Error fetching available slots: $error");
    }
  }

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
                  widget.docData[0],
                  style: const TextStyle(
                    fontFamily: "abz",
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              width: mq.size.width * 0.9,
              height: mq.size.height * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Qualifications: " + widget.docData[5],
                    style: const TextStyle(
                      fontFamily: "abz",
                      fontSize: 20,
                    ),
                  ),
                  Text("Specializations: " + widget.docData[6],
                      style: const TextStyle(
                        fontFamily: "abz",
                        fontSize: 20,
                      )),
                  Text("Email: " + widget.docData[3],
                      style: const TextStyle(
                        fontFamily: "abz",
                        fontSize: 20,
                      )),
                  Text("Address: " + widget.docData[2],
                      style: const TextStyle(
                        fontFamily: "abz",
                        fontSize: 20,
                      )),
                  Text("Phone Number: " + widget.docData[4].toString(),
                      style: const TextStyle(
                        fontFamily: "abz",
                        fontSize: 20,
                      )),
                  const Text("Check for availability: "),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Time slots: "),
                        for (String slot in _availableSlots)
                          SlotCard(
                            isSelected:
                                false, // You can adjust this based on selected slots
                            slot: slot,
                          ),
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
    final sharePref = await SharedPreferences.getInstance();
    Map<String, dynamic> apptmt = {
      "docMail": widget.docData[3],
      "patId": sharePref.get('UserId'),
      "docName": widget.docData[0],
      "slot": "9.00-11.00",
      "status": false,
    };

    await doctorRef.add(apptmt).whenComplete(() {
      print("appointment set");
    });
  }
}
