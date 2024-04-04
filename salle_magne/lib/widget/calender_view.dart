import 'package:flutter/material.dart';
import 'package:salle_magne/styles.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendrier',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: colorOrangeTheme,
      ),
      body: Center(
          child: TableCalendar(
        firstDay: DateTime(2024, 3, 1),
        lastDay: DateTime(2024, 30, 3),
        focusedDay: DateTime.now(),
      )),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}
