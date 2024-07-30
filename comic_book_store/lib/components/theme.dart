import 'package:flutter/material.dart';

class Template extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final Widget theChild;

  const Template({
    required this.screenWidth,
    required this.screenHeight,
    required this.theChild,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ClipRRect(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            color: Colors.white,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: screenWidth,
                      height: screenHeight,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Center(child: theChild),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
