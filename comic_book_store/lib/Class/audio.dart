class Audio {
  String _audioUrl;

  Audio({required String audioUrl}) : _audioUrl = audioUrl;

  String get audioUrl => _audioUrl;

  set audioUrl(String audioUrl) {
    _audioUrl = audioUrl;
  }

  void play() {}
}
