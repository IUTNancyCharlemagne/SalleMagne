import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salle_magne/styles.dart';
import 'package:salle_magne/widget/navigation_bar_nonco.dart';
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
        if (!sallesParEtage[etage]!.contains(salle)) {
          sallesParEtage[etage]!.add(salle);
        }
      }
    }

    // Trier les étages
    var sortedKeys = sallesParEtage.keys.toList();
    sortedKeys.sort((a, b) {
      if (a == 'Rez-de-chaussée') return -1;
      if (b == 'Rez-de-chaussée') return 1;
      return int.parse(a).compareTo(int.parse(b));
    });

    var sortedSallesParEtage = {
      for (var k in sortedKeys) k: sallesParEtage[k]!
    };

    return sortedSallesParEtage;
  }

  String _extractSalle(String? location) {
    if (location == null || location.isEmpty) {
      return '';
    }

    //expression régulière T-T pour extraire les chiffres de la chaîne
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
        title: Text(
          'Salles pour le cours ${widget.cours}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: colorTheme,
        leading: IconButton(
          icon: Image.asset('assets/images/logoIut.png'),
          onPressed: () async {
            // Retour à la page précédente
            Navigator.pop(context);
          },
        ),
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
      bottomNavigationBar: const NavigationBarNonCo(),
    );
  }

  Widget buildEtageCard(BuildContext context, String etage) {
    List<String> salles = _sallesParEtage[etage]!;

    // Tri des salles par ordre croissant
    salles.sort((a, b) => int.parse(a).compareTo(int.parse(b)));

    return SizedBox(
      width: 500,
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
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: salles
                    .map((salle) => buildSalleTile(context, salle))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSalleTile(BuildContext context, String salle) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: 120,
        height: 60,
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: const Color.fromARGB(255, 10, 80, 138),
          child: InkWell(
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
            child: Center(
              child: Text(
                'Salle $salle',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
