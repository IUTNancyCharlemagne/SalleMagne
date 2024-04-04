import 'package:flutter/material.dart';
import 'package:salle_magne/widget/calender_view.dart';
import 'package:salle_magne/widget/home_view.dart';
import 'package:salle_magne/widget/login_view.dart';
import 'package:salle_magne/widget/signup_view.dart';
import 'package:salle_magne/styles.dart';

class NavigationBarNonCo extends StatelessWidget {
  const NavigationBarNonCo({Key? key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: colorOrangeTheme), // Icône orange
          label: 'Accueil',
          backgroundColor: Color.fromARGB(255, 214, 214, 214),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today,
              color: colorOrangeTheme), // Icône orange
          label: 'Calendrier',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.login, color: colorOrangeTheme), // Icône orange
          label: 'Connexion',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_add, color: colorOrangeTheme), // Icône orange
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
          MaterialPageRoute(builder: (context) => const CalendarView()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignUpView()),
        );
        break;
    }
  }
}
