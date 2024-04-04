import 'package:flutter/material.dart';
import 'package:salle_magne/widget/navigation_bar_nonco.dart'; // Importez votre barre de navigation

class SalleDetails extends StatefulWidget {
  final String salle;

  const SalleDetails({Key? key, required this.salle}) : super(key: key);

  @override
  _SalleDetailsState createState() => _SalleDetailsState();
}

class _SalleDetailsState extends State<SalleDetails> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la salle ${widget.salle}'),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Informations sur la salle ${widget.salle}',
                  style: const TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: isFavorite ? Colors.yellow : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                ),
              ],
            ),
            // Ajoutez ici d'autres widgets pour afficher les détails de la salle
          ],
        ),
      ),
      bottomNavigationBar:
          const NavigationBarNonCo(), // Ajoutez la barre de navigation en bas de la page
    );
  }
}
