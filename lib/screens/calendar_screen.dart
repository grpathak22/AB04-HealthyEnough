import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      appBar: AppBar(
        title: Text('Appointment Calendar'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => setState(() => _selectedDay = _selectedDay
              .subtract(Duration(days: 30))), // Adjust for previous month
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () => setState(() => _selectedDay =
                _selectedDay.add(Duration(days: 30))), // Adjust for next month
          ),
        ],
      ),
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
