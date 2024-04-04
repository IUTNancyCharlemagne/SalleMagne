import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salle_magne/widget/cours_details.dart';
import 'package:salle_magne/widget/favorites_pages.dart';
import 'package:salle_magne/widget/itineraire.dart';
import 'package:salle_magne/widget/salle_details.dart';
import 'package:salle_magne/widget/calender_view.dart';
import 'package:salle_magne/styles.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _selectedImage;
  final TextEditingController _salleController = TextEditingController();
  final TextEditingController _typeCoursController = TextEditingController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          title: const Text('Salle\' Magne',
              style: TextStyle(color: Colors.white)),
          backgroundColor: colorAppBar),
      actions: [
          IconButton(
            icon: const ImageIcon(AssetImage('assets/images/logoIut.png')),
            iconSize: 48, // Spécifiez la taille souhaitée ici
            color: null,
            onPressed: () {
              // Action à effectuer lors du clic sur le logo
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesPage(
                    favoriteItems: [],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Wrap the body with SingleChildScrollView
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Recherche par numéro de salle',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextFormField(
                        controller: _salleController,
                        decoration: const InputDecoration(
                          labelText: 'Numéro de salle ',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            _validateAndNavigate(
                              _salleController.text,
                              'Veuillez entrer un numéro de salle.',
                            );
                          },
                          child: const Text('Valider'),
                        ))),
                const SizedBox(height: 12),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [

        title: const Text('Salle\' Magne'),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            icon: const ImageIcon(AssetImage('assets/images/logoIut.png')),
            iconSize: 48, // Spécifiez la taille souhaitée ici
            color: null,
            onPressed: () {
              // Action à effectuer lors du clic sur le logo
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesPage(
                    favoriteItems: [],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(e
                  ElevatedButton(
                    onPressed: _pickImageFromGallery,
                    child: const Icon(Icons.image),
                  ),

                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: _pickImageFromCamera,
                    child: const Icon(Icons.photo_camera),
                  ),
                ]),
                const SizedBox(height: 30),
                _selectedImage != null
                    ? SizedBox(
                        width: 300,
                        height: 200,
                        child: Image.file(_selectedImage!, fit: BoxFit.cover))
                    : const Text('Veuillez sélectionner une image'),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _exctractTextView(),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Recherche par cours',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextFormField(
                        controller: _typeCoursController,
                        decoration: const InputDecoration(
                          labelText: 'Type de cours',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        _validateAndNavigate(
                          _typeCoursController.text,
                          'Veuillez entrer un type de cours.',
                        );
                      },
                      child: const Text('Valider'),
                    ),
                  ),
                ),
              ],
            ),

          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: DotNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          DotNavigationBarItem(
            icon: const Icon(Icons.home, size: 20), // Adjust icon size
            selectedColor: Colors.blue,
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.search, size: 20), // Adjust icon size
            selectedColor: Colors.green,
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.notifications, size: 20), // Adjust icon size
            selectedColor: Colors.orange,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItineraireVersIUTPage(),
              ),
            );
          },
          child: const Text('Itinéraire vers l\'IUT'),
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final imageReturn =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageReturn != null) {
      setState(() {
        _selectedImage = File(imageReturn.path);
      });
    } else {
      setState(() {
        _selectedImage = null;
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final imageReturn =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (imageReturn != null) {
      setState(() {
        _selectedImage = File(imageReturn.path);
      });
    } else {
      setState(() {
        _selectedImage = null;
      });
    }
  }

  Widget _exctractTextView() {
    if (_selectedImage != null) {
      return FutureBuilder(
          future: _extractText(_selectedImage!),
          builder: (context, snapshot) {
            return Text(
              snapshot.data ?? '',
              style: const TextStyle(fontWeight: FontWeight.w700),
            );
          });
    }
    return Container();
  }

  Future<String?> _extractText(File file) async {
    final textRecogniser = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecogniser.processImage(inputImage);

    String text = recognizedText.text;
    String textFiltered = text.replaceAll(RegExp(r'[^0-9]'), '');
    textRecogniser.close();

    if (textFiltered.isEmpty) {
      return "Aucun résultat interprété";
    } else {
      return textFiltered;
    }
  }

  void _validateAndNavigate(String inputValue, String dialogMessage) {
    if (inputValue.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erreur'),
            content: Text(dialogMessage),
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
    } else {
      if (_salleController.text.isNotEmpty &&
          _typeCoursController.text.isEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SalleDetails(salle: inputValue),
          ),
        );
      } else if (_typeCoursController.text.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CoursDetails(cours: inputValue),
          ),
        );
      }
    }
  }
}
