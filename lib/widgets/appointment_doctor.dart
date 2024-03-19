import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppointmentCardDoctor extends StatefulWidget {
  final String patid;
  final String uname;
  final String blood;
  final String height;
  final String age;
  final String weight;
  final String slot;
  const AppointmentCardDoctor({
    super.key,
    required this.uname,
    required this.slot,
    required this.blood,
    required this.height,
    required this.age,
    required this.weight,
    required this.patid,
  });

  @override
  State<AppointmentCardDoctor> createState() => _AppointmentCardDoctorState();
}

class _AppointmentCardDoctorState extends State<AppointmentCardDoctor> {
  final _overlayController = OverlayPortalController();
  late DocumentSnapshot<Map<String, dynamic>> patDets;

  @override
  void initState() {
    super.initState();
    _fetchPatientRecords();
  }

  Future<void> _fetchPatientRecords() async {
    patDets = await FirebaseFirestore.instance
        .collection("patient_record")
        .doc(widget.patid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
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
            onPressed: _overlayController.toggle,
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: Colors.teal,
            ),
            child: OverlayPortal(
              controller: _overlayController,
              overlayChildBuilder: (BuildContext context) {
                return Scaffold(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: FloatingActionButton(
                    onPressed: _overlayController.toggle,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.clear_rounded),
                  ),
                  body: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        width: mq.size.width * 0.8,
                        height: mq.size.height * 0.8,
                        margin: const EdgeInsets.symmetric(vertical: 80),
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.teal,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                              style: const TextStyle(
                                fontFamily: "abz",
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                const TextSpan(
                                  text: "Patient Name: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: "${widget.uname}\n"),
                                const TextSpan(
                                  text: "Age: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: "${widget.age}\n"),
                                const TextSpan(
                                  text: "Height: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: "${widget.height}\n"),
                                const TextSpan(
                                  text: "Weight: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: "${widget.weight}\n"),
                                const TextSpan(
                                  text: "Blood Grp: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: widget.blood),
                              ],
                            )),
                            const Divider(
                              thickness: 2,
                              color: Colors.black,
                            ),
                            const Text(
                              "Patient Records: \n",
                              style: TextStyle(
                                fontFamily: "abz",
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Table(
                              border: TableBorder.all(width: 2),
                              columnWidths: const {
                                0: FlexColumnWidth(2),
                                1: FlexColumnWidth(1),
                              },
                              children: _formRecordTable(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: const Text(
                "Details",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<TableRow> _formRecordTable() {
    List<TableRow> rows = [];

    patDets.data()!.forEach((key, value) {
      if (value != null) {
        rows.add(TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                child: Text(
                  key,
                  style: const TextStyle(
                    fontFamily: "abz",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            TableCell(
                child: Center(
              child: Text(
                value.toString(),
                style: const TextStyle(
                  fontFamily: "abz",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ))
          ],
        ));
      }
    });

    return rows;
  }
}
