import 'dart:ui';

class OCR {
  Image _image;
  String _extractedText;

  OCR({
    required Image image,
    required String extractedText,
  })  : _image = image,
        _extractedText = extractedText;

  Image get image => _image;
  String get extractedText => _extractedText;

  set image(Image image) {
    _image = image;
  }

  set extractedText(String extractedText) {
    _extractedText = extractedText;
  }

  String extractTextFromImage(Image image) {
    return "Extracted text";
  }
}
