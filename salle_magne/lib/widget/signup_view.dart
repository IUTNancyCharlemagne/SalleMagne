import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ajoutez ici les champs de saisie pour l'inscription
            // par exemple : TextFormField(labelText: 'Nom'),
            //                 TextFormField(labelText: 'Email'),
            //                 TextFormField(labelText: 'Mot de passe'),
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique d'inscription
              },
              child: const Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}
