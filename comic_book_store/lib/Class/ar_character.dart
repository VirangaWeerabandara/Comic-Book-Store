import 'dart:ui';

class ARCharacter {
  String _characterID;
  Image _characterImage;

  ARCharacter({
    required String characterID,
    required Image characterImage,
  })  : _characterID = characterID,
        _characterImage = characterImage;

  String get characterID => _characterID;
  Image get characterImage => _characterImage;

  set characterID(String characterID) {
    _characterID = characterID;
  }

  set characterImage(Image characterImage) {
    _characterImage = characterImage;
  }

  void displayARCharacter() {}

  void interactWithARCharacter() {}
}
