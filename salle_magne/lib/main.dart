import 'package:flutter/material.dart';
import 'package:salle_magne/widget/home_view.dart'; // Importez votre widget home_view.dart
import 'package:salle_magne/styles.dart';
import 'package:salle_magne/widget/navigation_bar_nonco.dart'; // Importez votre widget navigation_bar_co.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salle\'magne',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrangeAccent,
          secondary: Colors.red,
          primary: colorGrayTheme,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Salle\' Magne',
              style: TextStyle(color: Colors.white)),
          backgroundColor: colorOrangeTheme,
        ),
        body: const MyHomePage(),
        bottomNavigationBar: const NavigationBarNonCo(),
      ),
    );
  }
}
