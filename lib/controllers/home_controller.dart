import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class HomeController {
  bool _isDNI(String text) {
    text = text.toUpperCase();
    final isDNI =
        text.contains('REGISTRO NACIONAL') &&
        text.contains('REPÚBLICA DE HONDURAS');

    return isDNI;
  }

  String _findKey(String line) {
    line = line.toLowerCase();
    if (line.contains('nombre')) {
      return 'Nombre';
    }

    if (line.contains('apellido') || line.contains('surname')) {
      return 'Apellido';
    }

    if (line.contains('fecha de nacimiento') ||
        line.contains('date of birth')) {
      return 'Fecha de nacimiento';
    }

    if (line.contains('nacionalidad') || line.contains('nationality')) {
      return 'Nacionalidad';
    }

    if (line.contains('lugar') || line.contains('place')) {
      return 'Lugar de Nacimiento';
    }

    if (line.contains('id number')) {
      return 'Número de Identidad';
    }

    if (line.contains('expiración') || line.contains('expiry')) {
      return 'Fecha de Expiración';
    }

    return '';
  }

  void scanDni(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se selecciono ninguna imagen')),
      );
      return;
    }

    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final recognized = await textRecognizer.processImage(
      InputImage.fromFilePath(image.path),
    );

    if (!_isDNI(recognized.text)) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('NO ES UN DNI')));
      return;
    }
  }
}

final HomeController homeController = HomeController();
