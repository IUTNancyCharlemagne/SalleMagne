import 'package:flutter/material.dart';
import 'package:salle_magne/styles.dart';
import 'package:salle_magne/widget/home_view.dart';
import 'calender_view.dart';

class NavigationBarNonCo extends StatelessWidget {
  const NavigationBarNonCo({Key? key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
          backgroundColor: Colors.white, // Ajout de la couleur de fond
          activeIcon: Icon(Icons.home,
              color: colorOrangeTheme), // Ajout de l'icône active
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Recherche',
          backgroundColor: Colors.white, // Ajout de la couleur de fond
          activeIcon: Icon(Icons.search,
              color: colorOrangeTheme), // Ajout de l'icône active
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
          backgroundColor: Colors.white, // Ajout de la couleur de fond
          activeIcon: Icon(Icons.person,
              color: colorOrangeTheme), // Ajout de l'icône active
        ),
      ],
      onTap: (index) {
        _navigate(context, index);
      },
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
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CalendarView()),
        );
        break;
    }
  }
}
