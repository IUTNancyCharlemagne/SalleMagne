import 'package:flutter/material.dart';
import 'package:salle_magne/styles.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sf;
import 'package:http/http.dart' as http;
import 'dart:convert';

class SalleDetails extends StatefulWidget {
  final String salle;

  const SalleDetails({Key? key, required this.salle}) : super(key: key);

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
          title: Text('Cours de la salle ${widget.salle}'),
          backgroundColor: colorOrangeTheme,
        ),
        body: FutureBuilder<List<sf.Appointment>>(
          future: fetchCourses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Connexion en attente');
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Erreur de chargement des données'),
              );
            } else if (snapshot.hasData) {
              return sf.SfCalendar(
                view: sf.CalendarView.week,
                firstDayOfWeek: 1,
                dataSource: CoursesDataSource(snapshot.data!),
              );
            } else {
              return const Center(
                child: Text('Pas de données à afficher'),
              );
            }
          },
        ));
  }

  Future<List<sf.Appointment>> fetchCourses() async {

    try {

      final response = await http.get(Uri.parse(
          'https://docketu.iutnc.univ-lorraine.fr:32499/api/salles?location=${widget.salle}'));


      if (response.statusCode == 200) {

        List<dynamic> data = jsonDecode(response.body);
        List<sf.Appointment> courses = [];

        for (var cours in data) {
          courses.add(sf.Appointment(
              startTime: DateTime.parse(cours['startDate']['date']),
              endTime: DateTime.parse(cours['endDate']['date']),
              subject: cours['summary'],
              color: Colors.blue));
        }
        return courses;
      } else {
        throw Exception('Données non chargées');
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération des données: $e');
    }
  }
}

class CoursesDataSource extends sf.CalendarDataSource {
  CoursesDataSource(List<sf.Appointment> source) {
    appointments = source;
  }
}
