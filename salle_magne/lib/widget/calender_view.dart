import 'package:flutter/material.dart';
import 'package:salle_magne/styles.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sf;

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
      body: sf.SfCalendar(
        view: sf.CalendarView.month,
      ),
    );
  }
}
