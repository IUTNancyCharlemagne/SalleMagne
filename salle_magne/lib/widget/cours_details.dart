import 'package:flutter/material.dart';
import 'package:salle_magne/widget/navigation_bar_nonco.dart';

class CoursDetails extends StatelessWidget {
  final String cours;

  const CoursDetails({Key? key, required this.cours}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Détails du cours : $cours'), // Utilisation de la variable 'cours' plutôt que 'CoursDetails'
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Informations sur le cours $cours', // Utilisation de la variable 'cours' plutôt que 'CoursDetails'
          style: const TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar:
          const NavigationBarNonCo(), // Ajoutez la barre de navigation en bas de la page
    );
  }
}
