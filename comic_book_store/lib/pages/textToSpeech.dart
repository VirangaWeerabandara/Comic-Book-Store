import 'package:comic_book_store/components/button.dart';
import 'package:comic_book_store/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech extends StatefulWidget {
  final String text; // New required text argument
  final String? initialLanguage; // Optional initial language parameter

  const TextToSpeech(
      {super.key, required this.text, this.initialLanguage = 'en-US'});

  @override
  State<TextToSpeech> createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  final FlutterTts flutterTts = FlutterTts();

  Map<String, dynamic> languageMap = {
    'en-US': 'English',
    'es-ES': 'Spanish',
    'fr-FR': 'French',
    'de-DE': 'German',
    'it-IT': 'Italian',
    'ja-JP': 'Japanese',
    'ko-KR': 'Korean',
    'zh-CN': 'Chinese',
  };

  List<String> languages = [];
  String? selectedLanguage;
  double pitch = 1;
  double rate = 0.5;
  double volume = 0.5;

  @override
  void initState() {
    super.initState();
    initTts();
    selectedLanguage = widget.initialLanguage;
  }

  Future<void> initTts() async {
    try {
      List<dynamic> availableLanguages = await flutterTts.getLanguages;
      languages = availableLanguages
          .where((language) => languageMap.keys.contains(language))
          .map((language) => language as String)
          .toList();
      setState(() {});
    } catch (e) {
      print('Error fetching languages: $e');
    }
  }

  Future<void> speak() async {
    try {
      await flutterTts.setLanguage(selectedLanguage ?? 'en-US');
      await flutterTts.setPitch(pitch);
      await flutterTts.setSpeechRate(rate);
      await flutterTts.setVolume(volume);
      await flutterTts.speak(widget.text);
    } catch (e) {
      print('Error speaking: $e');
    }
  }

  Future<void> stop() async {
    try {
      await flutterTts.stop();
    } catch (e) {
      print('Error stopping: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text to Speech'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background, // This sets text and icon colors
        iconTheme: const IconThemeData(
            color: AppColors.background), // Explicitly set back button color
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Text to Speak: ${widget.text}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Language',
                ),
                items: languages.map((String language) {
                  return DropdownMenuItem<String>(
                    value: language,
                    child: Text(languageMap[language] ?? language),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLanguage = newValue;
                  });
                },
                value: selectedLanguage,
              ),
              SizedBox(height: 20),
              Text('Pitch: ${pitch.toStringAsFixed(2)}'),
              Slider(
                value: pitch,
                onChanged: (newPitch) {
                  setState(() {
                    pitch = newPitch;
                  });
                },
                min: 0.5,
                max: 2.0,
              ),
              Text('Rate: ${rate.toStringAsFixed(2)}'),
              Slider(
                value: rate,
                onChanged: (newRate) {
                  setState(() {
                    rate = newRate;
                  });
                },
                min: 0.1,
                max: 1.0,
              ),
              Text('Volume: ${volume.toStringAsFixed(2)}'),
              Slider(
                value: volume,
                onChanged: (newVolume) {
                  setState(() {
                    volume = newVolume;
                  });
                },
                min: 0.0,
                max: 1.0,
              ),
              Center(
                child: CustomButton(
                  text: 'Speak',
                  onPressed: speak,
                  width: 150,
                  height: 50,
                ),
              ),
              Center(
                child: CustomButton(
                  text: 'Stop',
                  onPressed: stop,
                  width: 150,
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
