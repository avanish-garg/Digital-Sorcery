import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'ocr_service.dart';

void main() {
  runApp(OCRApp());
}

class OCRApp extends StatefulWidget {
  @override
  _OCRAppState createState() => _OCRAppState();
}

class _OCRAppState extends State<OCRApp> {
  final OCRService _ocrService = OCRService();
  File? _image;
  String _recognizedText = '';

  Future<void> _getImageAndRecognizeText(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      String text = await _ocrService.recognizeText(_image!);
      setState(() {
        _recognizedText = text;
      });
    }
  }

  @override
  void dispose() {
    _ocrService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('OCR App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null ? Text('No image selected.') : Image.file(_image!),
              SizedBox(height: 20),
              Text(
                _recognizedText.isEmpty
                    ? 'Recognized text will appear here'
                    : _recognizedText,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _getImageAndRecognizeText(ImageSource.camera),
                child: Text('Capture Image'),
              ),
              ElevatedButton(
                onPressed: () => _getImageAndRecognizeText(ImageSource.gallery),
                child: Text('Select Image from Gallery'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
