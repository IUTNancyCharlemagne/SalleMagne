import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NumberExtractionPage extends StatefulWidget {
  const NumberExtractionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NumberExtractionPageState createState() => _NumberExtractionPageState();
}

class _NumberExtractionPageState extends State<NumberExtractionPage> {
  File? _pickedImage;
  String? _extractedNumber;

  Future<void> _pickImage() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      _extractNumberFromImage();
    }
  }

  Future<void> _extractNumberFromImage() async {
    final imageFile = FirebaseVisionImage.fromFile(_pickedImage!);
    final textRecognizer = FirebaseVision.instance.textRecognizer();
    final visionText = await textRecognizer.processImage(imageFile);
    String extractedText = visionText.text ?? '';

    // Extract numbers from the extracted text
    RegExp regex = RegExp(r'\d+');
    Iterable<Match> matches = regex.allMatches(extractedText);
    setState(() {
      _extractedNumber = matches.map((match) => match.group(0)).join('');
    });

    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extract Numbers'),
      ),
      body: Column(
        children: [
          _pickedImage != null
              ? Image.file(_pickedImage!)
              : const Placeholder(
                  fallbackHeight: 200,
                ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickImage,
            child: const Text('Pick Image'),
          ),
          const SizedBox(height: 20),
          _extractedNumber != null
              ? Text(
                  'Extracted Number: $_extractedNumber',
                  style: const TextStyle(fontSize: 18),
                )
              : Container(),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NumberExtractionPage(),
  ));
}
