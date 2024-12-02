import 'dart:math';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ARModel extends StatefulWidget {
  final String arModel;

  const ARModel({super.key, required this.arModel});

  @override
  _ARModelState createState() => _ARModelState();
}

class _ARModelState extends State<ARModel> {
  late String arModel;

  @override
  void initState() {
    super.initState();
    arModel = widget.arModel;
  }

  String getRandomModel() {
    List<String> models = ['iron_man.glb', 'spider_man.glb', 'spider_gwen.glb'];
    final random = Random();
    int randomIndex = random.nextInt(models.length);
    return models[randomIndex];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Set the shape to circle
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                iconSize: 20,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        body: ModelViewer(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          src: 'assets/3d_models/$arModel',
          alt: 'A 3D model of an astronaut',
          ar: true,
          arModes: const ['scene-viewer', 'webxr', 'quick-look'],
          autoRotate: false,
          disableZoom: false,
        ),
      ),
    );
  }
}
