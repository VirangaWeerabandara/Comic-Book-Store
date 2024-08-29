class Dictionary {
  String _word;
  String _definition;

  Dictionary({
    required String word,
    required String definition,
  })  : _word = word,
        _definition = definition;

  String get word => _word;
  String get definition => _definition;

  set word(String word) {
    _word = word;
  }

  set definition(String definition) {
    _definition = definition;
  }

  String searchWord(String word) {
    return "Definition of $word";
  }

  List<String> getSynonyms(String word) {
    return ["Synonym1", "Synonym2"];
  }
}
