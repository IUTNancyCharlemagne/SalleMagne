import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salle_magne/widget/cours_details.dart';
import 'package:salle_magne/widget/navigation_bar_nonco.dart';
import 'package:salle_magne/widget/salle_details.dart';
import 'package:salle_magne/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _selectedImage;
  final TextEditingController _salleController = TextEditingController();
  final TextEditingController _typeCoursController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Salle\' Magne',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: colorTheme,
        leading: IconButton(
          icon: Image.asset('assets/images/logoIut.png'),
          onPressed: () async {
            // Ouvrir l'URL du site de l'IUT dans le navigateur
            const url = 'https://iut-charlemagne.univ-lorraine.fr';
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            } else {
              throw 'Impossible d\'ouvrir $url';
            }
          },
        ),
      ),
      body: SingleChildScrollView(
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
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromRGBO(
                                13, 68, 139, 1)), // Couleur du bouton
                        overlayColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 54, 122, 247)
                                .withOpacity(0.5)), // Couleur de survol
                      ),
                      child: const Text(
                        'Valider',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                  child: Text(
                    'Recherche via une image',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _pickImageFromGallery,
                      child: const Icon(Icons.image),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: _pickImageFromCamera,
                      child: const Icon(Icons.photo_camera),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                _selectedImage != null
                    ? ElevatedButton(
                        onPressed: () async {
                          String? extractedText =
                              await _extractText(_selectedImage!);
                          if (extractedText != null) {
                            _validateAndNavigate(
                              extractedText,
                              'Veuillez entrer un numéro de salle.',
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Cours de la salle ',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                              _extractTextView()
                            ],
                          ),
                        ),
                      )
                    : const Text('Veuillez sélectionner une image'),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                          'Veuillez entrer un cours.',
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromRGBO(
                                13, 68, 139, 1)), // Couleur du bouton
                        overlayColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 54, 122, 247)
                                .withOpacity(0.5)), // Couleur de survol
                      ),
                      child: const Text(
                        'Valider',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _launchMaps();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromRGBO(
                              13, 68, 139, 1)), // Couleur du bouton
                      overlayColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 54, 122, 247)
                              .withOpacity(0.5)), // Couleur de survol
                    ),
                    child: const Text(
                      'Consulter l\'itinéraire',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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

  Widget _extractTextView() {
    if (_selectedImage != null) {
      return FutureBuilder(
        future: _extractText(_selectedImage!),
        builder: (context, snapshot) {
          return Text(
            snapshot.data ?? '',
            style: const TextStyle(fontWeight: FontWeight.w900),
          );
        },
      );
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
    if (textFiltered.length > 3) {
      textFiltered = textFiltered.substring(0, 3);
    }

    textRecogniser.close();

    if (textFiltered.isEmpty) {
      return null;
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

  void _launchMaps() async {
    const url =
        'https://www.google.fr/maps/dir//Institut+Universitaire+de+Technologie+Nancy-Charlemagne,+2Ter+Bd+Charlemagne,+54000+Nancy/@48.6828484,6.1585054,17z/data=!4m17!1m7!3m6!1s0x4794a283532d81a9:0xd8601e71c5802628!2sInstitut+Universitaire+de+Technologie+Nancy-Charlemagne!8m2!3d48.6828484!4d6.1610803!16s%2Fg%2F12151g5g!4m8!1m0!1m5!1m1!1s0x4794a283532d81a9:0xd8601e71c5802628!2m2!1d6.1610803!2d48.6828484!3e3?entry=ttu';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
