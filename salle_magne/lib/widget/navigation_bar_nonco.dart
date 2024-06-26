import 'package:flutter/material.dart';
import 'package:salle_magne/widget/home_view.dart';
import 'package:salle_magne/styles.dart';
import 'package:salle_magne/widget/login_view.dart';
import 'package:salle_magne/widget/signup_view.dart';

class NavigationBarNonCo extends StatelessWidget {
  const NavigationBarNonCo({Key? key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: colorTheme), // Icône orange
          label: 'Accueil',
          backgroundColor: Color.fromARGB(255, 214, 214, 214),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.login, color: colorTheme), // Icône orange
          label: 'Connexion',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_add, color: colorTheme), // Icône orange
          label: 'Inscription',
          backgroundColor: Colors.white,
        ),
      ],
      onTap: (index) {
        _navigate(context, index);
      },
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
          color: Color.fromARGB(255, 78, 75, 75)), // Style du texte sélectionné
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
    );
  }

  void _navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginView()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpView()),
        );
        break;
    }
  }
}
