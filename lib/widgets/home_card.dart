import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double elevation;
  final Color color;

  const HomeCard({
    super.key,
    required this.text,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
    this.borderRadius = 8,
    this.elevation = 4,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: "abz",
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
