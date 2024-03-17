import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final name;
  const DoctorCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.amber,
            offset: Offset(2, 2),
          )
        ],
        color: Colors.white,
      ),
      height: 100,
      width: 130,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(Icons.person),
          Text(
            name,
            style: const TextStyle(
              fontFamily: "abz",
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
