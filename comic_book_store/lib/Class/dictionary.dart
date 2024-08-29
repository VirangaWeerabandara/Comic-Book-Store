class Dictionary {
  String word;
  String definition;

  Dictionary({
    required this.word,
    required this.definition,
  });

  String searchWord(String word) {
    return "Definition of $word";
  }

  List<String> getSynonyms(String word) {
    return ["Synonym1", "Synonym2"];
  }
}
