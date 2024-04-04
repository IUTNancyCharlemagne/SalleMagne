import 'package:flutter/material.dart';
import 'package:salle_magne/styles.dart';
import 'package:salle_magne/widget/home_view.dart';

class AppNavigation extends StatelessWidget {
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
      home: const Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}
