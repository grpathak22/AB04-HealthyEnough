import 'package:cloud_firestore/cloud_firestore.dart';

class MedicalRecord {
  final CollectionReference colRef =
      FirebaseFirestore.instance.collection("patient_record");

  late String id, name, address, age;
  late int height, weight, b12, d3, fe, hg, rbc, wbc;

  Stream<QuerySnapshot> getMedicalRecords() {
    final recordStream =
        colRef.orderBy('timestamp', descending: false).snapshots();

    print("the stream is : {$recordStream.data!.docs}");
    return recordStream;
  }
}
