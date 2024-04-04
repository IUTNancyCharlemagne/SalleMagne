import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ajoutez ici les champs de saisie pour la connexion
            // par exemple : TextFormField(labelText: 'Email'),
            //                 TextFormField(labelText: 'Mot de passe'),
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique de connexion
              },
              child: const Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
