import 'package:flutter/material.dart';
import 'widget/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salle\'magne',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrangeAccent,
            secondary: Colors.red,
            primary: Colors.orange),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
