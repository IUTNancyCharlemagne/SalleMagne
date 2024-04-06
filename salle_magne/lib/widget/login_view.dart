import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salle_magne/widget/navigation_bar_nonco.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(13, 68, 139, 1),
        title: const Text(
          'S\'inscrire sur Salle\'magne',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Image.asset('assets/images/logoIut.png'),
          onPressed: () async {
            // Retour à la page précédente
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: nomController,
                            style: const TextStyle(
                                color: Color.fromRGBO(13, 68, 139, 1)),
                            decoration: const InputDecoration(
                              labelText: 'Nom',
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(13, 68, 139, 1)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(13, 68, 139, 1)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 17, 71, 187)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: prenomController,
                            style: const TextStyle(
                                color: Color.fromRGBO(13, 68, 139, 1)),
                            decoration: const InputDecoration(
                              labelText: 'Prénom',
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(13, 68, 139, 1)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(13, 68, 139, 1)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 17, 71, 187)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: emailController,
                            style: const TextStyle(
                                color: Color.fromRGBO(13, 68, 139, 1)),
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(13, 68, 139, 1)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(13, 68, 139, 1)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 17, 71, 187)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            style: const TextStyle(
                                color: Color.fromRGBO(13, 68, 139, 1)),
                            decoration: const InputDecoration(
                              labelText: 'Mot de passe',
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(13, 68, 139, 1)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(13, 68, 139, 1)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 17, 71, 187)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            style: const TextStyle(
                                color: Color.fromRGBO(13, 68, 139, 1)),
                            decoration: const InputDecoration(
                              labelText: 'Confirmer le mot de passe',
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(13, 68, 139, 1)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(13, 68, 139, 1)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 17, 71, 187)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await _register(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromRGBO(
                              13, 68, 139, 1)), // Couleur du bouton
                      overlayColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 54, 122, 247)
                              .withOpacity(0.5)), // Couleur de survol
                    ),
                    child: const Text('S\'inscrire',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavigationBarNonCo(),
    );
  }

  Future<void> _register(BuildContext context) async {
    final String nom = nomController.text;
    final String prenom = prenomController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    // Validation des champs
    if (nom.isEmpty ||
        prenom.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erreur'),
            content: const Text('Veuillez remplir tous les champs.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Vérification de la correspondance des mots de passe
    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erreur'),
            content: const Text('Les mots de passe ne correspondent pas.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Requête d'inscription à l'API
    final Uri url = Uri.parse(
        'https://docketu.iutnc.univ-lorraine.fr:32499/api/inscription');
    final String credentials = base64Encode(utf8.encode('$email:$password'));
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $credentials',
    };
    final Map<String, String> body = {
      'nom': nom,
      'prenom': prenom,
    };

    try {
      final response =
          await http.post(url, headers: headers, body: json.encode(body));
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        // Inscription réussie, vous pouvez naviguer vers la page suivante
        // Par exemple : Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NextPage()));
      } else {
        // Affichage d'un message d'erreur en cas d'échec de l'inscription
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erreur'),
              content: Text(responseData['message']),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Erreur lors de l\'inscription : $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erreur'),
            content: const Text(
                'Une erreur s\'est produite lors de l\'inscription.'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
