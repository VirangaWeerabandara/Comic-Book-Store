class TextToSpeech {
  String _text;
  Audio _audio;

  TextToSpeech({
    required String text,
    required Audio audio,
  })  : _text = text,
        _audio = audio;

  String get text => _text;
  Audio get audio => _audio;

  set text(String text) {
    _text = text;
  }

  set audio(Audio audio) {
    _audio = audio;
  }

  Audio convertToAudio(String text) {
    return _audio;
  }

  void playAudio(Audio audio) {}
}

class Audio {}
