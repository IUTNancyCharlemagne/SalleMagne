import 'package:flutter/material.dart';
import 'package:salle_magne/styles.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sf;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
              return SpinKitFadingCircle(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? colorOrangeTheme : colorGrayTheme,
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
              color: Colors.blue));
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
