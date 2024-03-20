import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class MedicineReminderScreen extends StatefulWidget {
  @override
  _MedicineReminderScreenState createState() => _MedicineReminderScreenState();
}

class _MedicineReminderScreenState extends State<MedicineReminderScreen> {
  final TextEditingController _medicineController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  List<Map<String, dynamic>> medicines = [];
  String medTime = "";

  @override
  void initState() {
    super.initState();
    initializeNotifications();
  }

  Future<void> initializeNotifications() async {
    tzdata
        .initializeTimeZones(); // Initialize time zones before initializing notifications
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
  }

  Future<void> _scheduleNotification(
      DateTime scheduledNotificationDateTime, String medicineName) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('channel id', 'channel name',
            importance: Importance.max, priority: Priority.high);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    final tz.TZDateTime scheduledDate =
        tz.TZDateTime.from(scheduledNotificationDateTime, tz.local);
    print("done");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Time to take medicine!',
      'Don\'t forget to take your $medicineName.',
      scheduledDate,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> _saveMedicineAndTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final encodedMedicines = prefs.getStringList('medicines');

    if (encodedMedicines != null) {
      medicines = encodedMedicines
          .map((e) => json.decode(e) as Map<String, dynamic>)
          .toList();
    }

    medicines.add({
      'medicine': medTime,
      'time': _timeController.text,
    });

    await prefs.setStringList(
        'medicines', medicines.map((e) => json.encode(e)).toList());

    final scheduledTime = DateTime.parse(medTime);
    await _scheduleNotification(scheduledTime, _medicineController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Medicine added successfully!'),
      ),
    );
  }

  void _showTimePickerDialog() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      setState(() {
        medTime =
            '${now.year}-0${now.month}-${now.day} ${pickedTime.hour}:0${pickedTime.minute}:${DateTime.now().second}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _medicineController,
              decoration: InputDecoration(labelText: 'Medicine Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showTimePickerDialog,
              child: Text('Set Time'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _saveMedicineAndTime();
              },
              child: Text('Add Medicine'),
            ),

            for (int i = 0; i < medicines.length; i++)
              Row(
                children: [
                  Text(medicines[i]['medicine']),
                  Text(medicines[i]['time']),
                ],
              )

            // ListView.builder(
            //   itemCount: medicines.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return Container(
            //       height: mq.size.height * 0.1,
            //       width: mq.size.width,
            //       child: Row(
            //         children: [
            //           Text(medicines[index]['medicine']),
            //           Text(medicines[index]['time']),
            //         ],
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
