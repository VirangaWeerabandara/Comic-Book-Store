import 'package:flutter/material.dart';
import 'audio.dart';

class ComicBook {
  String comicID;
  String title;
  String author;
  double price;
  String genre;
  Image image;
  Audio audioVersion;

  ComicBook({
    required this.comicID,
    required this.title,
    required this.author,
    required this.price,
    required this.genre,
    required this.image,
    required this.audioVersion,
  });

  void playAudio() {
    audioVersion.play();
  }

  void viewARCharacter() {}

  String getDictionaryExplanation(String word) {
    return "Explanation of $word";
  }
}
