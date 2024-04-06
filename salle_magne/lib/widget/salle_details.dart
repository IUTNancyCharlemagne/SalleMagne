import 'package:flutter/material.dart';
import 'package:salle_magne/styles.dart';

import 'package:salle_magne/widget/navigation_bar_nonco.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart' as sf;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SalleDetails extends StatefulWidget {
  final String salle;

  const SalleDetails({super.key, required this.salle});

  @override
  _SalleDetailsState createState() => _SalleDetailsState();
}

class _SalleDetailsState extends State<SalleDetails> {
  bool isFavorite = false;
  late Future<http.Response> coursesList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cours de la salle ${widget.salle}',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: colorTheme,
        actions: [
          IconButton(
            icon: Image.asset(
                'assets/images/logoIut.png'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<sf.Appointment>>(
        future: fetchCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SpinKitFadingCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? colorTheme : colorGrayTheme,
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erreur de chargement des données'),
            );
          } else if (snapshot.hasData) {
            return sf.SfCalendar(
              view: sf.CalendarView.week,
              firstDayOfWeek: 1,
              dataSource: CoursesDataSource(snapshot.data!),
              timeSlotViewSettings: const sf.TimeSlotViewSettings(
                timeIntervalHeight:
                    30, // Réglage de la hauteur des intervalles de temps
                timeInterval: Duration(hours: 1),
                startHour: 7,
                endHour: 19,
                timeFormat: 'HH:mm', // Format 24 heures
              ),
              monthViewSettings: sf.MonthViewSettings(
                appointmentDisplayMode:
                    sf.MonthAppointmentDisplayMode.appointment,
                agendaStyle: sf.AgendaStyle(
                  backgroundColor: Colors.grey[300],
                ),
              ),
              todayHighlightColor: Colors.grey[500],
            );
          } else {
            return const Center(
              child: Text('Pas de données à afficher'),
            );
          }
        },
      ),
      bottomNavigationBar: const NavigationBarNonCo(),
    );

  }

  Future<List<sf.Appointment>> fetchCourses() async {
    try {
      final response = await http.get(Uri.parse(
          'https://docketu.iutnc.univ-lorraine.fr:32499/api/salles?location=${widget.salle}'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<sf.Appointment> courses = [];

        for (var cours in data) {
          List<String> divDateStart = cours['startDate']['date'].split('/');
          List<String> divHeureStart = cours['startDate']['hour'].split(':');
          List<String> divDateEnd = cours['endDate']['date'].split('/');
          List<String> divHeureEnd = cours['endDate']['hour'].split(':');

          courses.add(sf.Appointment(
              startTime: DateTime(
                  int.parse(divDateStart[2]),
                  int.parse(divDateStart[1]),
                  int.parse(divDateStart[0]),
                  int.parse(divHeureStart[0]),
                  int.parse(divHeureStart[1]),
                  0),
              endTime: DateTime(
                  int.parse(divDateEnd[2]),
                  int.parse(divDateEnd[1]),
                  int.parse(divDateEnd[0]),
                  int.parse(divHeureEnd[0]),
                  int.parse(divHeureEnd[1]),
                  0),
              subject: cours['summary'],

              color: Color.fromARGB(255, 19, 104, 216)));

        }
        return courses;
      } else {
        throw Exception('Données non chargées');
      }
    } catch (e) {
      print(e);
      throw Exception('Erreur lors de la récupération des données: $e');
    }
  }
}

class CoursesDataSource extends sf.CalendarDataSource {
  CoursesDataSource(List<sf.Appointment> source) {
    appointments = source;
  }
}
