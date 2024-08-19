import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';

class OCRService {
  final TextRecognizer _textRecognizer = GoogleMlKit.vision.textRecognizer();

  Future<String> recognizeText(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final RecognizedText recognizedText =
        await _textRecognizer.processImage(inputImage);

    String extractedText = recognizedText.text;
    return extractedText;
  }

  void dispose() {
    _textRecognizer.close();
  }
}
