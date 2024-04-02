import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salle_magne/widget/card_accueil.dart';

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
        title: const Text('Salle\' Magne'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImageFromGallery,
                  icon: const Icon(Icons.image),
                  label: const Text('Image depuis la Gallerie'),
                ),
                ElevatedButton.icon(
                  onPressed: _pickImageFromCamera,
                  icon: const Icon(Icons.photo_camera),
                  label: const Text('Prendre une photo'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _selectedImage != null
                ? Image.file(_selectedImage!)
                : const CustomCard(
                    margin: EdgeInsets.zero,
                    child: Text(
                      'Pas d\'image sélectionnée',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
          ],
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
}
