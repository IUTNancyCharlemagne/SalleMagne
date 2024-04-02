import 'package:flutter/material.dart';

class SalleDetails extends StatelessWidget {
  final String salle;

  const SalleDetails({Key? key, required this.salle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implémentez votre widget de détails de salle ici
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la salle $salle'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Informations sur la salle $salle',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
