import 'package:flutter/material.dart';

class SlotCard extends StatefulWidget {
  final bool isSelected;

  const SlotCard({required this.isSelected});

  @override
  State<SlotCard> createState() => _SlotCardState();
}

class _SlotCardState extends State<SlotCard> {
  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = !_selected;
        });
      },
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: _selected ? Colors.grey : Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(child: Text("Slot")),
      ),
    );
  }
}
