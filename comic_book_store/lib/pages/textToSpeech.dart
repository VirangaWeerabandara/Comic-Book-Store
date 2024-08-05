import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:avatar_glow/avatar_glow.dart';

class TextToSpeech extends StatefulWidget {
  const TextToSpeech({super.key});

  @override
  State<TextToSpeech> createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  TextEditingController textController =
      TextEditingController(text: 'Write some text for speech');
  late FlutterTts flutterTts;
  double volumeRange = 0.5;
  double pitchRange = 1.0;
  double speechRange = 0.5;
  bool isSpeaking = false;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();

    flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  Future<void> play() async {
    if (textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter some text")),
      );
      return;
    }

    try {
      final languages = await flutterTts.getLanguages;
      print(languages);
      await flutterTts.setLanguage("en-US"); // Set to default language

      final voices = await flutterTts.getVoices;
      print(voices);
      await flutterTts.setVoice({
        "name": "en-us-x-sfg#male_1-local",
        "locale": "en-US"
      }); // Set to default voice

      await flutterTts.speak(textController.text);
      setState(() {
        isSpeaking = true;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> stop() async {
    await flutterTts.stop();
    setState(() {
      isSpeaking = false;
    });
  }

  Future<void> pause() async {
    await flutterTts.pause();
    setState(() {
      isSpeaking = false;
    });
  }

  Future<void> setVolume(double val) async {
    volumeRange = val;
    await flutterTts.setVolume(volumeRange);
    setState(() {});
  }

  Future<void> setPitch(double val) async {
    pitchRange = val;
    await flutterTts.setPitch(pitchRange);
    setState(() {});
  }

  Future<void> setSpeechRate(double val) async {
    speechRange = val;
    await flutterTts.setSpeechRate(speechRange);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: const Text(
          'Text To Speech App',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Container(
              width: 250,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: textController,
                maxLines: null,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Write some text',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            AvatarGlow(
              animate: isSpeaking,
              glowColor: Color.fromARGB(255, 177, 33, 243),
              child: Material(
                elevation: 10,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Color.fromARGB(255, 118, 80, 255),
                  child: Icon(
                    Icons.mic_none_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              endRadius: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  splashRadius: 40,
                  onPressed: play,
                  color: Colors.teal,
                  iconSize: 60,
                  icon: const Icon(Icons.play_circle),
                ),
                IconButton(
                  onPressed: stop,
                  color: Colors.red,
                  splashRadius: 40,
                  iconSize: 60,
                  icon: const Icon(Icons.stop_circle),
                ),
                IconButton(
                  onPressed: pause,
                  color: Colors.amber.shade700,
                  splashRadius: 40,
                  iconSize: 60,
                  icon: const Icon(Icons.pause_circle),
                ),
              ],
            ),
            Slider(
              max: 1,
              value: volumeRange,
              onChanged: setVolume,
              divisions: 10,
              label: "Volume: $volumeRange",
              activeColor: Colors.red,
            ),
            const Text('Set Volume'),
            Slider(
              max: 2,
              value: pitchRange,
              onChanged: setPitch,
              divisions: 10,
              label: "Pitch Rate: $pitchRange",
              activeColor: Colors.teal,
            ),
            const Text('Set Pitch'),
            Slider(
              max: 1,
              value: speechRange,
              onChanged: setSpeechRate,
              divisions: 10,
              label: "Speech rate: $speechRange",
              activeColor: Colors.amber.shade700,
            ),
            const Text('Set Speech Rate'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
