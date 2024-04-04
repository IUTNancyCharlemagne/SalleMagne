import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:salle_magne/widget/navigation_bar_nonco.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class SalleCours {
  final String name;
  final DateTime date;

  SalleCours({required this.name, required this.date});
}

class SalleDetails extends StatefulWidget {
  final String salle;

  const SalleDetails({super.key, required this.salle});

  @override
  _SalleDetailsState createState() => _SalleDetailsState();
}

class _SalleDetailsState extends State<SalleDetails> {
  final CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<SalleCours>> _events = {};

  @override
  void initState() {
    super.initState();
    fetchSalleDetails(widget.salle);
  }

  Future<void> fetchSalleDetails(String salle) async {
    final response = await http.get(Uri.parse(
        'http://docketu.iutnc.univ-lorraine.fr:32495/api/salles?location=$salle'));

    if (response.statusCode == 200) {
      final List<dynamic> courses = json.decode(response.body);
      print(courses); // Pour vérifier les données reçues

      setState(() {
        _events = {}; // Réinitialiser la liste des événements
        for (var course in courses) {
          // Extraire les détails du cours depuis le JSON
          String name = course['summary'];
          DateTime startDate = DateTime.parse(course['startDate']['fullDate']);
          // Créer un objet SalleCours
          SalleCours salleCours = SalleCours(name: name, date: startDate);
          // Ajouter l'objet à la liste des événements
          if (_events.containsKey(startDate)) {
            _events[startDate]!.add(salleCours);
          } else {
            _events[startDate] = [salleCours];
          }
        }
      });
    } else {
      throw Exception(
          'Echec du chargement des détails de la salle ${widget.salle}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la salle ${widget.salle}'),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.now().subtract(const Duration(days: 365)),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              eventLoader: (day) {
                return _events[day] ?? [];
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _events[_selectedDay]?.length ?? 0,
                itemBuilder: (context, index) {
                  final List<SalleCours>? courses = _events[_selectedDay];
                  if (courses != null) {
                    final course = courses[index];
                    return ListTile(
                      title: Text(course.name),
                      subtitle: Text(course.date.toString()),
                    );
                  } else {
                    return SizedBox(); // Ou tout autre widget par défaut si _selectedDay est null
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavigationBarNonCo(),
    );
  }
}
