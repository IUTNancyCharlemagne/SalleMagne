import 'package:flutter/material.dart';
import 'widget/home_view.dart';
import 'styles.dart';

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
            primary: colorGrayTheme),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
