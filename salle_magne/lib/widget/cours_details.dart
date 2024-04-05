import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salle_magne/widget/salle_details.dart';

class CoursDetails extends StatefulWidget {
  final String cours;

  const CoursDetails({Key? key, required this.cours}) : super(key: key);

  @override
  _CoursDetailsState createState() => _CoursDetailsState();
}

class _CoursDetailsState extends State<CoursDetails> {
  Map<String, List<String>> _sallesParEtage = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSallesParEtage(widget.cours);
  }

  Future<void> fetchSallesParEtage(String cours) async {
    try {
      final response = await http.get(Uri.parse(
          'http://docketu.iutnc.univ-lorraine.fr:32495/api/salles?summary=$cours'));

      if (response.statusCode == 200) {
        final List<dynamic> salleData = json.decode(response.body);
        setState(() {
          _sallesParEtage = groupSallesParEtage(salleData);
          _isLoading = false;
        });
      } else {
        throw Exception(
            'Echec du chargement des détails de la salle pour le cours $cours');
      }
    } catch (error) {
      print('Erreur lors de la récupération des détails de la salle: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Map<String, List<String>> groupSallesParEtage(List<dynamic> salleData) {
    Map<String, List<String>> sallesParEtage = {};
    for (var data in salleData) {
      String? etage = _extractEtage(data['location']);
      String salle = _extractSalle(data['location']);
      if (etage != null) {
        if (!sallesParEtage.containsKey(etage)) {
          sallesParEtage[etage] = [];
        }
        sallesParEtage[etage]!.add(salle);
      }
      String cours = data['summary'];
    }
    return sallesParEtage;
  }

  String _extractSalle(String? location) {
    if (location == null || location.isEmpty) {
      return '';
    }

    // Utilisation d'une expression régulière pour extraire les chiffres de la chaîne
    RegExp regExp = RegExp(r'(\d{1,3})');
    Match? match = regExp.firstMatch(location);
    if (match != null) {
      return match.group(0)!;
    }
    return '';
  }

  String? _extractEtage(String? location) {
    if (location == null || location.isEmpty) {
      return null;
    }

    // Utilisation d'une expression régulière pour extraire les chiffres de la chaîne
    RegExp regExp = RegExp(r'(\d{1,3})');
    Match? match = regExp.firstMatch(location);
    if (match != null) {
      int numero = int.parse(match.group(0)!);
      // Si le numéro est à un chiffre ou deux chiffres, c'est le rez-de-chaussée
      if (numero < 100) {
        return 'Rez-de-chaussée';
      } else {
        // Sinon, le premier chiffre représente l'étage
        return match.group(0)![0];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salles pour le cours ${widget.cours}'),
        backgroundColor: Colors.grey,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _sallesParEtage.isNotEmpty
              ? Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: _sallesParEtage.keys
                          .map((etage) => buildEtageCard(context, etage))
                          .toList(),
                    ),
                  ),
                )
              : const Center(
                  child: Text(
                    'Erreur lors du chargement des données.',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
    );
  }

  Widget buildEtageCard(BuildContext context, String etage) {
    List<String> salles = _sallesParEtage[etage]!;
    return SizedBox(
      width: 600,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Etage $etage',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              ...salles.map((salle) => buildSalleTile(context, salle)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSalleTile(BuildContext context, String salle) {
    return SizedBox(
      width: 600, // Définissez une largeur maximale pour les tuiles
      child: ListTile(
        title: Text('Cours en $salle'),
        onTap: () {
          // Naviguer vers la page de détails de la salle
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SalleDetails(
                salle: salle,
              ),
            ),
          );
        },
      ),
    );
  }
}
