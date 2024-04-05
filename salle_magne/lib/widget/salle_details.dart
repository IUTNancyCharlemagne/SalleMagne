import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salle_magne/widget/event.dart';
import 'package:salle_magne/widget/navigation_bar_nonco.dart';
import 'package:http/http.dart' as http;

class SalleDetails extends StatefulWidget {
  final String salle;

  const SalleDetails({Key? key, required this.salle}) : super(key: key);

  @override
  _SalleDetailsState createState() => _SalleDetailsState();
}

class _SalleDetailsState extends State<SalleDetails> {
  List<Event>? _events;
  late List<DateTime> _availableDates = [];

  @override
  void initState() {
    super.initState();
    fetchSalleDetails(widget.salle);
  }

  Future<void> fetchSalleDetails(String salle) async {
    try {
      final response = await http.get(Uri.parse(
          'http://docketu.iutnc.univ-lorraine.fr:32495/api/salles?location=$salle'));

      if (response.statusCode == 200) {
        final List<dynamic> eventData = json.decode(response.body);
        setState(() {
          _events = parseEventsFromAPI(eventData);
          _availableDates = extractAvailableDates(eventData);
        });
      } else {
        throw Exception(
            'Echec du chargement des détails de la salle ${widget.salle}');
      }
    } catch (error) {
      print('Erreur lors de la récupération des détails de la salle: $error');
    }
  }

  List<Event> parseEventsFromAPI(List<dynamic> eventData) {
    List<Event> events = [];
    for (var data in eventData) {
      String summary = data['summary'];

      DateTime startDate = parseDate(data['startDate']['date']);
      DateTime endDate = parseDate(data['endDate']['date']);

      // Extraire les heures de début et de fin
      DateTime startTime = startDate.add(Duration(
          hours: int.parse(data['startDate']['hour'].split(':')[0]),
          minutes: int.parse(data['startDate']['hour'].split(':')[1])));
      DateTime endTime = endDate.add(Duration(
          hours: int.parse(data['endDate']['hour'].split(':')[0]),
          minutes: int.parse(data['endDate']['hour'].split(':')[1])));

      Event event = Event(
        name: summary,
        date: startDate,
        startTime: startTime,
        endTime: endTime,
      );
      events.add(event);
    }
    return events;
  }

  List<DateTime> extractAvailableDates(List<dynamic> eventData) {
    Set<DateTime> dates = {};
    for (var data in eventData) {
      DateTime startDate = parseDate(data['startDate']['date']);
      dates.add(startDate);
    }
    return dates.toList();
  }

  DateTime parseDate(String dateString) {
    // Séparer la chaîne de date en jour, mois et année
    List<String> parts = dateString.split('/');
    // Convertir chaque partie en entier
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    // Créer et retourner un objet DateTime
    return DateTime(year, month, day);
  }

  @override
  Widget build(BuildContext context) {
    String salleDetails = 'Détails : ';
    if (widget.salle.length > 2) {
      salleDetails += '${widget.salle[0]}ème étage , salle ${widget.salle}';
    } else {
      salleDetails += 'rez-de-chaussée, salle ${widget.salle}';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          salleDetails,
          style: const TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.grey,
      ),
      body: _events != null
          ? Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _availableDates
                      .map((date) => buildDateCard(context, date))
                      .toList(),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: const NavigationBarNonCo(),
    );
  }

  Widget buildDateCard(BuildContext context, DateTime date) {
    List<Event> eventsForDate =
        _events!.where((event) => event.date == date).toList();

    return SizedBox(
      width: 400, // Largeur fixe pour chaque carte
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date: ${date.day}/${date.month}/${date.year}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              ...eventsForDate
                  .map((event) => buildEventCard(context, event))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEventCard(BuildContext context, Event event) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nom du cours: ${event.name}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
              'Heure de début: ${event.startTime.hour}:${event.startTime.minute}'),
          Text('Heure de fin: ${event.endTime.hour}:${event.endTime.minute}'),
        ],
      ),
    );
  }
}
