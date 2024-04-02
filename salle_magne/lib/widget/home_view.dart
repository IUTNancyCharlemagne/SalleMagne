import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salle_magne/styles.dart';

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
        title: const Text('Titre'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
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
            MaterialButton(
              padding: const EdgeInsets.symmetric(vertical: 16),
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
                ? Image.file(_selectedImage!)
                : const Text('Pas d\'image sélectionnée'),
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
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
