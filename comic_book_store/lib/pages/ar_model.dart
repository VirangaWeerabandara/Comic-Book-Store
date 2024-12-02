import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ARModel extends StatelessWidget {
  final String modelSrc;

  const ARModel({super.key, required this.modelSrc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ModelViewer(
          backgroundColor: const Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
          src: modelSrc,
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
