import 'dart:ui';

class OCR {
  Image image;
  String extractedText;

  OCR({
    required this.image,
    required this.extractedText,
  });

  String extractTextFromImage(Image image) {
    return "Extracted text";
  }
}
