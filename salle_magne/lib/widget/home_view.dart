import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salle_magne/styles.dart';
import 'package:salle_magne/widget/calender_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Salle\'magne',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundAppbarColor,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Entrez un numéro de salle',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez rentrer du texte';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 12),
            MaterialButton(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              color: buttonPickFromGalleryColor,
              onPressed: _pickImageFromGallery,
              child: const Text(
                'Image depuis la Gallerie',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 12),
            MaterialButton(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              color: buttonPickFromCameraColor,
              onPressed: _pickImageFromCamera,
              child: const Text(
                'Prendre une photo',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _selectedImage != null
                ? SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.file(_selectedImage!, fit: BoxFit.cover))
                : const Text('Pas d\'image sélectionnée'),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _exctractTextView(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CalendarView()),
          );
        },
        backgroundColor: Colors.black,
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.calendar_today,
          color: Colors.white,
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
    if (_selectedImage == null) {
      return const Center(
        child: Text('Pas de résultat'),
      );
    }
    return FutureBuilder(
        future: _extractText(_selectedImage!),
        builder: (context, snapshot) {
          return Text(
            snapshot.data ?? '',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
          );
        });
  }

  Future<String?> _extractText(File file) async {
    final textRecogniser = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecogniser.processImage(inputImage);

    String text = recognizedText.text;
    String textFiltered = text.replaceAll(new RegExp(r'[^0-9]'), '');
    textRecogniser.close();

    return textFiltered;
  }
}
