import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  List<Appointment> _appointments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Appointment Calendar'),
      body: Column(
        children: [
          TableCalendar(
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            focusedDay: _selectedDay,
            firstDay: DateTime(DateTime.now().year - 1),
            lastDay: DateTime(DateTime.now().year + 1),
            eventLoader: _getSelectedDayAppointments,
          ),
          Expanded(
            child: _buildTimeline(_selectedDay),
          ),
        ],
      ),
    );
  }

  List<dynamic> _getSelectedDayAppointments(DateTime _selectDay) {
    return _appointments
        .where((appointment) => appointment.date.day == _selectedDay.day)
        .map((appointment) => appointment.date)
        .toList();
  }

  Widget _buildTimeline(DateTime day) {
    final appointments = _appointments
        .where((appointment) => appointment.date.day == day.day)
        .toList();
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return TimelineTile(
          axis: TimelineAxis.vertical,
          alignment: TimelineAlign.start,
          startChild: Container(),
          endChild: Text(appointments[index].summary),
          // indicator: DotIndicator(
          //   color: Colors.blue,
          // ),
          isFirst: index == 0,
          isLast: index == appointments.length - 1,
        );
      },
    );
  }
}

class Appointment {
  final DateTime date;
  final String summary;

  Appointment(this.date, this.summary);
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      automaticallyImplyLeading: false, // Remove the back button
    );
  }
}
