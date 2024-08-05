import 'package:comic_book_store/components/button.dart';
import 'package:comic_book_store/components/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech extends StatefulWidget {
  const TextToSpeech({super.key});

  @override
  State<TextToSpeech> createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textController = TextEditingController();

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
  }

  Future<void> initTts() async {
    List<dynamic> availableLanguages = await flutterTts.getLanguages;
    languages = availableLanguages
        .where((language) => languageMap.keys.contains(language))
        .map((language) => language as String)
        .toList();
    setState(() {});
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> speak() async {
    await flutterTts.setLanguage(selectedLanguage ?? 'en-US');
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setVolume(volume);
    await flutterTts.speak(textController.text);
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInputField(
              hintText: 'Enter text to speak',
              controller: textController,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
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
                width: 150, // Set the desired width
                height: 50, // Set the desired height
              ),
            ),
            Center(
              child: CustomButton(
                text: 'Stop',
                onPressed: stop,
                width: 150, // Set the desired width
                height: 50, // Set the desired height
              ),
            ),
          ],
        ),
      ),
    );
  }
}
